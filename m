Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266627AbSL2OaX>; Sun, 29 Dec 2002 09:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266638AbSL2OaX>; Sun, 29 Dec 2002 09:30:23 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:62596 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S266627AbSL2OaW>;
	Sun, 29 Dec 2002 09:30:22 -0500
Date: Sun, 29 Dec 2002 15:37:18 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: tulip-users@lists.sourceforge.net,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: 21041 transmit timed out
Message-ID: <Pine.GSO.4.21.0212291526390.17067-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Apparently this problem is still present in 2.4.20. It's been many months ago I
saw it, though.

| NETDEV WATCHDOG: eth0: transmit timed out
| eth0: 21041 transmit timed out, status fc6908c5, CSR12 000051c8, CSR13 ffff0001, CSR14 ffffffff, resetting...
| eth0: 21143 100baseTx sensed media.
        ^^^^^^^^^^^^^^^
ifconfig down/up fixed the problem.

lspci output:

| 00:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 [Tulip Pass 3] (rev 21)
| 	Subsystem: D-Link System Inc DE-530+
| 	Flags: bus master, medium devsel, latency 0, IRQ 29
| 	I/O ports at 1080 [size=128]
| 	Memory at c1080000 (32-bit, non-prefetchable) [size=128]
| 	Expansion ROM at c11c0000 [disabled] [size=256K]

Driver startup output:

| Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
| PCI: Enabling device 00:04.0 (0000 -> 0003)
| tulip0: 21041 Media table, default media 0800 (Autosense).
| tulip0:  21041 media #0, 10baseT.
| tulip0:  21041 media #4, 10baseT-FDX.
| tulip0:  21041 media #1, 10base2.
| eth0: Digital DC21041 Tulip rev 33 at 0xc9855000, 21041 mode, 00:80:C8:5A:F8:5B, IRQ 29.

Machine is a PPC box (CHRP LongTrail).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

