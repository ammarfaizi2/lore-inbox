Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTFZVqM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 17:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTFZVqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 17:46:11 -0400
Received: from web12304.mail.yahoo.com ([216.136.173.102]:5764 "HELO
	web12304.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262861AbTFZVqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 17:46:03 -0400
Message-ID: <20030626220016.27332.qmail@web12304.mail.yahoo.com>
Date: Thu, 26 Jun 2003 15:00:16 -0700 (PDT)
From: Mike Keehan <mike_keehan@yahoo.com>
Subject: Synaptics driver on HP6100 and 2.5.73
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The touchpad is recognised OK when the kernel boots,
and my usb
connected mouse works fine.  But I get the following
message in
the syslog when I try to use the mousepad or any of
the buttons :-

    ... kernel: Synaptics driver lost sync at 1st byte

It worked alright in previous kernels before the
Synaptic driver was
added.

Relevant /var/log/dmesg content:-

 drivers/usb/core/usb.c: registered new driver hid
 drivers/usb/input/hid-core.c: v2.0:USB HID core
driver
 mice: PS/2 mouse device common for all mice
 synaptics reset failed
 synaptics reset failed
 synaptics reset failed
 Synaptics Touchpad, model: 1
  Firware: 5.8
  180 degree mounted touchpad
  Sensor: 27
  new absolute packet format
  Touchpad has extended capability bits
  -> four buttons
  -> multifinger detection
  -> palm detection
 input: Synaptics Synaptics TouchPad on isa0060/serio1
 serio: i8042 AUX port at 0x60,0x64 irq 12
 input: AT Set 2 keyboard on isa0060/serio0
 serio: i8042 KBD port at 0x60,0x64 irq 1

and /var/log/XFree86.0.log bits:-

 (II) LoadModule: "synaptics"
 (II) Loading
/usr/X11R6/lib/modules/input/synaptics_drv.o
 (II) Module synaptics: vendor="The XFree86 Project"
         compiled for 4.2.0, module version = 1.0.0
         Module class: XFree86 XInput Driver
         ABI class: XFree86 XInput driver, version 0.3
...
 (II) LoadModule: "mouse"
 (II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
 (II) Module mouse: vendor="The XFree86 Project"
         compiled for 4.2.1.1, module version = 1.0.0
         Module class: XFree86 XInput Driver
         ABI class: XFree86 XInput driver, version 0.3
 (II) LoadModule: "synaptics"
 (II) Reloading
/usr/X11R6/lib/modules/input/synaptics_drv.o
...
 (II) Initializing built-in extension RENDER
 (**) Option "Protocol" "imps/2"
 (**) Mouse0: Protocol: "imps/2"
 (**) Option "CorePointer"
 (**) Mouse0: Core Pointer
 (**) Option "Device" "/dev/input/mouse0"
 (**) Option "ZAxisMapping" "4 5"
 (**) Mouse0: ZAxisMapping: buttons 4 and 5
 (**) Mouse0: Buttons: 5
 (**) Option "Device" "/dev/input/mouse1"
 (EE) xf86OpenSerial: Cannot open device
/dev/input/mouse1
         No such device.
 Synaptics driver unable to open device
 (EE) PreInit failed for input device "Mouse1"
 (II) UnloadModule: "synaptics"

Other device names I tries were /dev/input/mice,
/dev/event/event0
and /dev/psaux, but none of them work.

Mike.

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
