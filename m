Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261728AbSJFRL6>; Sun, 6 Oct 2002 13:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261911AbSJFRLT>; Sun, 6 Oct 2002 13:11:19 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47876 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261955AbSJFRLK>; Sun, 6 Oct 2002 13:11:10 -0400
Subject: PATCH: 2.5.40 update docs to match maestro3 changes
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Sun, 6 Oct 2002 18:08:07 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yEsx-0001rd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/Documentation/sound/oss/Maestro3 linux.2.5.40-ac5/Documentation/sound/oss/Maestro3
--- linux.2.5.40/Documentation/sound/oss/Maestro3	2002-07-20 20:11:33.000000000 +0100
+++ linux.2.5.40-ac5/Documentation/sound/oss/Maestro3	2002-10-03 00:14:21.000000000 +0100
@@ -71,10 +71,18 @@
 tell the driver to print minimal debugging information as it runs.  This
 can be collected with 'dmesg' or through the klogd daemon.
 
-The other is 'external_amp', which tells the driver to attempt to enable
+One is 'external_amp', which tells the driver to attempt to enable
 an external amplifier.  This defaults to '1', you can tell the driver
 not to bother enabling such an amplifier by setting it to '0'.
 
+And the last is 'gpio_pin', which tells the driver which GPIO pin number
+the external amp uses (0-15), The Allegro uses 8 by default, all others 1.
+If everything loads correctly and seems to be working but you get no sound, 
+try tweaking this value. 
+
+Systems known to need a different value
+        Panasonic ToughBook CF-72: gpio_pin=13 
+
 Power Management
 ----------------
 
