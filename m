Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267643AbTACUSS>; Fri, 3 Jan 2003 15:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267644AbTACUSS>; Fri, 3 Jan 2003 15:18:18 -0500
Received: from math.ut.ee ([193.40.5.125]:42899 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id <S267643AbTACUSR>;
	Fri, 3 Jan 2003 15:18:17 -0500
Date: Fri, 3 Jan 2003 22:26:48 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre2: HID & input dependencies
Message-ID: <Pine.GSO.4.44.0301032224190.5430-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current 2.4 (2.4.21-pre2+bk) allows me to configure input as modules and
then USB HID as compiled-in. The result is of course unresolved symbols.
Probably HID should depend on input in a better way.

drivers/usb/usbdrv.o(.text+0x11d2b): In function `hidinput_hid_event':
: undefined reference to `input_event'
drivers/usb/usbdrv.o(.text+0x11d9e): In function `hidinput_hid_event':
: undefined reference to `input_event'
drivers/usb/usbdrv.o(.text+0x11db0): In function `hidinput_hid_event':
: undefined reference to `input_event'
drivers/usb/usbdrv.o(.text+0x11def): In function `hidinput_hid_event':
: undefined reference to `input_event'
drivers/usb/usbdrv.o(.text+0x11e12): In function `hidinput_hid_event':
: undefined reference to `input_event'
drivers/usb/usbdrv.o(.text+0x11e30): more undefined references to `input_event' follow
drivers/usb/usbdrv.o(.text+0x12085): In function `hidinput_connect':
: undefined reference to `input_register_device'
drivers/usb/usbdrv.o(.text+0x120a3): In function `hidinput_disconnect':
: undefined reference to `input_unregister_device'
make: *** [vmlinux] Error 1


-- 
Meelis Roos (mroos@linux.ee)

