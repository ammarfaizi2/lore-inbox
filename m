Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314134AbSDLSLA>; Fri, 12 Apr 2002 14:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314135AbSDLSK7>; Fri, 12 Apr 2002 14:10:59 -0400
Received: from rover.ascpl.lib.oh.us ([199.218.0.2]:64960 "EHLO acorn.net")
	by vger.kernel.org with ESMTP id <S314134AbSDLSK6>;
	Fri, 12 Apr 2002 14:10:58 -0400
Date: Fri, 12 Apr 2002 14:10:44 -0400 (EDT)
From: Marcus Dennis <aa341@acorn.net>
To: linux-kernel@vger.kernel.org
cc: elenstev@mesatop.com, esr@thyrsus.com, marcelo@conectiva.com.br
Subject: [PATCH] docfix for 2.4.x Configure.help
Message-ID: <Pine.GSO.4.10.10204121350340.20151-100000@acorn.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies in advance if I've made an error in who this is Cc'd to.

Problem: Input core help is confusing wrt joysticks
Description:
The input core subsystem is necessary for 2.4 joystick support, even for
non-usb joysticks. "Joystick support" in "Input core support" mentions
only USB joysticks, but is necessary to have a jsX interface at all.
Fix:
The following patch modifies Configure.help's entry for "Input core
support" to state that it is required for any joysticks, and "Joystick
support" under it to remove the reference to USB.

Patch follows:

--- linux-2.4.18/Documentation/Configure.help.old	Thu Mar 21 12:51:16 2002
+++ linux-2.4.18/Documentation/Configure.help	Thu Mar 21 12:56:55 2002
@@ -12838,6 +12838,9 @@
   Say Y here if you want to enable any of the USB HID options in the
   USB support section which require Input core support.
 
+  Finally, say Y here and to Joystick Support below if you want to
+  support any joystick or gamepad.
+
   Otherwise, say N.
 
 Keyboard support
@@ -12882,7 +12885,7 @@
 
 Joystick support
 CONFIG_INPUT_JOYDEV
-  Say Y here if you want your USB HID joystick or gamepad to be
+  Say Y here if you want your joystick or gamepad to be
   accessible as char device 13:0+ - /dev/input/jsX device.
 
   This driver is also available as a module ( = code which can be

