Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131508AbRCQCBL>; Fri, 16 Mar 2001 21:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131503AbRCQCBB>; Fri, 16 Mar 2001 21:01:01 -0500
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:39924 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S131508AbRCQCAt>; Fri, 16 Mar 2001 21:00:49 -0500
Message-ID: <3AB2C527.667F774D@bigfoot.com>
Date: Fri, 16 Mar 2001 18:00:07 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19pre17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael B. Allen" <mballen@erols.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: parport not detected
In-Reply-To: <20010316185253.A865@nano.foo.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The parallel port is not being detected on my ABIT KT7A KT133 w/ Athlon

Also try comp.os.linux.hardware.

BIOS
----
278/irq5
378/irq7
EPP 1.9

.config
-------
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PNP=y
CONFIG_PNP_PARPORT=y
CONFIG_PRINTER=y
CONFIG_PRINTER_READBACK=y

kernal boot params
------------------
append="parport=0x378,7 parport=0x278,5"

options for /etc/rc.d/rc.local
------------------------------
# abort on error, careful error check, trust IRQ.
# see tunelp(8) & /usr/src/linux/drivers/misc/lp.c

/usr/sbin/tunelp /dev/lp0 -a on -o on -T on
/usr/sbin/tunelp /dev/lp1 -a on -o on -T on

looks like this (lp1 was powered down at boot time)

Feb 25 02:57:39 dell kernel: parport0: PC-style at 0x378, irq 7
[SPP,PS2,EPP] 
Feb 25 02:57:39 dell kernel: parport0: Printer, Hewlett-Packard HP
LaserJet 1100 
Feb 25 02:57:39 dell kernel: parport1: PC-style at 0x278, irq 5
[SPP,PS2,EPP] 
Feb 25 02:57:39 dell kernel: parport1: no IEEE-1284 device present. 
Feb 25 02:57:40 dell kernel: lp0: using parport0 (interrupt-driven). 
Feb 25 02:57:40 dell kernel: lp1: using parport1 (interrupt-driven). 


--
