Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267611AbSIRTn6>; Wed, 18 Sep 2002 15:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267613AbSIRTn5>; Wed, 18 Sep 2002 15:43:57 -0400
Received: from smtp2.sooninternet.net ([212.246.17.84]:34267 "EHLO
	smtp2.sooninternet.net") by vger.kernel.org with ESMTP
	id <S267611AbSIRTn4>; Wed, 18 Sep 2002 15:43:56 -0400
Date: Wed, 18 Sep 2002 22:48:41 +0300
From: Kari Hameenaho <khaho@koti.soon.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.5.36 X freezes and input problems
Message-Id: <20020918224841.74cc56aa.khaho@koti.soon.fi>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Without preempt kernel does boot, but freeze after some use (less than minute) in X.

The last messages before hang are:
Sep 18 19:57:17 khaho kernel: MTRR: setting reg 1
Sep 18 19:57:20 khaho last message repeated 13 times

Previously  MTRR messages:
Sep 18 19:57:07 khaho kernel: mtrr: your CPUs had inconsistent fixed MTRR settings
Sep 18 19:57:07 khaho kernel: mtrr: probably your BIOS does not setup all CPUs

Disabling MTRR makes the system work, I am writing this mail on 2.5.36.  

MTRR (and everything else too) did work in this machine in 2.4.18*, 2.4.19*, 2.4.20-pre*, 2.4.20-pre*-ac* and in 2.5.x series at least upto 2.5.31.

-------------------------

New input drivers do also have some problems in this machine, mouse pointer 
jumping sometimes and focus then too. Keyboard and mouse with PS/2 connection, 
but wireless (Logitech Desktop Pro). 

Some messsages from those drivers too at boot time:
Sep 18 19:57:07 khaho kernel: mice: PS/2 mouse device common for all mice
Sep 18 19:57:07 khaho kernel: input: PS2++ Logitech Mouse on isa0060/serio1
Sep 18 19:57:07 khaho kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep 18 19:57:07 khaho kernel: input: AT Set 2 keyboard on isa0060/serio0
Sep 18 19:57:07 khaho kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
...
Sep 18 19:57:07 khaho kernel: psmouse.c: Received PS2++ packet #0, but don't know how to handle.
Sep 18 19:57:07 khaho kernel: psmouse.c: Received PS2++ packet #0, but don't know how to handle.

------------------------

System is MSI K7D Master-L Dual Athlon MPX with 2 MP 1900+ CPUs, 512 MB ECC RAM, 
3ware RAID controller and Matrox G550 display controller. 

Distribution is debian woody, so gcc is  "gcc version 2.95.4 20011002 (Debian prerelease)".  
XFree version is 4.1, but driver is from Matrox site. The original driver from debian did 
not work with G550.

-------------------------

Feel free to ask for more configuration details if you're interested.

---
Kari Hämeenaho
