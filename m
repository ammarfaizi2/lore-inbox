Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131462AbQLMOm1>; Wed, 13 Dec 2000 09:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131498AbQLMOmS>; Wed, 13 Dec 2000 09:42:18 -0500
Received: from chaos.ao.net ([205.244.242.21]:65294 "EHLO chaos.ao.net")
	by vger.kernel.org with ESMTP id <S131462AbQLMOmL>;
	Wed, 13 Dec 2000 09:42:11 -0500
Message-Id: <200012131411.eBDEBWo14000@vulpine.ao.net>
To: linux-kernel@vger.kernel.org
Subject: IDE hang when using v4l (bttv) on all kernels.
Date: Wed, 13 Dec 2000 09:11:31 -0500
From: Dan Merillat <harik@chaos.ao.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I've had this problem for a while now, reported it back in 2.3.x somewhere.
I havn't needed v4l so I ignored it.  Playing with my bttv again and having
a lot of trouble

After some (random) amount of frame grabs, my system loses.  Badly.
ethernet quits forwarding, IDE refuses to respond... All I can do is
switch VCs and watch errors scroll by.

This may be a chipset problem, although I've seen reference to others
having problems with this driver and IDE in the past.

Tested with v4l1/2 for all kernels up to 2.4.0-test12


Lockup still happens if IDE DMA is disabled.

Please Cc: me if you want any additional information, I read L-K via
the web archives.


spurious 8259A interrupt: IRQ7.
Failed to read 258048 bytes, got 0: Success
 ^^^^^ my v4l program.
ide_dmaproc: chipset supported ide_dma_losirq func only: 13
hda: lost interrupt
ide_dmaproc: chipset supported ide_dma_losirq func only: 13
hda: lost interrupt
<repeats forever>



harik@burned:~$ lspci
00:00.0 Host bridge: Intel Corporation 430FX - 82437FX TSC [Triton I] (rev 02)
00:07.0 ISA bridge: Intel Corporation 82371FB PIIX ISA [Triton I] (rev 02)
00:07.1 IDE interface: Intel Corporation 82371FB PIIX IDE [Triton I] (rev 02)
00:08.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium II]
00:09.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 21)
00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 21)
00:0b.0 Multimedia video controller: Brooktree Corporation Bt848 (rev 12)

--Dan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
