Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932765AbWAHUV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbWAHUV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 15:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932767AbWAHUV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 15:21:57 -0500
Received: from uproxy.gmail.com ([66.249.92.195]:15287 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932765AbWAHUV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 15:21:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=NYlHEIp6U3HpgP2zr1xVkRBrypiMJxGp7r2suCA0Fg+DtE1C8PVeOZZRb7nwipGGFgAqpIiubY8/++ZsfGYy5fgDTbgVpuq/2r/mx/JLiSlE2YJA8XL+vayjriO9Ud7dm821zWn0LuI0s8lxx4a8Nm6c6AsCNTTIQCCB+yIxQYc=
Date: Sun, 8 Jan 2006 23:38:52 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] It's UTF-8
Message-ID: <20060108203851.GA5864@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/filesystems/isofs.txt |    4 ++--
 Documentation/filesystems/jfs.txt   |    2 +-
 Documentation/filesystems/vfat.txt  |    6 +++---
 fs/befs/linuxvfs.c                  |    2 +-
 fs/cifs/CHANGES                     |    2 +-
 fs/fat/dir.c                        |    2 +-
 fs/fat/inode.c                      |    2 +-
 fs/isofs/joliet.c                   |    2 +-
 fs/nls/Kconfig                      |    2 +-
 include/asm-mips/termbits.h         |    2 +-
 include/linux/msdos_fs.h            |    2 +-
 11 files changed, 14 insertions(+), 14 deletions(-)

--- a/Documentation/filesystems/isofs.txt
+++ b/Documentation/filesystems/isofs.txt
@@ -9,9 +9,9 @@ when using discs encoded using Microsoft
   iocharset=name Character set to use for converting from Unicode to
 		ASCII.  Joliet filenames are stored in Unicode format, but
 		Unix for the most part doesn't know how to deal with Unicode.
-		There is also an option of doing UTF8 translations with the
+		There is also an option of doing UTF-8 translations with the
 		utf8 option.
-  utf8          Encode Unicode names in UTF8 format. Default is no.
+  utf8          Encode Unicode names in UTF-8 format. Default is no.
 
 Mount options unique to the isofs filesystem.
   block=512     Set the block size for the disk to 512 bytes
--- a/Documentation/filesystems/jfs.txt
+++ b/Documentation/filesystems/jfs.txt
@@ -6,7 +6,7 @@ The following mount options are supporte
 
 iocharset=name	Character set to use for converting from Unicode to
 		ASCII.  The default is to do no conversion.  Use
-		iocharset=utf8 for UTF8 translations.  This requires
+		iocharset=utf8 for UTF-8 translations.  This requires
 		CONFIG_NLS_UTF8 to be set in the kernel .config file.
 		iocharset=none specifies the default behavior explicitly.
 
--- a/Documentation/filesystems/vfat.txt
+++ b/Documentation/filesystems/vfat.txt
@@ -28,16 +28,16 @@ iocharset=name -- Character set to use f
 		 know how to deal with Unicode.
 		 By default, FAT_DEFAULT_IOCHARSET setting is used.
 
-		 There is also an option of doing UTF8 translations
+		 There is also an option of doing UTF-8 translations
 		 with the utf8 option.
 
 		 NOTE: "iocharset=utf8" is not recommended. If unsure,
 		 you should consider the following option instead.
 
-utf8=<bool>   -- UTF8 is the filesystem safe version of Unicode that
+utf8=<bool>   -- UTF-8 is the filesystem safe version of Unicode that
 		 is used by the console.  It can be be enabled for the
 		 filesystem with this option. If 'uni_xlate' gets set,
