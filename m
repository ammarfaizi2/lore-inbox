Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbUCROCy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 09:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUCROCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 09:02:51 -0500
Received: from sabe.cs.wisc.edu ([128.105.6.20]:6407 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S262645AbUCROCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 09:02:47 -0500
Message-ID: <4059AC00.6020409@cs.wisc.edu>
Date: Thu, 18 Mar 2004 06:02:40 -0800
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2][RFC] add detailed error values to block layer
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw that the Adaptec RAID developers are in need of detailed IO
error values too, so I wanted to post what I have so we can try to
work together. I have converted the block layer, but have not finished
the end request callers.

01-ec-core.patch just defines the error values, and modifies the request
completion functions. Right now they just convert the uptodate status to
an error value. Per Jeff's advice I did not define my own erronos.
wrt his other comment, I was not sure if wanted me to print the error
value in string form in __end_that_request, or just print the numerical
value.

02-ec-bioendio.patch converts the bio_endio and bi_end_io
callers to pass one of the error values defined above instead of
the -Exxx.

Both patches were built against 2.6.5-rc1.

The block layer error values are not too exciting. There were very few
drivers that did not just return EIO. The end request users
will be much more fun :)

Thanks,

Mike Chrisite




