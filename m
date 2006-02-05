Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751738AbWBEMwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbWBEMwq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 07:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbWBEMwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 07:52:46 -0500
Received: from math.ut.ee ([193.40.36.2]:30434 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1750790AbWBEMwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 07:52:45 -0500
Date: Sun, 5 Feb 2006 14:52:33 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: psmouse starts losing sync in 2.6.16-rc2
Message-ID: <Pine.SOC.4.61.0602051443460.17326@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.6.16-rc2 on a generic PC - Gigabyte 7ZXE mainboard with AMD 
Duron 1300, 896M RAM, PS2/keyboard, PS/2 mouse, ATA disk, 2 PCI NICs 
(rtl8139c), Matrox AGP Graphics, BT878 TV card. There were no psmouse 
probmes with up to 2.6.15. 2.6.16-rc1 not tested since iptables was 
broken.

PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input0
input: PC Speaker as /class/input/input1
input: ImExPS/2 Generic Explorer Mouse as /class/input/input2
[...]
psmouse.c: resync failed, issuing reconnect request
input: ImExPS/2 Generic Explorer Mouse as /class/input/input3
psmouse.c: resync failed, issuing reconnect request
input: ImExPS/2 Generic Explorer Mouse as /class/input/input4
psmouse.c: resync failed, issuing reconnect request
input: ImExPS/2 Generic Explorer Mouse as /class/input/input5

lsinput tells the following about the mouse:
/dev/input/event2
    bustype : BUS_I8042
    vendor  : 0x2
    product : 0x6
    version : 0
    name    : "ImExPS/2 Generic Explorer Mouse"
    phys    : "isa0060/serio1/input0"
    bits ev : EV_SYN EV_KEY EV_REL

IIRC it's a Microsoft mouse with 5 buttons and a scrollwheel.

I have no idea what actual acivity caused these messages - the machine 
was probably running movie playing with mplayer or tvtime during the 
time the messages appeared, with about 2 hours between them.

-- 
Meelis Roos (mroos@linux.ee)
