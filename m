Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUI0JSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUI0JSj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 05:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbUI0JSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 05:18:23 -0400
Received: from port-222-152-48-85.fastadsl.net.nz ([222.152.48.85]:10112 "EHLO
	tornado.reub.net") by vger.kernel.org with ESMTP id S266539AbUI0JOK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 05:14:10 -0400
Message-Id: <6.1.2.0.2.20040927210918.019f5790@tornado.reub.net>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.2.0
Date: Mon, 27 Sep 2004 21:14:15 +1200
To: Ingo Molnar <mingo@elte.hu>
From: Reuben Farrelly <reuben-lkml@reub.net>
Subject: Re: Stack traces in 2.6.9-rc2-mm4
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <20040927085744.GA32407@elte.hu>
References: <6.1.2.0.2.20040927184123.019b48b8@tornado.reub.net>
 <20040927085744.GA32407@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:57 p.m. 27/09/2004, Ingo Molnar wrote:

>* Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> > Since upgrading from -mm3 to -mm4, I'm now getting messages like this
> > logged every second or so:
> >
> > Sep 27 18:28:06 tornado kernel: using smp_processor_id() in preemptible 
> code: swapper/1
> > Sep 27 18:28:06 tornado kernel:  [<c0104dce>] dump_stack+0x17/0x19
> > Sep 27 18:28:06 tornado kernel:  [<c0117fc6>] smp_processor_id+0x80/0x86
> > Sep 27 18:28:06 tornado kernel:  [<c0282bf3>] make_request+0x174/0x2e7
> > Sep 27 18:28:06 tornado kernel:  [<c02073dd>] 
> generic_make_request+0xda/0x190
>
>this is the remove-bkl patch's debugging feature showing that there's
>more preempt-unsafe disk statistics code in the RAID code.
>
>i've attached a patch that introduces preempt and non-preempt versions
>of the statistics code and updates the block code to use the appropriate
>ones - does this fix all the smp_processor_id() warnings you get?
>
>         Ingo

It certainly does, thanks muchly Ingo.

Reuben

