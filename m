Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266154AbRF2TBG>; Fri, 29 Jun 2001 15:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266155AbRF2TAz>; Fri, 29 Jun 2001 15:00:55 -0400
Received: from mail.primacom.net ([62.208.91.33]:57487 "EHLO mail.primacom.net")
	by vger.kernel.org with ESMTP id <S266154AbRF2TAj>;
	Fri, 29 Jun 2001 15:00:39 -0400
Message-ID: <3B3CD031.8935F64A@evision.ag>
Date: Fri, 29 Jun 2001 21:00:01 +0200
From: Martin Dalecki <dalecki@evision.ag>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI bridge setup error in linux-2.4.x (anyone of them)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ahve a PC box at hand, which ist containing 8 PCI slots.
Four of them are sitting behind a PCI bridge.
The error in the new kernel series is that during the
PCI bus setup if a card is sitting behind the bridge, it
will be miracelously detected TWICE. Once in front of the
bridge and once behind the bridge. The initialisation of
the card will then be entierly hossed.

This00:02.0 PCI bridge: Intel Corporation 80960RP [i960 RP
Microprocessor/Bridge] (rev 03)
00:02.1 I2O: Intel Corporation 80960RP [i960RP Microprocessor] (rev 03)
00:03.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 02)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
00:06.0 System peripheral: Hewlett-Packard Company NetServer Smart IRQ
Router (rev a0)
00:08.0 VGA compatible controller: Cirrus Logic GD 5446 (rev 45)
00:0f.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:0f.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:0f.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:0f.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:10.0 Host bridge: Intel Corporation 450NX - 82451NX Memory & I/O
Controller (rev 03)
00:12.0 Host bridge: Intel Corporation 450NX - 82454NX PCI Expander
Bridge (rev 02)
02:04.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 74)
oops:~ # 
 doesn't happen under linux-2.2.x kernel series.

Here is the output of lspci on this box after I moved the
card in front of the bridge:
