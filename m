Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267659AbUJWGKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267659AbUJWGKV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 02:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266835AbUJWFys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 01:54:48 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:5255
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S267659AbUJWE0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:26:17 -0400
Subject: [patch 5/5] uml-add-conf-INITRAMFS_SOURCE
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Sat, 23 Oct 2004 05:53:23 +0200
Message-Id: <20041023035323.8343195D5@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/Kconfig_block |   27 ++++++++++++++++++++++++
 1 files changed, 27 insertions(+)

diff -puN arch/um/Kconfig_block~uml-add-conf-INITRAMFS_SOURCE arch/um/Kconfig_block
--- vanilla-linux-2.6.9/arch/um/Kconfig_block~uml-add-conf-INITRAMFS_SOURCE	2004-10-22 02:27:36.844076640 +0200
+++ vanilla-linux-2.6.9-paolo/arch/um/Kconfig_block	2004-10-22 02:28:38.540697328 +0200
@@ -52,6 +52,33 @@ config BLK_DEV_INITRD
 	bool "Initial RAM disk (initrd) support"
 	depends on BLK_DEV_RAM=y
 
+#Copied directly from drivers/block/Kconfig
+config INITRAMFS_SOURCE
+	string "Source directory of cpio_list"
+	default ""
+	help
+	  This can be set to either a directory containing files, etc to be
+	  included in the initramfs archive, or a file containing newline
+	  separated entries.
+
+	  If it is a file, it should be in the following format:
+	    # a comment
+	    file <name> <location> <mode> <uid> <gid>
+	    dir <name> <mode> <uid> <gid>
+	    nod <name> <mode> <uid> <gid> <dev_type> <maj> <min>
+
+	  Where:
+	    <name>      name of the file/dir/nod in the archive
+	    <location>  location of the file in the current filesystem
+	    <mode>      mode/permissions of the file
+	    <uid>       user id (0=root)
+	    <gid>       group id (0=root)
+	    <dev_type>  device type (b=block, c=character)
+	    <maj>       major number of nod
+	    <min>       minor number of nod
+
+	  If you are not sure, leave it blank.
+
 config MMAPPER
 	tristate "Example IO memory driver"
 	depends on BROKEN
_
