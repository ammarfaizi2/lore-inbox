Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUC1TAO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 14:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUC1TAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 14:00:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7386 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262374AbUC1TAG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 14:00:06 -0500
Message-ID: <406720A7.1050501@pobox.com>
Date: Sun, 28 Mar 2004 13:59:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>, William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403282045.07246.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Sunday 28 of March 2004 20:30, Jens Axboe wrote:
>>Making something user tunable is usually not the best idea, if you can
>>deduct these things automagically instead. So whether this is the best
>>idea, depends on which way you want to go.
> 
> 
> I think it's the best idea for now, long-term we are better with automagic.


Mostly agreed:

Like I mentioned in the last message, the IO scheduler and the VM should 
really just figure out request size and queue depth and such based on 
observation of device throughput and latency.  So I agree w/ automagic.

But the sysadmin should also be allowed to say "I don't care about 
latency" if he has gobs and gobs of memory and knows his configuration well.

I like generic tunables such as "laptop mode" or "low latency" or "high 
throughput".  These sorts of tunables should affect the "automagic" 
calculations.

	Jeff



