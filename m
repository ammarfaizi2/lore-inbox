Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271890AbTHHUaW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 16:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271892AbTHHUaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 16:30:22 -0400
Received: from news.cistron.nl ([62.216.30.38]:40203 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S271890AbTHHUaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 16:30:20 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: 2.6.0-test2-mm5: scheduler problem & apic
Date: Fri, 8 Aug 2003 20:30:19 +0000 (UTC)
Organization: Cistron
Message-ID: <bh118r$6ch$1@news.cistron.nl>
References: <200308081932.56347.alistair@devzero.co.uk>
X-Trace: ncc1701.cistron.net 1060374619 6545 62.216.30.38 (8 Aug 2003 20:30:19 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair J Strachan  <alistair@devzero.co.uk> wrote:
>Andrew, I don't know if anybody's given you any feedback regarding the nForce 
>2 APIC fix, but it appears to resolve the dead kernel problem, and I no 
>longer have problems with IRQ fallouts when using acpi, and I've removed 
>pci=noacpi from cmdline. ACPI and APIC now work together harmoniously.

I still occasionally see this behaviour:

New kernel install (booting from 2.6.0-test2 (vanilla)):

 EXT3-fs: mounted filesystem with ordered data mode.
 irq 19: nobody cared!
 Call Trace:
  [<c010be0a>] __report_bad_irq+0x32/0x90
  [<c010bee0>] note_interrupt+0x50/0x78
  [<c010c0e0>] do_IRQ+0xc0/0x124
  [<c0108dd0>] default_idle+0x0/0x34
  [<c0107000>] _stext+0x0/0x48
  [<c02819ec>] common_interrupt+0x18/0x20
  [<c0108dd0>] default_idle+0x0/0x34
  [<c0107000>] _stext+0x0/0x48
  [<c0108df9>] default_idle+0x29/0x34
  [<c0108e83>] cpu_idle+0x37/0x48
  [<c0107045>] _stext+0x45/0x48
  [<c032276b>] start_kernel+0x147/0x150
 handlers:
 [<c01f3b34>] (ide_intr+0x0/0x160)
 [<c01f3b34>] (ide_intr+0x0/0x160)
 Disabling IRQ #19
 hde: sata_error = 0x00400000, watchdog = 1, siimage_mmio_ide_dma_test_irq
 hdg: sata_error = 0x00400000, watchdog = 1, siimage_mmio_ide_dma_test_irq

powercycling the machine let the kernel boot without this notice (and normal
working). This is a newsgate machine with HT and sata.

Sounds familiar ?

Danny
-- 
I think so Brain, but why does a forklift 
have to be so big if all it does is lift forks?

