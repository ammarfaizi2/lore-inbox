Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272922AbTHKSdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272824AbTHKSbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:31:51 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:27908 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S272980AbTHKSbV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:31:21 -0400
Date: Mon, 11 Aug 2003 19:31:19 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Cc: ivg2@cornell.edu
Subject: [PATCH] Document mounting of binfmt_misc
Message-ID: <20030811183119.GA27929@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19mHRv-000Ibv-RM*BYI8/SWSDxQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch by Ivan Gyurdiev. Please apply.

regards
john


diff -aur linux/Documentation/binfmt_misc.txt linux.new/Documentation/binfmt_misc.txt
--- linux/Documentation/binfmt_misc.txt	2003-07-27 19:34:57.749703952 -0400
+++ linux.new/Documentation/binfmt_misc.txt	2003-07-29 20:35:26.203488160 -0400
@@ -11,6 +11,9 @@
 bits) you have supplied. Binfmt_misc can also recognise a filename extension
 aka '.com' or '.exe'.
 
+First you must mount binfmt_misc:
+	mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc 
+
 To actually register a new binary type, you have to set up a string looking like
 :name:type:offset:magic:mask:interpreter: (where you can choose the ':' upon
 your needs) and echo it to /proc/sys/fs/binfmt_misc/register.
diff -aur linux/fs/Kconfig.binfmt linux.new/fs/Kconfig.binfmt
--- linux/fs/Kconfig.binfmt	2003-07-27 19:35:36.727778384 -0400
+++ linux.new/fs/Kconfig.binfmt	2003-07-29 20:37:07.336113664 -0400
@@ -111,6 +111,9 @@
 	  feature, and <file:Documentation/java.txt> for information about how
 	  to include Java support.
 
+          To use binfmt_misc, you will need to mount it:
+		mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
+
 	  You may say M here for module support and later load the module when
 	  you have use for it; the module is called binfmt_misc. If you
 	  don't know what to answer at this point, say Y.
