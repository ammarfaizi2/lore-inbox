Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312325AbSCYHxS>; Mon, 25 Mar 2002 02:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312335AbSCYHxI>; Mon, 25 Mar 2002 02:53:08 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:24014 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S312325AbSCYHw6>; Mon, 25 Mar 2002 02:52:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.7 Documentation/Docbook/
Date: Mon, 25 Mar 2002 08:53:11 +0100
X-Mailer: KMail [version 1.3.9]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200203250853.11563@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes references to files formerly located in drivers/sound. Now
e.g. make psdocs works again.

Eike

diff -Nau linux-2.5.7-vanilla/Documentation/DocBook/Makefile linux-2.5.7/Documentation/DocBook/Makefile
--- linux-2.5.7-vanilla/Documentation/DocBook/Makefile	Mon Mar 18 21:37:14 2002
+++ linux-2.5.7/Documentation/DocBook/Makefile	Sun Mar 24 20:44:25 2002
@@ -59,8 +59,8 @@
 	$(TOPDIR)/scripts/docgen $(TOPDIR)/drivers/net/wan/z85230.c \
 		<z8530book.tmpl >z8530book.sgml
 
-via-audio.sgml: via-audio.tmpl $(TOPDIR)/drivers/sound/via82cxxx_audio.c
-	$(TOPDIR)/scripts/docgen $(TOPDIR)/drivers/sound/via82cxxx_audio.c \
+via-audio.sgml: via-audio.tmpl $(TOPDIR)/sound/oss/via82cxxx_audio.c
+	$(TOPDIR)/scripts/docgen $(TOPDIR)/sound/oss/via82cxxx_audio.c \
 		<via-audio.tmpl >via-audio.sgml
 
 tulip-user.sgml: tulip-user.tmpl
@@ -100,8 +100,8 @@
 		$(TOPDIR)/drivers/hotplug/pci_hotplug_core.c \
 		$(TOPDIR)/drivers/hotplug/pci_hotplug_util.c \
 		$(TOPDIR)/drivers/block/ll_rw_blk.c \
-		$(TOPDIR)/drivers/sound/sound_core.c \
-		$(TOPDIR)/drivers/sound/sound_firmware.c \
+		$(TOPDIR)/sound/sound_core.c \
+		$(TOPDIR)/sound/sound_firmware.c \
 		$(TOPDIR)/drivers/net/wan/syncppp.c \
 		$(TOPDIR)/drivers/net/wan/z85230.c \
 		$(TOPDIR)/drivers/usb/hcd.c \
diff -Nau linux-2.5.7-vanilla/Documentation/DocBook/kernel-api.tmpl linux-2.5.7/Documentation/DocBook/kernel-api.tmpl
--- linux-2.5.7-vanilla/Documentation/DocBook/kernel-api.tmpl	Mon Mar 18 21:37:02 2002
+++ linux-2.5.7/Documentation/DocBook/kernel-api.tmpl	Sun Mar 24 20:39:04 2002
@@ -203,8 +203,8 @@
 
   <chapter id="snddev">
      <title>Sound Devices</title>
-!Edrivers/sound/sound_core.c
-!Idrivers/sound/sound_firmware.c
+!Esound/sound_core.c
+!Isound/sound_firmware.c
   </chapter>
 
   <chapter id="usb">
diff -Nau linux-2.5.7-vanilla/Documentation/DocBook/via-audio.tmpl linux-2.5.7/Documentation/DocBook/via-audio.tmpl
--- linux-2.5.7-vanilla/Documentation/DocBook/via-audio.tmpl	Mon Mar 18 21:37:16 2002
+++ linux-2.5.7/Documentation/DocBook/via-audio.tmpl	Sun Mar 24 20:44:54 2002
@@ -537,7 +537,7 @@
    </listitem>
    <listitem>
     <para>
- Optimize included headers to eliminate headers found in linux/drivers/sound
+ Optimize included headers to eliminate headers found in linux/sound
 	</para>
    </listitem>
   </itemizedlist>
@@ -587,7 +587,7 @@
   
   <chapter id="intfunctions">
      <title>Internal Functions</title>
-!Idrivers/sound/via82cxxx_audio.c
+!Isound/oss/via82cxxx_audio.c
   </chapter>
 
 </book>
