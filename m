Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265153AbTF1KaI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 06:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbTF1KaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 06:30:08 -0400
Received: from lucidpixels.com ([66.45.37.187]:44219 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S265182AbTF1KaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 06:30:01 -0400
Date: Sat, 28 Jun 2003 06:44:17 -0400 (EDT)
From: war <war@lucidpixels.com>
X-X-Sender: war@p500
To: linux-kernel@vger.kernel.org
cc: ap@solarrain.com
Subject: Broadcom Gigabit + Linux 2.4.20 - Error with polling.
Message-ID: <Pine.LNX.4.56.0306280640290.13092@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In dmesg, I get this on a board with onboard broadcom gbit ethernet.
The NIC is running at 100mbps.

root@l1:~_26 # uname -a
Linux l1 2.4.20 #6 Thu Jun 12 19:56:43 EDT 2003 i686 unknown unknown
GNU/Linux
root@l1:~_27 #

The description from dmesg:
eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:33MHz:32-bit)
10/100/1000BaseT

>From lspci:
00:0f.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702
Gigabit Ethernet (rev 02)
        Subsystem: Micro-Star International Co., Ltd.: Unknown device 730b
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 5
        Memory at dffb0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3
Enable-

tg3: eth0: Error, poll already scheduled
tg3: eth0: Error, poll already scheduled
tg3: eth0: Error, poll already scheduled
tg3: eth0: Error, poll already scheduled
tg3: eth0: Error, poll already scheduled
tg3: eth0: Error, poll already scheduled
tg3: eth0: Error, poll already scheduled

# dmesg | grep -c tg3
372

I haven't noticed any particular network problems from this message,
however, it certainy is not normal, anyone know what the cause of this
error is?


