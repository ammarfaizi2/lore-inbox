Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTKWLlT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 06:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTKWLlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 06:41:19 -0500
Received: from attila.bofh.it ([213.92.8.2]:61639 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S263357AbTKWLlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 06:41:17 -0500
Date: Sun, 23 Nov 2003 12:40:55 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Len Brown <len.brown@intel.com>, Andi Kleen <ak@muc.de>
Subject: Re: irq 15: nobody cared! with KT600 chipset and 2.6.0-test9
Message-ID: <20031123114055.GA1844@wonderland.linux.it>
References: <20031123021537.GA1816@wonderland.linux.it> <Pine.LNX.4.44.0311221902340.2379-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311221902340.2379-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 23, Linus Torvalds <torvalds@osdl.org> wrote:

 >Marco, can you try this appended (very very stupid) patch with ACPI on, so
 >that we can see where irq15 gets registered? It won't fix anything, but 
 >I'm confused by why IRQ 15 has been registered before we probe for it..

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IRQ probe failed (0x3cfa: 0). Guessing at 15
hdc: CD-ROM 50X, ATAPI CD/DVD-ROM drive
hdd: 32X10, ATAPI CD/DVD-ROM drive
Badness in request_irq at arch/i386/kernel/irq.c:572
Call Trace:
 [<c021a770>] ide_intr+0x0/0x130
 [<c010acfc>] request_irq+0xcc/0x100
 [<c021bce6>] init_irq+0x156/0x400
 [<c021a770>] ide_intr+0x0/0x130
 [<c021c376>] hwif_init+0xb6/0x250
 [<c021b9ac>] probe_hwif_init+0x2c/0x80
 [<c022769a>] ide_setup_pci_device+0x7a/0x80
 [<c021906d>] via_init_one+0x3d/0x50
 [<c039791d>] ide_scan_pcidev+0x5d/0x70
 [<c0397976>] ide_scan_pcibus+0x46/0xd0
 [<c0397823>] probe_for_hwifs+0x13/0x20
 [<c0397838>] ide_init_builtin_drivers+0x8/0x20
 [<c0397898>] ide_init+0x48/0x70
 [<c038674b>] do_initcalls+0x2b/0xa0
 [<c01278f2>] init_workqueues+0x12/0x60
 [<c0105097>] init+0x27/0x110
 [<c0105070>] init+0x0/0x110
 [<c01072a9>] kernel_thread_helper+0x5/0xc

irq 15: nobody cared!
[...]

-- 
ciao, |
Marco | [3234 aln71JMBJj/2g]
