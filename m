Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUFNXXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUFNXXW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 19:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264622AbUFNXXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 19:23:21 -0400
Received: from mail.dif.dk ([193.138.115.101]:32694 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S264585AbUFNXVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 19:21:17 -0400
Date: Tue, 15 Jun 2004 01:20:26 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: A few tiny, trivial, pedantic patches (that have all been previously
 submitted)
Message-ID: <Pine.LNX.4.56.0406150055580.8414@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

I hope you don't mind me mailing this directly to you despite its trivial
nature, but I thought that since these seem to be ignored (probably due to
trivialness) that I would try submitting them directly to you for
consideration for -mm.

I have submitted all of the following previously to lkml and what
maintainers I could find over the last few weeks (which is why I'm not
CC'ing those people again) but they seem to disappear in the noise or just
get ignored. Sure, they are very trivial in nature, but even trivial stuff
has its place - right? :-)
(and yes, I tried CC'in the trivial patch monkey as well, but either I
made a mistake or they also seem to be ignored there).
All patches are created against 2.6.7-rc3-mm2.
I hope you'll consider including them, or if they are no good, then tell
me so :)

There are 4 patches below that do the following;

2.6.7-rc3-mm2-add_missing_newlines.patch :
- Adds missing newlines at end of file to 4 files.
The reason being that for source files missing NL at EOF needlessly
generate warnings and for other files it makes them less grep, cat, sed
etc friendly.

2.6.7-rc3-mm2-CodingStyle_nl_at_eof_paragraf.patch :
- This adds a small paragraf to Documentation/CodingStyle telling people
to please ensure their files have a newline at EOF.
I don't know if this is appropriate, but since I've gotten no feedback I
try submitting it again, this time to you directly.

2.6.7-rc3-mm2-nfs_newer_version_documentation.patch :
- The kernel configuration help text lists both NFSv3 & v4 as the newer
version. Obviously they can't both be the newer version of the protocol at
the same time, so rewrite the text for v3 to remove th "newer" bit.

2.6.7-rc3-mm2-uninitialized_variable_in_isdn_v110.patch :
- This patch kills a warning about possible use of an unitialized variable
in drivers/isdn/i4l/isdn_v110.c
If I read the code correctly the case where 'ret' could possibly be used
uninitialized can never happen, so this is simply to shut up gcc, but in
case I'm wrong and it really /can/ happen it seems to me that initializing
the variable to 0 is the sane thing to do in any case.
This is the only one of the patches that make any actual code changes (and
a very tiny change at that).

Here are the patches :


2.6.7-rc3-mm2-add_missing_newlines.patch :

diff -urNp linux-2.6.7-rc3-mm2-orig/Documentation/sound/oss/ChangeLog.multisound linux-2.6.7-rc3-mm2/Documentation/sound/oss/ChangeLog.multisound
--- linux-2.6.7-rc3-mm2-orig/Documentation/sound/oss/ChangeLog.multisound	2004-05-10 04:32:26.000000000 +0200
+++ linux-2.6.7-rc3-mm2/Documentation/sound/oss/ChangeLog.multisound	2004-06-15 00:30:46.000000000 +0200
@@ -210,4 +210,4 @@

 	* Add preliminary playback support

-	* Use new Turtle Beach DSP code
\ No newline at end of file
+	* Use new Turtle Beach DSP code
diff -urNp linux-2.6.7-rc3-mm2-orig/arch/i386/pci/changelog linux-2.6.7-rc3-mm2/arch/i386/pci/changelog
--- linux-2.6.7-rc3-mm2-orig/arch/i386/pci/changelog	2004-05-10 04:33:13.000000000 +0200
+++ linux-2.6.7-rc3-mm2/arch/i386/pci/changelog	2004-06-15 00:27:11.000000000 +0200
@@ -59,4 +59,4 @@
  *		  for a lot of patience during testing. [mj]
  *
  * Oct  8, 1999 : Split to pci-i386.c, pci-pc.c and pci-visws.c. [mj]
