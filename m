Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTFHUmg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 16:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbTFHUmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 16:42:36 -0400
Received: from 4.54.252.64.snet.net ([64.252.54.4]:14294 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S263786AbTFHUme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 16:42:34 -0400
Message-ID: <3EE3BAAF.7000008@blue-labs.org>
Date: Sun, 08 Jun 2003 18:37:35 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030527
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: USB burps with irq XX: nobody cared. (2.5.70)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is one of those systems that has some 150K of dmesg on boot due to 
that pesky USB barfing - IRQ XX nobody cared!.

Due to it's size I haven't included it here.  Here's a link to it 
however - http://blue-labs.org/~david/dmesg.out.2.5.70.bz2

(There are a lot of unknown devices in lspci output, if an interested 
party wants, I'll provide as much detail as I can.)

David

# lspci -v|grep -A5 USB
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a3) (prog-if 10 [OHCI])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9042
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 20
        Memory at ee087000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a3) (prog-if 10 [OHCI])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9042
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 22
        Memory at ee082000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a3) (prog-if 20 [EHCI])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9042
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 20
        Memory at ee083000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] #0a [2080]
        Capabilities: [80] Power Management version 2
# grep -i hci /boot/2.5.70/.config
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_UHCI_HCD is not set
 

