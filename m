Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVA1Bos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVA1Bos (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 20:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVA1Bos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 20:44:48 -0500
Received: from ernie.virtualdave.com ([198.216.116.246]:53256 "EHLO
	ernie.virtualdave.com") by vger.kernel.org with ESMTP
	id S261377AbVA1Bog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 20:44:36 -0500
Date: Thu, 27 Jan 2005 19:44:35 -0600 (CST)
From: David Sims <dpsims@virtualdave.com>
To: linux-kernel@vger.kernel.org
Subject: I need a hardware wizard... I have been beating my head on the wall..
Message-ID: <Pine.LNX.4.21.0501271929270.26803-100000@ernie.virtualdave.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I have posted a couple of times in the past to no avail... I have an
Intel 31244 SATA controller that is supposed to work with the sata_vsc
driver module... It does in fact, almost....

  You can insert the module in a running kernel and after barking as
follows (once for each disk attached) it runs just fine.

Jan 24 13:55:37 linux kernel: irq 3: nobody cared!
Jan 24 13:55:37 linux kernel: [<c0128972>] __report_bad_irq+0x22/0x90
Jan 24 13:55:37 linux kernel: [<c0128a68>] note_interrupt+0x58/0x90
Jan 24 13:55:37 linux kernel: [<c01285f8>] __do_IRQ+0xd8/0xe0
Jan 24 13:55:37 linux kernel: [<c0103a7a>] do_IRQ+0x1a/0x30
Jan 24 13:55:37 linux kernel: [<c010254a>] common_interrupt+0x1a/0x20
Jan 24 13:55:37 linux kernel: [<c0114fc0>] __do_softirq+0x30/0x90
Jan 24 13:55:37 linux kernel: [<c0115055>] do_softirq+0x35/0x40
Jan 24 13:55:37 linux kernel: [<c0103a7f>] do_IRQ+0x1f/0x30
Jan 24 13:55:37 linux kernel: [<c010254a>] common_interrupt+0x1a/0x20
Jan 24 13:55:37 linux kernel: [<c0100590>] default_idle+0x0/0x40
Jan 24 13:55:37 linux kernel: [<c01005b4>] default_idle+0x24/0x40
Jan 24 13:55:37 linux kernel: [<c010063e>] cpu_idle+0x2e/0x40
Jan 24 13:55:37 linux kernel: [<c03d277b>] start_kernel+0x15b/0x190

Jan 24 13:55:37 linux kernel: handlers:
Jan 24 13:55:37 linux kernel: [<c02471e0>] (ide_intr+0x0/0x120)
Jan 24 13:55:37 linux kernel: [<c02471e0>] (ide_intr+0x0/0x120)
Jan 24 13:55:37 linux kernel: [<e08ef250>] (vsc_sata_interrupt+0x0/0xa0
[sata_vsc])
Jan 24 13:55:37 linux kernel: Disabling IRQ #3


  The problem is that when you insert the module at boot time, the machine
just hangs while trying to enumerate the first disk.... Same when booting
with the module builtin to a monolithic kernel....

  To facilitate helping me, I have gathered the requisite stuff and posted
it on my website as follows:

   http://www.dpsims.com/~dpsims/31244/

  If someone would be so kind as to help me, I would be willing to provide
access to the machine in question for testing, etc... I believe the
problem is caused by the Intel 31244 having multiple ways of sending
interrupts... The Intel documentation is located at:

   http://www.dpsims.com/~dpsims/31244/31244_developers_guide.pdf

and I draw your attention to section 5.8 and 5.9.... The code for the
sata_vsc.c from kernel 2.6.10 can be found at

   http://www.dpsims.com/~dpsims/31244/sata_vsc.c

I would make this work myself if I had the required skill sets... but I
don't.... Thus I am reduced to pleading ;)

Please help me. I will try to contribute whatever I can... quickly
test.... /etc...

Dave

