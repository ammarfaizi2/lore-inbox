Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317316AbSFREx5>; Tue, 18 Jun 2002 00:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317318AbSFREx4>; Tue, 18 Jun 2002 00:53:56 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:53256 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317316AbSFRExz>;
	Tue, 18 Jun 2002 00:53:55 -0400
Date: Tue, 18 Jun 2002 00:20:23 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@obiwan
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.22 : include/linux/intermezzo_fs.hB
Message-ID: <Pine.LNX.4.44.0206180016410.3086-100000@obiwan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
    While 'make bzImage' , I received the following error:

In file included from cache.c:28:
/usr/src/linux/include/linux/intermezzo_fs.h:126: field `fset_nd' has incomplete type
make[2]: *** [cache.o] Error 1
make[2]: Leaving directory `/usr/src/linux/fs/intermezzo'
make[1]: *** [intermezzo] Error 2
make[1]: Leaving directory `/usr/src/linux/fs'
make: *** [fs] Error 2

Patch is below...Please review for inclusion.

--- include/linux/intermezzo_fs.h.old	Tue Jun 18 00:13:41 2002
+++ include/linux/intermezzo_fs.h	Tue Jun 18 00:13:26 2002
@@ -19,6 +19,7 @@
 #ifdef __KERNEL__
 #include <linux/smp.h>
 #include <linux/fsfilter.h>
+#include <linux/namei.h>
 
 /* fixups for fs.h */
 #ifndef fs_down


Regards,
Frank


