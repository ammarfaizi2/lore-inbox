Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVG1WVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVG1WVZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 18:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVG1WVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 18:21:25 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:54199 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S261582AbVG1WUK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 18:20:10 -0400
Message-ID: <42E95A0B.4060509@blue-labs.org>
Date: Thu, 28 Jul 2005 18:19:55 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8b2) Gecko/20050509 Mnenhy/0.7.2.0
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: quick question; did usb hid change from .12 to .13-rc3 on x86_64?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've a quick question before I start digging through patches between .12 
and .13-rc3, /dev/input/mice (usb mice) stopped yielding data.  dmesg 
indicates removal/re-insertion of the device but no driver registers and 
nothing comes from /dev/input/mice.

I have rc-3 on other machines and the mouse is working fine, so it's got 
to be something specific to this machine.  It's an AMD64 machine.

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600 motherboard
        Flags: bus master, medium devsel, latency 64, IRQ 201
        I/O ports at b400 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600 motherboard
        Flags: bus master, medium devsel, latency 64, IRQ 201
        I/O ports at b800 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600 motherboard
        Flags: bus master, medium devsel, latency 64, IRQ 201
        I/O ports at c000 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600 motherboard
        Flags: bus master, medium devsel, latency 64, IRQ 201
        I/O ports at c400 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) 
(prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. A7V600 motherboard
        Flags: bus master, medium devsel, latency 64, IRQ 201
        Memory at fdf00000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2


Scott ~ # zcat /proc/config.gz|egrep -i "^CON.*(_hid|mouse)"
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_IDMOUSE=y

2.6.12:
usb 3-2: USB disconnect, address 2
usb 3-2: new low speed USB device using uhci_hcd and address 3
midi: probe of 3-2:1.0 failed with error -5
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:10.1-2

2.6.13-rc3
usb 3-2: USB disconnect, address 2
usb 3-2: new low speed USB device using uhci_hcd and address 3
midi: probe of 3-2:1.0 failed with error -5

david

