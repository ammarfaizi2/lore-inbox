Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273611AbTHAKqu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270000AbTHAKoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:44:37 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:55825 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S270716AbTHAKoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 06:44:22 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.22-pre10] [2/2] CONFIG: Move "Ext3 journalling file system support" after "Ext2 file system support"
Date: Fri, 1 Aug 2003 12:39:53 +0200
User-Agent: KMail/1.5.2
Organization: Working Overloaded Linux Kernel
MIME-Version: 1.0
Message-Id: <200307312219.42958.m.c.p@wolk-project.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5NkK/q5pkrSTv4X"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_5NkK/q5pkrSTv4X
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcelo,

this is pure cosmetic cleanup. Subject says it all.

Please apply for 2.4.22-pre10. Thank you :)

ciao, Marc

--Boundary-00=_5NkK/q5pkrSTv4X
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="2.4-ext3-move-right-place.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.4-ext3-move-right-place.patch"

--- linux-2.4-old/fs/Config.in		Thu Sep 26 12:19:14 2002
+++ linux-2.4-new/fs/Config.in		Thu Sep 26 19:26:31 2002
@@ -28,12 +28,7 @@
 
 dep_tristate 'BFS file system support (EXPERIMENTAL)' CONFIG_BFS_FS $CONFIG_EXPERIMENTAL
 
-tristate 'Ext3 journalling file system support' CONFIG_EXT3_FS
-# CONFIG_JBD could be its own option (even modular), but until there are
-# other users than ext3, we will simply make it be the same as CONFIG_EXT3_FS
-# dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD $CONFIG_EXT3_FS
-define_bool CONFIG_JBD $CONFIG_EXT3_FS
-dep_mbool '  JBD (ext3) debugging support' CONFIG_JBD_DEBUG $CONFIG_JBD
+# old ext3fs config place. Moved near to ext2fs
 
 # msdos file systems
 tristate 'DOS FAT fs support' CONFIG_FAT_FS
@@ -89,6 +89,13 @@
 
 tristate 'Ext2 file system support' CONFIG_EXT2_FS
 
+tristate 'Ext3 journalling file system support' CONFIG_EXT3_FS
+# CONFIG_JBD could be its own option (even modular), but until there are
+# other users than ext3, we will simply make it be the same as CONFIG_EXT3_FS
+# dep_tristate '  Journal Block Device support (JBD for ext3)' CONFIG_JBD $CONFIG_EXT3_FS
+define_bool CONFIG_JBD $CONFIG_EXT3_FS
+dep_mbool '  JBD (ext3) debugging support' CONFIG_JBD_DEBUG $CONFIG_JBD
+
 tristate 'System V/Xenix/V7/Coherent file system support' CONFIG_SYSV_FS
 
 tristate 'UDF file system support (read only)' CONFIG_UDF_FS

--Boundary-00=_5NkK/q5pkrSTv4X--


