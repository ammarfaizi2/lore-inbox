Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272268AbRIETLe>; Wed, 5 Sep 2001 15:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272270AbRIETLZ>; Wed, 5 Sep 2001 15:11:25 -0400
Received: from ns1.uklinux.net ([212.1.130.11]:265 "EHLO s1.uklinux.net")
	by vger.kernel.org with ESMTP id <S272269AbRIETLF>;
	Wed, 5 Sep 2001 15:11:05 -0400
Envelope-To: linux-kernel@vger.kernel.org
Date: Wed, 5 Sep 2001 19:57:08 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Tim Waugh <twaugh@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: PATCH : admit htmldocs exists in nano-HOWTO
Message-ID: <Pine.LNX.4.21.0109051952220.20371-100000@pppg_penguin.linux.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch updates the kernel doc nano HOWTO to inform readers that
htmldocs can be made directly, and documents one of the possible errors
that can be produced when miscoding comments for DocBook.

Applies cleanly to 2.4.10-pre4 and 2.4.9-ac6.

diff -urN linux-2.4.7/Documentation/kernel-doc-nano-HOWTO.txt altered-2.4.7/Documentation/kernel-doc-nano-HOWTO.txt
--- linux-2.4.7/Documentation/kernel-doc-nano-HOWTO.txt	Sun Jun  3 20:44:38 2001
+++ altered-2.4.7/Documentation/kernel-doc-nano-HOWTO.txt	Mon Aug 20 21:17:49 2001
@@ -35,9 +35,9 @@
 
 - Makefile
 
-  The targets 'sgmldocs', 'psdocs', and 'pdfdocs' are used to build
-  DocBook files, PostScript files, and PDF files in
-  Documentation/DocBook.
+  The targets 'sgmldocs', 'psdocs', 'pdfdocs', and 'htmldocs' are used
+  to build DocBook files, PostScript files, PDF files, and html files
+  in Documentation/DocBook.
 
 - Documentation/DocBook/Makefile
 
@@ -49,10 +49,11 @@
 
 If you just want to read the ready-made books on the various
 subsystems (see Documentation/DocBook/*.tmpl), just type 'make
-psdocs', or 'make pdfdocs', depending on your preference.  If you
-would rather read a different format, you can type 'make sgmldocs' and
-then use DocBook tools to convert Documentation/DocBook/*.sgml to a
-format of your choice (for example, 'db2html ...').
+psdocs', or 'make pdfdocs', or 'make htmldocs', depending on your 
+preference.  If you would rather read a different format, you can type 
+'make sgmldocs' and then use DocBook tools to convert 
+Documentation/DocBook/*.sgml to a format of your choice (for example, 
+'db2html ...' if 'make htmldocs' was not defined).
 
 If you want to see man pages instead, you can do this:
 
@@ -111,7 +112,9 @@
 (*)?*/
 
 The short function description cannot be multiline, but the other
-descriptions can be.
+descriptions can be (and they can contain blank lines). Avoid putting a
+spurious blank line after the function name, or else the description will
+be repeated!
 
 All descriptive text is further processed, scanning for the following special
 patterns, which are highlighted appropriately.

Ken
-- 
         If a six turned out to be nine, I don't mind.

         Home page : http://www.kenmoffat.uklinux.net

