Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316942AbSEWQ0O>; Thu, 23 May 2002 12:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316946AbSEWQ0O>; Thu, 23 May 2002 12:26:14 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:33921 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316942AbSEWQ0N>;
	Thu, 23 May 2002 12:26:13 -0400
Date: Thu, 23 May 2002 18:26:01 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.5.17-cset1.656] patch to compile nfs (and maybe others)
Message-Id: <20020523182601.19620dbd.sebastian.droege@gmx.de>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.eQu.,ZuB8KkkMh"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.eQu.,ZuB8KkkMh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,
this trivial patch adds 3 missing #includes
without them at least nfs won't compile

Bye

diff -Nur test/linux-2.5.17/include/linux/dcache.h linux-2.5.17/include/linux/dcache.h
--- test/linux-2.5.17/include/linux/dcache.h    Tue May 21 07:07:39 2002
+++ linux-2.5.17/include/linux/dcache.h Thu May 23 16:40:14 2002
@@ -6,6 +6,7 @@
 #include <asm/atomic.h>
 #include <linux/mount.h>
 #include <asm/page.h>                  /* for BUG() */
+#include <linux/spinlock.h>
 
 /*
  * linux/include/linux/dcache.h
diff -Nur test/linux-2.5.17/include/linux/mount.h linux-2.5.17/include/linux/mount.h
--- test/linux-2.5.17/include/linux/mount.h     Tue May 21 07:07:31 2002
+++ linux-2.5.17/include/linux/mount.h  Thu May 23 18:18:23 2002
@@ -12,6 +12,8 @@
 #define _LINUX_MOUNT_H
 #ifdef __KERNEL__
 
+#include <linux/list.h>
+
 #define MNT_NOSUID     1
 #define MNT_NODEV      2
 #define MNT_NOEXEC     4
diff -Nur test/linux-2.5.17/include/linux/namei.h linux-2.5.17/include/linux/namei.h
--- test/linux-2.5.17/include/linux/namei.h     Thu May 23 17:51:37 2002
+++ linux-2.5.17/include/linux/namei.h  Thu May 23 15:58:54 2002
@@ -1,6 +1,8 @@
 #ifndef _LINUX_NAMEI_H
 #define _LINUX_NAMEI_H
 
+#include <linux/linkage.h>
+
 struct vfsmount;
 
 struct nameidata {

--=.eQu.,ZuB8KkkMh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE87Rgde9FFpVVDScsRAtuJAJ9OuKNnmZnak4lanXXE2DmddE+hxQCgmq8y
PxNI/5fnsuMMK4gZ3BB9h6w=
=tLFn
-----END PGP SIGNATURE-----

--=.eQu.,ZuB8KkkMh--

