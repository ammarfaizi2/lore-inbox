Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbUKWNFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUKWNFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 08:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbUKWNDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 08:03:46 -0500
Received: from lucidpixels.com ([66.45.37.187]:45211 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261251AbUKWNCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 08:02:52 -0500
Date: Tue, 23 Nov 2004 08:02:50 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.9 Question w/4port Ethernet Card & MII Transceivers
Message-ID: <Pine.LNX.4.61.0411230759070.3740@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Question regarding the warnings, it appears to find a MII transceiver but 
then it warns saying it does not?

What does this mean?

Is it a problem?

If it is not using a HW tranceiver, does this cause a loss in performance?

Description:

eth0 = built-in 3com
eth[1-4] = adaptec 4 port nic

Output from lspci:

00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 24)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 
1X/2X (rev 5c)
02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 
[FasterNet] (rev 22)
02:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 
[FasterNet] (rev 22)
02:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 
[FasterNet] (rev 22)
02:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 
[FasterNet] (rev 22)

Checking /proc/interrupts:
# cat /proc/interrupts
            CPU0
   0:    1082113          XT-PIC  timer
   1:          8          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:          0          XT-PIC  Crystal audio controller
   8:          1          XT-PIC  rtc
   9:          0          XT-PIC  acpi
  11:       3624          XT-PIC  uhci_hcd, eth0, eth1, eth2, eth3, eth4
  12:         66          XT-PIC  i8042
  14:       2794          XT-PIC  ide0
  15:         18          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0
MIS:          0


Kernel 2.6.9 dmesg:

Linux Tulip driver version 1.1.13-NAPI (May 11, 2002)
ACPI: PCI interrupt 0000:02:04.0[A] -> GSI 11 (level, low) -> IRQ 11
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) 
block.
tulip0: ***WARNING***: No MII transceiver found!
eth1: Digital DS21140 Tulip rev 34 at 0xd4858c00, 00:00:D1:20:35:50, IRQ 
11.
ACPI: PCI interrupt 0000:02:05.0[A] -> GSI 11 (level, low) -> IRQ 11
tulip1:  Controller 1 of multiport board.
tulip1:  EEPROM default media type Autosense.
tulip1:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) 
block.
tulip1: ***WARNING***: No MII transceiver found!
eth2: Digital DS21140 Tulip rev 34 at 0xd485a800, EEPROM not present, 
00:00:D1:20:35:51, IRQ 11.
ACPI: PCI interrupt 0000:02:06.0[A] -> GSI 11 (level, low) -> IRQ 11
tulip2:  Controller 2 of multiport board.
tulip2:  EEPROM default media type Autosense.
tulip2:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) 
block.
tulip2: ***WARNING***: No MII transceiver found!
eth3: Digital DS21140 Tulip rev 34 at 0xd485c400, EEPROM not present, 
00:00:D1:20:35:52, IRQ 11.
ACPI: PCI interrupt 0000:02:07.0[A] -> GSI 10 (level, low) -> IRQ 10
tulip3:  Controller 3 of multiport board.
tulip3:  EEPROM default media type Autosense.
tulip3:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) 
block.
tulip3: ***WARNING***: No MII transceiver found!
eth4: Digital DS21140 Tulip rev 34 at 0xd485e000, EEPROM not present, 
00:00:D1:20:35:53, IRQ 11.
eth0: no IPv6 routers present
eth1: no IPv6 routers present
eth4: Setting full-duplex based on MII#1 link partner capability of 45e1.
eth2: no IPv6 routers present
eth4: no IPv6 routers present
eth3: no IPv6 routers present

