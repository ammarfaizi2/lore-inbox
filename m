Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265646AbSJSSDq>; Sat, 19 Oct 2002 14:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265647AbSJSSDp>; Sat, 19 Oct 2002 14:03:45 -0400
Received: from ANantes-106-1-5-42.abo.wanadoo.fr ([193.251.16.42]:9857 "EHLO
	osiris") by vger.kernel.org with ESMTP id <S265646AbSJSSDo>;
	Sat, 19 Oct 2002 14:03:44 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] language fix for the main Makefile
From: Benoit Plessis <benoit.plessis@maverick.eu.org>
Date: 19 Oct 2002 20:09:45 +0200
Message-ID: <87elamuwpi.fsf@maverick.eu.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


Since i am a french user, and that i sometime work in a french
environement i once had this problem of the Makefile unable to
correctly set the kbuild_2_4_nostdinc var. So i made the following
fix:

--=-=-=
Content-Disposition: attachment; filename=kernel_lang_fix.diff

--- linux-2.4.19.old/Makefile	2002-10-19 13:17:53.000000000 +0200
+++ linux-2.4.19/Makefile	2002-10-19 19:58:50.000000000 +0200
@@ -258,7 +258,7 @@
 # 'kbuild_2_4_nostdinc :=' or -I/usr/include for kernel code and you are not UML
 # then your code is broken!  KAO.
 
-kbuild_2_4_nostdinc	:= -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
+kbuild_2_4_nostdinc	:= -nostdinc $(shell LANG=C LC_ALL=C $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
 export kbuild_2_4_nostdinc
 
 export	CPPFLAGS CFLAGS CFLAGS_KERNEL AFLAGS AFLAGS_KERNEL

--=-=-=


ps: for any comment/question please Cc: to me personnaly.

-- 
Benoit (Maverick) Plessis <benoit.plessis@maverick.eu.org>  +33 6 77 42 78 32
1024D/B4D74B76 B9A7 3697 661D 25FB A609  E69E 92CA FFAB B4D7 4B76

--=-=-=--
