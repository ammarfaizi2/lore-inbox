Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWCUTfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWCUTfj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWCUTfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:35:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50917 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964842AbWCUTfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:35:38 -0500
Date: Tue, 21 Mar 2006 11:35:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Sander <sander@humilis.net>
cc: Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
In-Reply-To: <20060321191547.GC20426@favonius>
Message-ID: <Pine.LNX.4.64.0603211132340.3622@g5.osdl.org>
References: <441F4F95.4070203@garzik.org> <200603210000.36552.lkml@rtr.ca>
 <20060321121354.GB24977@favonius> <442004E4.7010002@rtr.ca>
 <20060321153708.GA11703@favonius> <Pine.LNX.4.64.0603211028380.3622@g5.osdl.org>
 <20060321191547.GC20426@favonius>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Mar 2006, Sander wrote:
> 
> The kernel is compiled for x86-64 and SMP (dual core opteron), so if I
> understand the NMI watchdog documentation correctly, it is automagically
> enabled.

Yes.

In that case, the lockup is most probably really the PCI bus locking up 
due to some device not answering. Not a whole lot of debugging help from 
the kernel on things like that - you won't be able to get any information 
out of the system without a hardware reset which also tends to clear all 
memory ;(

> Is there anything else I can do to see some crash info?

Likely no. Not a lot to do but trying to figure out why the -mm tree works 
for you (if I recall correctly) by checking which patch breaks things..

> I was not able to let 2.6.16-rc6-mm2 crash yet.
> 
> I'll test 2.6.16-rc6-mm1 now.

Yup, narrowing down where exactly things go south is the way to do it.

		Linus
