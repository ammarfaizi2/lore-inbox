Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261670AbUJaVlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbUJaVlQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 16:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUJaVhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 16:37:46 -0500
Received: from washoe.rutgers.edu ([165.230.95.67]:41919 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S261656AbUJaVfZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 16:35:25 -0500
Date: Sun, 31 Oct 2004 16:35:23 -0500
From: Yaroslav Halchenko <kernel@onerussian.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: ipod vfat
Message-ID: <20041031213523.GO1530@washoe.rutgers.edu>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
X-Image-Url: http://www.onerussian.com/img/yoh.png
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear Kernel Developers,

Is it possible to incorporate the next patch which I had to introduce to
have the vfat fs of my ipod to get mounted under Linux.

Originally its vfat was mounting ok, but then at some point which I
didn't clearly mentioned, it stopped... probably it happened after I
attached ipod to some windows box, because now windows still can easily
mount it whenever vanilla linux kernel refuses...

Or should I just adjust my ipod's fs definition?

Thank you in advance

-- 
Yaroslav Halchenko
  Graduate Student  CS Dept. UNM,  ABQ
        Linux User  175555
      lynx -source  http://www.onerussian.com/gpg-yoh.asc | gpg --import
   GPG fingerprint  3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-ipodfs.patch"

--- linux-2.6.5/fs/fat/inode.c	2004-05-10 18:09:15.000000000 +0000
+++ linux-2.6.6-preX/fs/fat/inode.c	2004-05-09 19:49:04.000000000 +0000
@@ -984,6 +984,8 @@
 	}
 	if (FAT_FIRST_ENT(sb, media) == first) {
 		/* all is as it should be */
+	} else if (media == 0xf8 && FAT_FIRST_ENT(sb, 0xff) == first) {
+		/* bad, reported on yarik's ipod */
 	} else if (media == 0xf8 && FAT_FIRST_ENT(sb, 0xfe) == first) {
 		/* bad, reported on pc9800 */
 	} else if (media == 0xf0 && FAT_FIRST_ENT(sb, 0xf8) == first) {

--Dxnq1zWXvFF0Q93v--
