Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317359AbSFDI6P>; Tue, 4 Jun 2002 04:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317414AbSFDI6O>; Tue, 4 Jun 2002 04:58:14 -0400
Received: from pandora.cantech.net.au ([203.26.6.29]:24836 "EHLO
	pandora.cantech.net.au") by vger.kernel.org with ESMTP
	id <S317359AbSFDI6M>; Tue, 4 Jun 2002 04:58:12 -0400
Date: Tue, 4 Jun 2002 16:58:05 +0800 (WST)
From: "Anthony J. Breeds-Taurima" <tony@cantech.net.au>
To: lkml <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Peter J. Braam" <braam@clusterfs.com>
Subject: [PATCH] 2.4.19-pre10 s/Efoo/-Efoo/ fs/intermezzo/*.c
Message-ID: <Pine.LNX.4.44.0206041655150.32156-100000@thor.cantech.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
	Small cleanup patch.  Peter this is as discussed with you.  I know
it's already in your tree trying to knock one of the kernel janitors jobs on
the head.


Yours Tony

Jan 22-26 2003      Linux.Conf.AU       http://conf.linux.org.au/
         The Australian Linux Technical Conference!
--------------------------------------------------------------------------------
diff -urN -X /home/tony/src/kernel/dontdiff linux-2.4.19-pre10.clean/fs/intermezzo/dir.c linux-2.4.19-pre10/fs/intermezzo/dir.c
--- linux-2.4.19-pre10.clean/fs/intermezzo/dir.c	Tue Apr 30 13:21:23 2002
+++ linux-2.4.19-pre10/fs/intermezzo/dir.c	Tue Jun  4 16:38:24 2002
@@ -129,7 +129,7 @@
         PRESTO_ALLOC(buffer, char *, PAGE_SIZE);
         if ( !buffer ) {
                 printk("PRESTO: out of memory!\n");
-                return ENOMEM;
+                return -ENOMEM;
         }
         path = presto_path(de, root, buffer, PAGE_SIZE);
         pathlen = MYPATHLEN(buffer, path);
diff -urN -X /home/tony/src/kernel/dontdiff linux-2.4.19-pre10.clean/fs/intermezzo/file.c linux-2.4.19-pre10/fs/intermezzo/file.c
--- linux-2.4.19-pre10.clean/fs/intermezzo/file.c	Tue Apr 30 13:21:23 2002
+++ linux-2.4.19-pre10/fs/intermezzo/file.c	Tue Jun  4 16:38:24 2002
@@ -63,7 +63,7 @@
         PRESTO_ALLOC(buffer, char *, PAGE_SIZE);
         if ( !buffer ) {
                 printk("PRESTO: out of memory!\n");
-                return ENOMEM;
+                return -ENOMEM;
         }
         path = presto_path(de, buffer, PAGE_SIZE);
         pathlen = MYPATHLEN(buffer, path);

