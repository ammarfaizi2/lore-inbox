Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317010AbSFAMVb>; Sat, 1 Jun 2002 08:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317011AbSFAMVa>; Sat, 1 Jun 2002 08:21:30 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:56502 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S317010AbSFAMVa>; Sat, 1 Jun 2002 08:21:30 -0400
From: Chris Rankin <cj.rankin@ntlworld.com>
Message-Id: <200206011221.g51CLULu000691@twopit.underworld>
Subject: Crazy nosmp IRQ assignments in 2.4.19-pre9-ac3??
To: linux-kernel@vger.kernel.org
Date: Sat, 1 Jun 2002 13:21:30 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just tried booting 2.4.19-pre9-ac3 (SMP, 1.25 GB, devfs) with the
"nosmp single" flags to try and debug a Firewire problem, and I found
this oddity in /proc/interrupts:

           CPU0       
  0:      28797          XT-PIC  timer
  1:        629          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          0          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 14:      10299          XT-PIC  ide0
 15:         26          XT-PIC  ide1
 16:          0            none  usb-ohci
 17:          0            none  ehci-hcd
 18:          0            none  ohci1394
 19:          0            none  usb-ohci, usb-uhci
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

Last time I booted an SMP kernel with "nosmp", there were no IRQs > 15
and all the PCI devices were remapped to 5,7,9,10,11 etc.

This doesn't look good...

Chris
