Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265721AbTFNUfz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbTFNUfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:35:12 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:37354 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265728AbTFNUcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:32:05 -0400
Date: Sat, 14 Jun 2003 22:45:49 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Fix minor errors in input-programming.txt [12/13]
Message-ID: <20030614224549.K25997@ucw.cz>
References: <20030614223629.A25997@ucw.cz> <20030614223708.B25997@ucw.cz> <20030614223934.C25997@ucw.cz> <20030614224022.D25997@ucw.cz> <20030614224052.E25997@ucw.cz> <20030614224149.F25997@ucw.cz> <20030614224253.G25997@ucw.cz> <20030614224358.H25997@ucw.cz> <20030614224432.I25997@ucw.cz> <20030614224510.J25997@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030614224510.J25997@ucw.cz>; from vojtech@suse.cz on Sat, Jun 14, 2003 at 10:45:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1307.5.12, 2003-06-14 14:18:59+02:00, petero2@telia.com
  input: fix some minor errors found in the input-programming.txt file


 input-programming.txt |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

===================================================================

diff -Nru a/Documentation/input/input-programming.txt b/Documentation/input/input-programming.txt
--- a/Documentation/input/input-programming.txt	Sat Jun 14 22:24:22 2003
+++ b/Documentation/input/input-programming.txt	Sat Jun 14 22:24:22 2003
@@ -146,7 +146,7 @@
 Note the button_used variable - we have to track how many times the open
 function was called to know when exactly our device stops being used.
 
-The open() callback should return a 0 in case of succes or any nonzero value
+The open() callback should return a 0 in case of success or any nonzero value
 in case of failure. The close() callback (which is void) must always succeed.
 
 1.3 Basic event types
@@ -178,7 +178,7 @@
 function. Events are generated only for nonzero value. 
 
 However EV_ABS requires a little special care. Before calling
-input_register_devices, you have to fill additional fields in the input_dev
+input_register_device, you have to fill additional fields in the input_dev
 struct for each absolute axis your device has. If our button device had also
 the ABS_X axis:
 
@@ -207,11 +207,11 @@
 1.5 NBITS(), LONG(), BIT()
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-These three macros frin input.h help some bitfield computations:
+These three macros from input.h help some bitfield computations:
 
 	NBITS(x) - returns the length of a bitfield array in longs for x bits
 	LONG(x)  - returns the index in the array in longs for bit x
-	BIT(x)   - returns the indes in a long for bit x
+	BIT(x)   - returns the index in a long for bit x
 
 1.6 The number, id* and name fields
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -221,7 +221,7 @@
 in system messages.
 
 The dev->name should be set before registering the input device by the input
-device driver. It's a string like 'Generic button device' containing an
+device driver. It's a string like 'Generic button device' containing a
 user friendly name of the device.
 
 The id* fields contain the bus ID (PCI, USB, ...), vendor ID and device ID
@@ -237,7 +237,7 @@
 1.7 The keycode, keycodemax, keycodesize fields
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-These two fields will be used for any inpur devices that report their data
+These two fields will be used for any input devices that report their data
 as scancodes. If not all scancodes can be known by autodetection, they may
 need to be set by userland utilities. The keycode array then is an array
 used to map from scancodes to input system keycodes. The keycode max will
@@ -258,7 +258,7 @@
 
 The other event types up to now are:
 
-EV_LED - used for the keyboad LEDs.
+EV_LED - used for the keyboard LEDs.
 EV_SND - used for keyboard beeps.
 
 They are very similar to for example key events, but they go in the other
@@ -270,7 +270,7 @@
 
 int button_event(struct input_dev *dev, unsigned int type, unsigned int code, int value);
 {
-	if (type == EV_SND && code == EV_BELL) {
+	if (type == EV_SND && code == SND_BELL) {
 		outb(value, BUTTON_BELL);
 		return 0;
 	}
