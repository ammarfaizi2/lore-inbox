Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265577AbTIJTUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265603AbTIJTST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:18:19 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:43274 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265577AbTIJTQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:16:45 -0400
Date: Wed, 10 Sep 2003 21:16:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: kbuild: Save relevant parts of modules.txt
Message-ID: <20030910191642.GA5604@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
References: <20030910191411.GA5517@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910191411.GA5517@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1267  -> 1.1268 
#	Documentation/kbuild/00-INDEX	1.4     -> 1.5    
#	               (new)	        -> 1.1     Documentation/kbuild/modules.txt
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/10	sam@mars.ravnborg.org	1.1268
# kbuild: Save relevant parts of modules.txt
# 
# The out-dated modules.txt were deleted from the kernel, save the kbuild
# related bits in Documentation/kbuild.
# It needs more updates, but for now this is better than nothing
# --------------------------------------------
#
diff -Nru a/Documentation/kbuild/00-INDEX b/Documentation/kbuild/00-INDEX
--- a/Documentation/kbuild/00-INDEX	Wed Sep 10 21:15:32 2003
+++ b/Documentation/kbuild/00-INDEX	Wed Sep 10 21:15:32 2003
@@ -4,3 +4,5 @@
 	- specification of Config Language, the language in Kconfig files
 makefiles.txt
 	- developer information for linux kernel makefiles
+modules.txt
+	- how to build modules and to install them
diff -Nru a/Documentation/kbuild/modules.txt b/Documentation/kbuild/modules.txt
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/Documentation/kbuild/modules.txt	Wed Sep 10 21:15:32 2003
@@ -0,0 +1,28 @@
+For now this is a raw copy from the old Documentation/modules.txt,
+which was removed in 2.6.0-test5.
+The information herein is correct but not complete.
+
+Installing modules in a non-standard location
+---------------------------------------------
+When the modules needs to be installed under another directory
+the INSTALL_MOD_PATH can be used to prefix "/lib/modules" as seen
+in the following example:
+
+make INSTALL_MOD_PATH=/frodo modules_install
+
+This will install the modules in the directory /frodo/lib/modules.
+/frodo can be a NFS mounted filesystem on another machine, allowing
+out-of-the-box support for installation on remote machines.
+
+
+Compiling modules outside the official kernel
+---------------------------------------------
+Often modules are developed outside the official kernel.
+To keep up with changes in the build system the most portable way
+to compile a module outside the kernel is to use the following command-line:
+
+make -C path/to/kernel/src SUBDIRS=$PWD modules
+
+This requires that a makefile exits made in accordance to
+Documentation/kbuild/makefiles.txt.
+