- */
\ No newline at end of file
+ */
diff -urNp linux-2.6.7-rc3-mm2-orig/drivers/tc/lk201.h linux-2.6.7-rc3-mm2/drivers/tc/lk201.h
--- linux-2.6.7-rc3-mm2-orig/drivers/tc/lk201.h	2004-05-10 04:32:29.000000000 +0200
+++ linux-2.6.7-rc3-mm2/drivers/tc/lk201.h	2004-06-15 00:37:07.000000000 +0200
@@ -50,4 +50,4 @@
 #define LK_KEY_REPEAT 180
 #define LK_KEY_ACK 186

-extern unsigned char scancodeRemap[256];
\ No newline at end of file
+extern unsigned char scancodeRemap[256];
diff -urNp linux-2.6.7-rc3-mm2-orig/sound/drivers/opl4/Makefile linux-2.6.7-rc3-mm2/sound/drivers/opl4/Makefile
--- linux-2.6.7-rc3-mm2-orig/sound/drivers/opl4/Makefile	2004-05-10 04:33:13.000000000 +0200
+++ linux-2.6.7-rc3-mm2/sound/drivers/opl4/Makefile	2004-06-15 00:36:56.000000000 +0200
@@ -15,4 +15,4 @@ snd-opl4-synth-objs := opl4_seq.o opl4_s
 sequencer = $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(1),m),$(if $(CONFIG_SND_SEQUENCER),$(1)))

 obj-$(CONFIG_SND_OPL4_LIB) += snd-opl4-lib.o
-obj-$(call sequencer,$(CONFIG_SND_OPL4_LIB)) += snd-opl4-synth.o
\ No newline at end of file
+obj-$(call sequencer,$(CONFIG_SND_OPL4_LIB)) += snd-opl4-synth.o


2.6.7-rc3-mm2-CodingStyle_nl_at_eof_paragraf.patch :

--- linux-2.6.7-rc3-mm2-orig/Documentation/CodingStyle	2004-05-10 04:32:27.000000000 +0200
+++ linux-2.6.7-rc3-mm2/Documentation/CodingStyle	2004-06-15 00:45:24.000000000 +0200
@@ -47,7 +47,7 @@ used for indentation, and the above exam
 Get a decent editor and don't leave whitespace at the end of lines.


-		Chapter 2: Breaking long lines and strings
+		Chapter 2: Breaking long lines and strings and NL at EOF

 Coding style is all about readability and maintainability using commonly
 available tools.
@@ -69,6 +69,12 @@ void fun(int a, int b, int c)
 		next_statement;
 }

+Please also make sure that your files have a newline at the end of the file.
+Files that do not end in a newline are not as friendly to tools such grep,
+cat, sed and various others. A missing newline will also needlessly cause
+gcc to emit a warning message for your source files.
+
+
 		Chapter 3: Placing Braces

 The other issue that always comes up in C styling is the placement of
@@ -220,6 +226,7 @@ out:
 	return result;
 }

+
 		Chapter 7: Commenting

 Comments are good, but there is also a danger of over-commenting.  NEVER


2.6.7-rc3-mm2-nfs_newer_version_documentation.patch :

--- linux-2.6.7-rc3-mm2-orig/fs/Kconfig	2004-06-09 03:35:00.000000000 +0200
+++ linux-2.6.7-rc3-mm2/fs/Kconfig	2004-06-15 00:40:49.000000000 +0200
@@ -1363,8 +1363,8 @@ config NFS_V3
 	bool "Provide NFSv3 client support"
 	depends on NFS_FS
 	help
-	  Say Y here if you want your NFS client to be able to speak the newer
-	  version 3 of the NFS protocol.
+	  Say Y here if you want your NFS client to be able to speak version
+	  3 of the NFS protocol.

 	  If unsure, say Y.


2.6.7-rc3-mm2-uninitialized_variable_in_isdn_v110.patch :

--- linux-2.6.7-rc3-mm2-orig/drivers/isdn/i4l/isdn_v110.c	2004-05-10 04:33:21.000000000 +0200
+++ linux-2.6.7-rc3-mm2/drivers/isdn/i4l/isdn_v110.c	2004-06-15 00:35:41.000000000 +0200
@@ -520,7 +520,7 @@ isdn_v110_stat_callback(int idx, isdn_ct
 {
 	isdn_v110_stream *v = NULL;
 	int i;
-	int ret;
+	int ret = 0;

 	if (idx < 0)
 		return 0;


--
Jesper Juhl <juhl-lkml@dif.dk>