-		 UTF8 gets disabled.
+		 UTF-8 gets disabled.
 
 uni_xlate=<bool> -- Translate unhandled Unicode characters to special
 		 escaped sequences.  This would let you backup and
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -561,7 +561,7 @@ befs_utf2nls(struct super_block *sb, con
  * @sb: Superblock
  * @src: Input string buffer in NLS format
  * @srclen: Length of input string in bytes
- * @dest: The output string in UTF8 format
+ * @dest: The output string in UTF-8 format
  * @destlen: Length of the output buffer
  * 
  * Converts input string @src, which is in the format of the loaded NLS map,
--- a/fs/cifs/CHANGES
+++ b/fs/cifs/CHANGES
@@ -150,7 +150,7 @@ improperly zeroed buffer in CIFS Unix ex
 Version 1.25
 ------------
 Fix internationalization problem in cifs readdir with filenames that map to 
-longer UTF8 strings than the string on the wire was in Unicode.  Add workaround
+longer UTF-8 strings than the string on the wire was in Unicode.  Add workaround
 for readdir to netapp servers. Fix search rewind (seek into readdir to return 
 non-consecutive entries).  Do not do readdir when server negotiates 
 buffer size to small to fit filename. Add support for reading POSIX ACLs from
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -114,7 +114,7 @@ static inline int fat_get_entry(struct i
 }
 
 /*
- * Convert Unicode 16 to UTF8, translated Unicode, or ASCII.
+ * Convert Unicode 16 to UTF-8, translated Unicode, or ASCII.
  * If uni_xlate is enabled and we can't get a 1:1 conversion, use a
  * colon as an escape character since it is normally invalid on the vfat
  * filesystem. The following four characters are the hexadecimal digits
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1016,7 +1016,7 @@ static int parse_options(char *options, 
 			return -EINVAL;
 		}
 	}
-	/* UTF8 doesn't provide FAT semantics */
+	/* UTF-8 doesn't provide FAT semantics */
 	if (!strcmp(opts->iocharset, "utf8")) {
 		printk(KERN_ERR "FAT: utf8 is not a recommended IO charset"
 		       " for FAT filesystems, filesystem will be case sensitive!\n");
--- a/fs/isofs/joliet.c
+++ b/fs/isofs/joliet.c
@@ -11,7 +11,7 @@
 #include "isofs.h"
 
 /*
- * Convert Unicode 16 to UTF8 or ASCII.
+ * Convert Unicode 16 to UTF-8 or ASCII.
  */
 static int
 uni16_to_x8(unsigned char *ascii, u16 *uni, int len, struct nls_table *nls)
--- a/fs/nls/Kconfig
+++ b/fs/nls/Kconfig
@@ -491,7 +491,7 @@ config NLS_KOI8_U
 	  (koi8-u) and Belarusian (koi8-ru) character sets.
 
 config NLS_UTF8
-	tristate "NLS UTF8"
+	tristate "NLS UTF-8"
 	depends on NLS
 	help
 	  If you want to display filenames with native language characters
--- a/include/asm-mips/termbits.h
+++ b/include/asm-mips/termbits.h
@@ -77,7 +77,7 @@ struct termios {
 #define IXANY	0004000		/* Any character will restart after stop.  */
 #define IXOFF	0010000		/* Enable start/stop input control.  */
 #define IMAXBEL	0020000		/* Ring bell when input queue is full.  */
-#define IUTF8	0040000		/* Input is UTF8 */
+#define IUTF8	0040000		/* Input is UTF-8 */
 
 /* c_oflag bits */
 #define OPOST	0000001		/* Perform output processing.  */
--- a/include/linux/msdos_fs.h
+++ b/include/linux/msdos_fs.h
@@ -199,7 +199,7 @@ struct fat_mount_options {
 		 sys_immutable:1, /* set = system files are immutable */
 		 dotsOK:1,        /* set = hidden and system files are named '.filename' */
 		 isvfat:1,        /* 0=no vfat long filename support, 1=vfat support */
-		 utf8:1,	  /* Use of UTF8 character set (Default) */
+		 utf8:1,	  /* Use of UTF-8 character set (Default) */
 		 unicode_xlate:1, /* create escape sequences for unhandled Unicode */
 		 numtail:1,       /* Does first alias have a numeric '~1' type tail? */
 		 atari:1,         /* Use Atari GEMDOS variation of MS-DOS fs */

