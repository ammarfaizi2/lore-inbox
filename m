Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262246AbSJAUhc>; Tue, 1 Oct 2002 16:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262270AbSJAUhc>; Tue, 1 Oct 2002 16:37:32 -0400
Received: from mesatop.zianet.com ([216.234.192.105]:59920 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S262256AbSJAUhb>; Tue, 1 Oct 2002 16:37:31 -0400
Subject: 2.5.40 Oops on boot (ide_setup_dma+0x16)
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 01 Oct 2002 14:38:09 -0600
Message-Id: <1033504690.2358.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

After getting 2.5.40 (many thanks to John Bradford for his mirror),
I got this oops, identical to 2.5.39 with a fix to isapnp.c. This
post is to verify that this problem still exists in 2.5.40.

Oops info copied down by hand:

EIP is at ide_iomio_dma+0xa4/0x110

Call Trace:
[<c01e02e6>]ide_setup_dma+0x16/0x2a0
[<c01deb46>]ide_hwif_setup_dma+0xc6/0x100
[<c01deeca>]do_ide_setup_pci_device+0x18/0x60
[<c01def48>]ide_setup_pci_device+0x18/0x60
[<c0105030>]init+0x0/0x160
[<c010504c>]init+0x1c/0x160
[<c0105030>]init+0x0/0x160
[<c0105495>]kernel_thread_helper_0x5/0x10

This machine is a single PIII with Intel 82371AB PII4X chipset
and Promise PDC20262 disk controller.

My .config info was posted earlier here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103349300620391&w=2

I also recompiled without CONFIG_IDEDMA_PCI_AUTO
and without CONFIG_IDEDMA_AUTO and rebooted with the
same results as above.

Steven



