Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261477AbSIZUAM>; Thu, 26 Sep 2002 16:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261480AbSIZUAM>; Thu, 26 Sep 2002 16:00:12 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:26593 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261477AbSIZUAD>; Thu, 26 Sep 2002 16:00:03 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.20-pre8 - Config.in: Second extended fs rename / move Ext3 to a wiser place
Date: Thu, 26 Sep 2002 21:44:38 +0200
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Message-Id: <200209261941.34278.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_EI92EPDT2P46CERT79ZG"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_EI92EPDT2P46CERT79ZG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi there,

these are just cosmetic fixes.

I think we can do the following:

1. rename: "Second extended fs support" to "Ext2 file system support"
    (to be equal to Ext3fs)

2. move: "Ext3 journalling file system support" near under to Ext2 fs.

Coments?


Marcello, if ok, please apply.

--=20
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/569DE2E3DB441A16
Fingerprint: 3469 0CF8 CA7E 0042 7824 080A 569D E2E3 DB44 1A16
Key available at www.keyserver.net. Encrypted e-mail preferred.
--------------Boundary-00=_EI92EPDT2P46CERT79ZG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.4_1-ext2-rename.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.4_1-ext2-rename.patch"

--- linux-2.4-old/fs/Config.in		Thu Sep 26 12:19:14 2002
+++ linux-2.4-new/fs/Config.in		Thu Sep 26 19:26:31 2002
@@ -83,7 +83,7 @@
 
 tristate 'ROM file system support' CONFIG_ROMFS_FS
 
-tristate 'Second extended fs support' CONFIG_EXT2_FS
+tristate 'Ext2 file system support' CONFIG_EXT2_FS
 
 tristate 'System V/Xenix/V7/Coherent file system support' CONFIG_SYSV_FS
 

--------------Boundary-00=_EI92EPDT2P46CERT79ZG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.4_2-ext3-move-right-place.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.4_2-ext3-move-right-place.patch"

--- linux-2.4-old/fs/Config.in		Thu Sep 26 12:19:14 2002
+++ linux-2.4-new/fs/Config.in		Thu Sep 26 19:26:31 2002
@@ -24,12 +24,7 @@
 
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
@@ -85,6 +85,13 @@
 
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

--------------Boundary-00=_EI92EPDT2P46CERT79ZG--


