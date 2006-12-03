Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936661AbWLCEa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936661AbWLCEa6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 23:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936663AbWLCEa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 23:30:58 -0500
Received: from main.gmane.org ([80.91.229.2]:54915 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S936661AbWLCEa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 23:30:57 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: CD/DVD drive errors and lost ticks
Date: Sun, 3 Dec 2006 04:30:40 +0000 (UTC)
Message-ID: <loom.20061203T052147-81@post.gmane.org>
References: <45724DDA.1020007@scientia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 68.61.60.54 (Mozilla/5.0 (compatible; Konqueror/3.5; Linux) KHTML/3.5.5 (like Gecko))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Anton Mitterer <calestyo <at> scientia.net> writes:

> Dec  3 04:12:16 euler kernel: hdb: irq timeout: status=0xd0 { Busy }
> Dec  3 04:12:16 euler kernel: ide: failed opcode was: unknown
> Dec  3 04:12:16 euler kernel: hdb: DMA disabled
> Dec  3 04:12:16 euler kernel: hdb: ATAPI reset complete
> Dec  3 04:12:18 euler kernel: hdb: irq timeout: status=0x80 { Busy }
> Dec  3 04:12:18 euler kernel: ide: failed opcode was: unknown
> Dec  3 04:12:18 euler kernel: hdb: ATAPI reset complete
> Dec  3 04:20:05 euler kernel: warning: many lost ticks.
> Dec  3 04:20:05 euler kernel: Your time source seems to be instable or
> some driver is hogging interupts
> Dec  3 04:20:05 euler kernel: rip _spin_unlock_irqrestore+0x8/0x30
> Dec  3 04:51:49 euler kernel: hdb: irq timeout: status=0xd0 { Busy }
> Dec  3 04:51:49 euler kernel: ide: failed opcode was: unknown
> Dec  3 04:51:49 euler kernel: hdb: ATAPI reset complete
> Dec  3 04:51:51 euler kernel: hdb: irq timeout: status=0x80 { Busy }
> Dec  3 04:51:51 euler kernel: ide: failed opcode was: unknown
> Dec  3 04:51:51 euler kernel: hdb: ATAPI reset complete
> 
> Any idea what the reason is? Could it be the firmware? Or a hardware
> damage (if so which hardware is likely?)?
>
Kernel is having trouble with hdb (which seems to be your DVD drive.) After 
running into problems the kernel has disabled DMA on the drive and when it 
does that there is bound to be some problems with watching DVDs because the 
CPU is used for memory transfers as well as for watching the DVD (can't do 
both at a time without running into problems).

> And what is tha lost ticks? How would a defect DVD/CD drive has
> influence on the ticks (if that means CPU ticks).
> 

Lost ticks look like they are direct result of the problems with your DVD 
drive. 

If you post your kernel version, .config and hardware information (Which IDE 
controller specifically) some one will be able to look into the problem.

HTH
Parag

