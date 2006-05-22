Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWEVIpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWEVIpJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 04:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWEVIpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 04:45:09 -0400
Received: from mail.bmlv.gv.at ([193.171.152.37]:55990 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id S1750724AbWEVIpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 04:45:07 -0400
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation update
Date: Mon, 22 May 2006 10:45:20 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200605221045.21671.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The example is different from the description above, and a remark
for mode setting.



diff -u linux-source-2.6.14.orig/Documentation/fb/intelfb.txt linux-source-2.6.14/Documentation/fb/intelfb.txt
--- linux-source-2.6.14.orig/Documentation/fb/intelfb.txt   2005-10-28 02:02:08.000000000 +0200
+++ linux-source-2.6.14/Documentation/fb/intelfb.txt 2006-05-19 14:32:16.000000000 +0200
@@ -85,12 +85,20 @@

 In /etc/lilo.conf, add the line:

-append="video=intelfb:800x600-32@75,accel,hwcursor,vram=8"
+append="video=intelfb:mode=800x600-32@75,accel,hwcursor,vram=8"

 This will initialize the framebuffer to 800x600 at 32bpp and 75Hz. The
 framebuffer will use 8 MB of System RAM. hw acceleration of text and cursor
 will be enabled.

+Remarks
+-------
+
+If setting this parameter doesn't work (you stay in a 80x25 text-mode),
+you might need to set the "vga=<mode>" parameter too - see vesafb.txt
+in this directory.
+
+
 D.  Module options

        The module parameters are essentially similar to the kernel
