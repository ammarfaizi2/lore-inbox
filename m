Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWIPQ7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWIPQ7y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 12:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWIPQ7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 12:59:54 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:2247 "EHLO
	fmmailgate01.web.de") by vger.kernel.org with ESMTP id S964843AbWIPQ7x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 12:59:53 -0400
Message-ID: <450C2DD8.7090107@web.de>
Date: Sat, 16 Sep 2006 19:01:12 +0200
From: "jens m. noedler" <noedler@web.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: gregkh@suse.de, torvalds@osdl.org
Subject: [PATCH -rc7] 3rd try: Documentation/ABI: devfs is not obsolete, but
 removed!
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody, Greg, Linus,

This little patch just moves the devfs entry from ABI/obsolete to
ABI/removed, and adds the comment, that devfs was removed in 2.6.18.

The patch was send on 3. Sep and 9. Sep 2006 to the LKML but nobody 
picked it up, so here is another chance. :-) 

The patch is against linus' current git tree and it would be nice to 
see it in the final 2.6.18 kernel.

Please cc: me!  Kind regards, Jens


Signed-off-by: jens m. noedler <noedler@web.de>

---

diff --git a/Documentation/ABI/obsolete/devfs b/Documentation/ABI/obsolete/devfs
deleted file mode 100644
index b8b8739..0000000
--- a/Documentation/ABI/obsolete/devfs
+++ /dev/null
@@ -1,13 +0,0 @@
-What:		devfs
-Date:		July 2005
-Contact:	Greg Kroah-Hartman <gregkh@suse.de>
-Description:
-	devfs has been unmaintained for a number of years, has unfixable
-	races, contains a naming policy within the kernel that is
-	against the LSB, and can be replaced by using udev.
-	The files fs/devfs/*, include/linux/devfs_fs*.h will be removed,
-	along with the the assorted devfs function calls throughout the
-	kernel tree.
-
-Users:
-
diff --git a/Documentation/ABI/removed/devfs b/Documentation/ABI/removed/devfs
new file mode 100644
index 0000000..8195c4e
--- /dev/null
+++ b/Documentation/ABI/removed/devfs
@@ -0,0 +1,12 @@
+What:		devfs
+Date:		July 2005 (scheduled), finally removed in kernel v2.6.18
+Contact:	Greg Kroah-Hartman <gregkh@suse.de>
+Description:
+	devfs has been unmaintained for a number of years, has unfixable
+	races, contains a naming policy within the kernel that is
+	against the LSB, and can be replaced by using udev.
+	The files fs/devfs/*, include/linux/devfs_fs*.h were removed,
+	along with the the assorted devfs function calls throughout the
+	kernel tree.
+
+Users:


-- 
jens m. noedler
  noedler@web.de
  pgp: 0x9f0920bb
  http://noedler.de
