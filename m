Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbQLPP5I>; Sat, 16 Dec 2000 10:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130272AbQLPP46>; Sat, 16 Dec 2000 10:56:58 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:18953 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S129729AbQLPP4l>;
	Sat, 16 Dec 2000 10:56:41 -0500
Date: Sat, 16 Dec 2000 17:26:09 +0200 (EET)
From: Jani Monoses <jani@virtualro.ic.ro>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [patch] docbook fix kmod.c
Message-ID: <Pine.LNX.4.10.10012161725040.11062-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	kernel-api.tmpl references the exported functions of kmod.c but
there are none.This patch changes it to gather docs about the internal
functions instead and also adds a <sect1> so that jade doesn't complain
anymore about unfinished CHAPTER or something.

Jani.

--- /usr/src/linux/Documentation/DocBook/kernel-api.tmpl	Mon Dec  4 12:12:12 2000
+++ kernel-api.tmpl	Sat Dec 16 17:00:11 2000
@@ -94,7 +94,9 @@
 
   <chapter id="modload">
      <title>Module Loading</title>
-!Ekernel/kmod.c
+     <sect1><title>Kernel module loader</title>
+!Ikernel/kmod.c
+    </sect1>
   </chapter>
 
   <chapter id="hardware">

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
