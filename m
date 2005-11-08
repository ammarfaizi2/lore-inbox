Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbVKHUUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbVKHUUD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 15:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVKHUUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 15:20:03 -0500
Received: from hoppetossa.avesi.com ([208.239.169.21]:11730 "HELO
	hoppetossa.avesi.com") by vger.kernel.org with SMTP id S964892AbVKHUUA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 15:20:00 -0500
Subject: athlon x2 + 2.6.14 + SMP = fast clock
From: Christopher Mulcahy <cmulcahy@avesi.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 08 Nov 2005 15:40:17 -0500
Message-Id: <1131482417.21752.50.camel@jones>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am running 2.6.14 SMP on an dual-core athlon x2 3800.
The system clock runs at roughly twice normal speed.

'cat /proc/interrupts' returns:
           CPU0       CPU1       
  0:   30834589   31107050    IO-APIC-edge  timer
  1:        267      72633    IO-APIC-edge  i8042
  8:          0          0    IO-APIC-edge  rtc
 12:       8662    2216469    IO-APIC-edge  i8042
 15:      43599   10919362    IO-APIC-edge  ide1
 17:       1577     423629   IO-APIC-level  libata
 18:      61263   47314795   IO-APIC-level  ehci_hcd:usb1,
ohci_hcd:usb2, ohci_hcd:usb3
 19:       2026     485190   IO-APIC-level  eth0
 20:         54      14118   IO-APIC-level  ATI IXP
 21:          0          2   IO-APIC-level  acpi, ohci1394
NMI:       2611       3571 
LOC:   30969789   30969781 
ERR:        146
MIS:          0


On my other SMP systems ( admittedly 4-way 2.4.30 ) timer interrupts are
processed only by CPU0.

Perhaps unrelated, my kernel log is filled with these messages:
Nov 8 00:44:19 jones kernel: [301738.837187] APIC error on CPU0: 40(40)
Nov 8 00:44:19 jones kernel: [301738.849596] APIC error on CPU1: 40(40)
Nov 8 02:35:25 jones kernel: [305067.785826] APIC error on CPU0: 40(40)
Nov 8 02:35:25 jones kernel: [305067.808330] APIC error on CPU1: 40(40)
Nov 8 03:34:47 jones kernel: [306846.571532] APIC error on CPU0: 40(40)
Nov 8 03:34:47 jones kernel: [306846.598922] APIC error on CPU1: 40(40)
Nov 8 03:50:47 jones kernel: [307325.974012] APIC error on CPU0: 40(40)
Nov 8 03:50:47 jones kernel: [307326.002707] APIC error on CPU1: 40(40)
Nov 8 03:50:47 jones kernel: [307325.983997] APIC error on CPU0: 40(40)
Nov 8 03:50:47 jones kernel: [307326.012689] APIC error on CPU1: 40(40)

Not sure if this is relevant:
http://leaf.dragonflybsd.org/mailarchive/commits/2005-11/msg00038.html


If you want dmesg, .config or other, contact me off list, I am not
subscribed.

Chris


