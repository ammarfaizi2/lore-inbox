Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSGAWuU>; Mon, 1 Jul 2002 18:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSGAWuT>; Mon, 1 Jul 2002 18:50:19 -0400
Received: from zok.SGI.COM ([204.94.215.101]:44770 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316574AbSGAWuS>;
	Mon, 1 Jul 2002 18:50:18 -0400
Date: Tue, 2 Jul 2002 08:51:36 +1000
From: Nathan Scott <nathans@sgi.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix kdev_val typo
Message-ID: <20020701225136.GB469@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Marcelo,

There's a missing brace in the kdev_val() 2.5 compatibility macro
which someone has added into 2.4.19-rc1, making the macro useless.
Here's the trivial fix, in case noone else has sent it along yet.

cheers.

-- 
Nathan


diff -Naur 2.4.19-rc1-pristine/include/linux/kdev_t.h 2.4.19-rc1-kdevt/include/linux/kdev_t.h
--- 2.4.19-rc1-pristine/include/linux/kdev_t.h	Tue Jun 25 10:12:04 2002
+++ 2.4.19-rc1-kdevt/include/linux/kdev_t.h	Tue Jul  2 08:40:28 2002
@@ -81,7 +81,7 @@
 #define minor(d)	MINOR(d)
 #define kdev_same(a,b)	((a) == (b))
 #define kdev_none(d)	(!(d))
-#define kdev_val(d)	((unsigned int)(d)
+#define kdev_val(d)	((unsigned int)(d))
 #define val_to_kdev(d)	((kdev_t(d))
 
 /*
