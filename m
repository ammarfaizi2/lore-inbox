Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264588AbUEJKVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264588AbUEJKVL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 06:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbUEJKVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 06:21:11 -0400
Received: from mail.genesys.ro ([193.230.224.5]:40112 "EHLO mail.genesys.ro")
	by vger.kernel.org with ESMTP id S264588AbUEJKVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 06:21:09 -0400
Message-ID: <409F57F1.2060803@genesys.ro>
Date: Mon, 10 May 2004 13:22:41 +0300
From: Silviu Marin-Caea <silviu@genesys.ro>
Organization: Genesys Software Romania [ http://www.genesys.ro ]
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a) Gecko/20040509
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Subject: Re: dynamic allocation of swap disk space
References: <33073.192.168.1.88.1084179033.squirrel@mail.genesys.ro> <200405101003.i4AA3uJt000135@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200405101003.i4AA3uJt000135@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:

>>The way I see the solution is: allocate swap space dynamically, until
>>there is no need for more or the disk becomes nearly full.  If that
>>happens, then start thrashing it, all right.  Then when the condition is
>>gone and things are back to normal deallocate the additional swap.
> 
> 
> Very bad idea in my opinion.

Most likely quite so, I'm not a guru yet :-)

> Over allocating swap space is a BAD practice, but the effects are usually not

How about dynamically allocating up to a certain limit.

Say, you have 256 MB or even less (to save space), and you allocate when 
needed up to 1 GB, then stop allocating, thrash disk, let the kernel 
detect and kill the runaway process.
