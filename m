Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267270AbTAKQPS>; Sat, 11 Jan 2003 11:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267271AbTAKQPS>; Sat, 11 Jan 2003 11:15:18 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:20656 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267270AbTAKQPR>; Sat, 11 Jan 2003 11:15:17 -0500
Message-Id: <200301111624.h0BGO9nY003599@eeyore.valparaiso.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.21-pre3 (bk from 20030110): Trident sound (ALi M5451) doesn't work
Date: Sat, 11 Jan 2003 17:24:09 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a Toshiba Satellite 1800 notebook, RH 8.0. lspci says:

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1644/M1644T Northbridge+Trident (rev 01)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] PCI to AGP Controller
00:02.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 03)00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3)
00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI AC-Link Controller Audio Device (rev 01)
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
00:0a.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
00:11.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade XPAi1 (rev 82)

Trying to modprobe trident by hand gives:

Jan 11 17:07:56 eeyore kernel: Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version 0.14.10h, 15:40:57 Jan 10 2003
Jan 11 17:07:56 eeyore kernel: PCI: Found IRQ 11 for device 00:06.0
Jan 11 17:07:56 eeyore kernel: trident: ALi Audio Accelerator found at IO 0x1000, IRQ 11
Jan 11 17:07:56 eeyore kernel: ALi 5451 did not come out of reset.
Jan 11 17:07:56 eeyore kernel: trident_ac97_init: error resetting 5451.
Jan 11 17:07:56 eeyore insmod: /lib/modules/2.4.21-pre3/kernel/drivers/sound/trident.o: init_module: No such device
Jan 11 17:07:56 eeyore insmod: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.       You may find more information in syslog or the output from dmesg
Jan 11 17:07:56 eeyore insmod: /lib/modules/2.4.21-pre3/kernel/drivers/sound/trident.o: insmod sound-slot-0 failed
Jan 11 17:07:56 eeyore modprobe: modprobe: Can't locate module sound-service-0-3
--
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
