Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbULSK6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbULSK6j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 05:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbULSK6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 05:58:39 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:6542 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S261286AbULSK6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 05:58:37 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: linux-kernel@vger.kernel.org
Subject: Might be memory leak with some 2.6.9 SATA or tigon3 drivers
Date: Sun, 19 Dec 2004 10:37:00 GMT
Message-ID: <04I6ITO12@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some Dell Optiplex gx280 where the total available memory shrinks from
roughly 800 MB to 600 MB after several days up (these boxes are on medium load).
It did append both with 2.6.8 and 2.6.9 kernel.
I had no such problem with the same kernels on the Dell Optiplex sx270.
No swaping enabled on any of the machines, and no kernel error message report.

The main difference between the two is that the sx270 use ATA and Intel
gigabit lan, and the gx280 use SATA and tigon3 gigabit lan.
At kernel configuration level, only disk and network drivers are different.

SX270 hardware content report:

8086 	Intel Corporation 	2570 	82865G/PE/P, 82848P 	0 		DRAM Controller / Host-Hub Interface
8086 	Intel Corporation 	2572 	82865G 	10 		Integrated Graphics Device
8086 	Intel Corporation 	24D2 	82801EB/ER 	10 		USB UHCI Controller #1
8086 	Intel Corporation 	24D7 	82801EB/ER 	12 		USB UHCI Controller #3
8086 	Intel Corporation 	24DE 	82801EB/ER 	10 		USB UHCI Controller #4
8086 	Intel Corporation 	24DD 	82801EB/ER 	17 		USB EHCI Controller
8086 	Intel Corporation 	244E 	82801BA/CA/DB, 6300ESB 	0 		Hub Interface to PCI Bridge
8086 	Intel Corporation 	24D0 	82801EB/ER 	0 		LPC Interface Bridge
8086 	Intel Corporation 	24DB 	82801EB/ER 	12 		EIDE Controller
8086 	Intel Corporation 	24D3 	82801EB/ER 	11 		SMBus Controller
8086 	Intel Corporation 	24D5 	82801EB/ER 	11 		AC'97 Audio Controller
8086 	Intel Corporation 	100E 	82540EM 	12 		Gigabit Ethernet Controller

GX280 hardware content report:

8086 	Intel Corporation 	2580 	915G/P/GV 	0 		Host Bridge / DRAM Controller
8086 	Intel Corporation 	2581 	915G/P/GV, 925X/XE? 	10 		Host-PCI Express Bridge
8086 	Intel Corporation 	2582 	82915G 	10 		Graphics device
8086 	Intel Corporation 	2782 		0 		
8086 	Intel Corporation 	2660 	82801FB/FR/FW/FRW 	10 		PCI Express Port 1
8086 	Intel Corporation 	2662 	82801FB/FR/FW/FRW 	11 		PCI Express Port 2
8086 	Intel Corporation 	2658 	82801FB/FR/FW/FRW 	15 		USB UHCI Controller
8086 	Intel Corporation 	2659 	82801FB/FR/FW/FRW 	16 		USB UHCI Controller
8086 	Intel Corporation 	265A 	82801FB/FR/FW/FRW 	12 		USB UHCI Controller
8086 	Intel Corporation 	265B 	82801FB/FR/FW/FRW 	17 		USB UHCI Controller
8086 	Intel Corporation 	265C 	82801FB/FR/FW/FRW 	15 		USB 2.0 EHCI Controller
8086 	Intel Corporation 	244E 	82801BA/CA/DB/DBL/Ex/Fx/FRW, 6300ESB 	0 		Hub Interface to PCI Bridge
8086 	Intel Corporation 	266E 	82801FB/FR/FW/FRW 	17 		AC '97 Audio Controller
8086 	Intel Corporation 	2640 	82801FB/FR 	0 		LPC Interface Bridge
8086 	Intel Corporation 	266F 		10 		
8086 	Intel Corporation 	2651 	82801FB/FW 	14 		SATA Controller
8086 	Intel Corporation 	266A 	82801FB/FR/FW/FRW 	11 		SMBus Controller
14E4 	Broadcom Corporation 	1677 	BCM5751 	10 		NetXtreme Gigabit Ethernet PCI Express
