Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264100AbTHZOTz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 10:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbTHZOTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 10:19:52 -0400
Received: from m94.net81-67-11.noos.fr ([81.67.11.94]:50847 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S264100AbTHZORv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 10:17:51 -0400
Date: Tue, 26 Aug 2003 16:17:50 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2.6.0-test4] meye driver update
Message-ID: <20030826141750.GD9046@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In order to bring the 2.4 and 2.6 versions in sync, here is the
missing bit for the meye driver :)

Now I need to go read the sysfs docs for the XXth time and try to
understand why videodev suddenly decided 'meye' needs yet another 
release callback... :(

Meanwhile, Linus, please apply.

Stelian.

===== Documentation/video4linux/meye.txt 1.6 vs edited =====
--- 1.6/Documentation/video4linux/meye.txt	Tue Feb 18 12:32:29 2003
+++ edited/Documentation/video4linux/meye.txt	Fri Aug  1 12:47:51 2003
@@ -16,6 +16,23 @@
 
 MJPEG hardware grabbing is supported via a private API (see below).
 
+Hardware supported:
+-------------------
+
+This driver supports the 'second' version of the MotionEye camera :)
+
+The first version was connected directly on the video bus of the Neomagic
+video card and is unsupported.
+
+The second one, made by Kawasaki Steel is fully supported by this 
+driver (PCI vendor/device is 0x136b/0xff01)
+
+The third one, present in recent (more or less last year) Picturebooks
+(C1M* models), is not supported. The manufacturer has given the specs
+to the developers under a NDA (which allows the develoment of a GPL
+driver however), but things are not moving very fast (see
+http://r-engine.sourceforge.net/) (PCI vendor/device is 0x10cf/0x2011).
+
 Driver options:
 ---------------
 
-- 
Stelian Pop <stelian@popies.net>
