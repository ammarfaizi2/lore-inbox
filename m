Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267219AbTBLPZf>; Wed, 12 Feb 2003 10:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267229AbTBLPZf>; Wed, 12 Feb 2003 10:25:35 -0500
Received: from CPEdeadbeef0000-CM400026342639.cpe.net.cable.rogers.com ([24.114.185.204]:772
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S267219AbTBLPZd>; Wed, 12 Feb 2003 10:25:33 -0500
Date: Wed, 12 Feb 2003 10:36:16 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Adam Belay <ambx1@neo.rr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.4.20][2.5.60] /proc/interrupts comparsion - two irqs for i8042?
Message-ID: <Pine.LNX.4.44.0302121035420.147-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4:
           CPU0
  0:    2576292          XT-PIC  timer
  1:        661          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:         10          XT-PIC  serial
  5:    1104824          XT-PIC  soundblaster
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:          7          XT-PIC  aic7xxx
 11:      15167          XT-PIC  usb-uhci, eth0
 14:       7554          XT-PIC  ide0
 15:          3          XT-PIC  ide1

2.5:

           CPU0
  0:      36281          XT-PIC  timer
  1:         15          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:        149          XT-PIC  serial
  5:          0          XT-PIC  soundblaster
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:         20          XT-PIC  aic7xxx
 11:        324          XT-PIC  uhci-hcd, eth0
 12:         60          XT-PIC  i8042 <--???
 14:        723          XT-PIC  ide0
 15:          9          XT-PIC  ide1
NMI:          0
LOC:      35547
ERR:          0
MIS:          0

Interesting, why are we using two interrupts for the i8042 (keyboard).

Shawn.

