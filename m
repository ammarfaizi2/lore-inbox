Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268100AbRIHJG5>; Sat, 8 Sep 2001 05:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268071AbRIHJGq>; Sat, 8 Sep 2001 05:06:46 -0400
Received: from HINux.hin.no ([158.39.26.220]:50098 "EHLO hinux.hin.no")
	by vger.kernel.org with ESMTP id <S268133AbRIHJGf> convert rfc822-to-8bit;
	Sat, 8 Sep 2001 05:06:35 -0400
Subject: [PATCH] 2.4.10-pre5 fs/super.c
From: Ole =?ISO-8859-1?Q?Andr=E9?= Vadla =?ISO-8859-1?Q?Ravn=E5s?= 
	<zole@jblinux.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.12 (Preview Release)
Date: 08 Sep 2001 11:11:49 -0100
Message-Id: <999951109.20310.2.camel@zole.jblinux.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another quick fix, just in case..

Best regards,
Ole André
(I'm not subscribed to the list, so please cc any answers to me)

---

--- linux/fs/super.c-orig	Sat Sep  8 11:02:40 2001
+++ linux/fs/super.c	Sat Sep  8 11:03:05 2001
@@ -1404,6 +1404,7 @@
 	struct file_system_type * fstype;
 	struct vfsmount *mnt = NULL;
 	struct super_block *sb;
+	int retval = 0;
 
 	if (!type || !memchr(type, 0, PAGE_SIZE))
 		return ERR_PTR(-EINVAL);

