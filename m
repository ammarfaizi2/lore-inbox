Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263322AbTC0RKN>; Thu, 27 Mar 2003 12:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263321AbTC0RJ3>; Thu, 27 Mar 2003 12:09:29 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57221
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263308AbTC0RI1>; Thu, 27 Mar 2003 12:08:27 -0500
Date: Thu, 27 Mar 2003 18:25:55 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303271825.h2RIPt3r019708@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: DRIVERNAME SUPPRESSED DUE TO KERNEL.ORG FILTER BUGS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wrong kind of NUL fix for asm headers
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.66-bk3/include/asm-i386/uaccess.h linux-2.5.66-ac1/include/asm-i386/uaccess.h
--- linux-2.5.66-bk3/include/asm-i386/uaccess.h	2003-03-27 17:13:28.000000000 +0000
+++ linux-2.5.66-ac1/include/asm-i386/uaccess.h	2003-03-22 19:59:05.000000000 +0000
@@ -510,9 +510,9 @@
  *
  * Context: User context only.  This function may sleep.
  *
- * Get the size of a NULL-terminated string in user space.
+ * Get the size of a NUL-terminated string in user space.
  *
- * Returns the size of the string INCLUDING the terminating NULL.
+ * Returns the size of the string INCLUDING the terminating NUL.
  * On exception, returns 0.
  *
  * If there is a limit on the length of a valid string, you may wish to


(Steven Cole)
