Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbUC2E6P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 23:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbUC2E6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 23:58:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55434 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262647AbUC2E6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 23:58:11 -0500
Message-ID: <4067ACD4.7070203@pobox.com>
Date: Sun, 28 Mar 2004 23:57:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random>
In-Reply-To: <20040329005502.GG3039@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> is beneficial at all, and your bootup log showing 32M is all but
> exciting, I'd be a lot more excited to see 512k there.


Just to clarify...   32MB would never ever be reached.  The S/G table 
limit means requests are limited to 8MB.  VM thresholds and user 
application use further limit request size.

I think Andrew's point is actually more relevant than examining the size 
of a single request:

> 	the effect of really big requests will be the same
> 	as the effect of permitting _more_ requests. 

Thus like the "1,000 disks" example, memory management needs to make 
sure that an "unreasonable" amount of memory is not being pinned.

	Jeff



