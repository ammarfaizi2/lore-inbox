Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276384AbRJGOjV>; Sun, 7 Oct 2001 10:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276397AbRJGOjL>; Sun, 7 Oct 2001 10:39:11 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:13586 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S276384AbRJGOjH>;
	Sun, 7 Oct 2001 10:39:07 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: pcg@goof.com ( Marc A. Lehmann )
Cc: linux-kernel@vger.kernel.org
Subject: Re: zisofs doesn't compile in 2.4.10-ac7 
In-Reply-To: Your message of "Sun, 07 Oct 2001 15:43:24 +0200."
             <20011007154324.A4991@schmorp.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Oct 2001 00:39:25 +1000
Message-ID: <25078.1002465565@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Oct 2001 15:43:24 +0200, 
<pcg( Marc)@goof(A.).(Lehmann )com> wrote:
>In file included from uncompress.c:21:
>/localvol/usr/src/linux-2.4/include/linux/zlib_fs.h:34:19: zconf.h: No such file or directory

Against 2.4.10-ac7.

Index: 10.37/fs/cramfs/Makefile
--- 10.37/fs/cramfs/Makefile Sat, 22 Sep 2001 14:41:20 +1000 kaos (linux-2.4/h/b/0_Makefile 1.2 644)
+++ 10.37(w)/fs/cramfs/Makefile Mon, 08 Oct 2001 00:10:13 +1000 kaos (linux-2.4/h/b/0_Makefile 1.2 644)
@@ -8,4 +8,6 @@ obj-y  := inode.o uncompress.o
 
 obj-m := $(O_TARGET)
 
+CFLAGS_uncompress.o := -I $(TOPDIR)/fs/inflate_fs
+
 include $(TOPDIR)/Rules.make
Index: 10.37/fs/isofs/Makefile
--- 10.37/fs/isofs/Makefile Sat, 22 Sep 2001 14:41:20 +1000 kaos (linux-2.4/o/b/29_Makefile 1.2 644)
+++ 10.37(w)/fs/isofs/Makefile Mon, 08 Oct 2001 00:14:56 +1000 kaos (linux-2.4/o/b/29_Makefile 1.2 644)
@@ -15,4 +15,6 @@ obj-$(CONFIG_ZISOFS) += compress.o
 
 obj-m  := $(O_TARGET)
 
+CFLAGS_compress.o := -I $(TOPDIR)/fs/inflate_fs
+
 include $(TOPDIR)/Rules.make
Index: 10.37/fs/inflate_fs/Makefile
--- 10.37/fs/inflate_fs/Makefile Sat, 22 Sep 2001 14:41:20 +1000 kaos (linux-2.4/p/f/9_Makefile 1.1 644)
+++ 10.37(w)/fs/inflate_fs/Makefile Mon, 08 Oct 2001 00:23:44 +1000 kaos (linux-2.4/p/f/9_Makefile 1.1 644)
@@ -28,4 +28,6 @@ obj-y := adler32.o infblock.o infcodes.o
 	 inftrees.o infutil.o
 obj-m := $(O_TARGET)
 
+EXTRA_CFLAGS += -I $(TOPDIR)/fs/inflate_fs
+
 include $(TOPDIR)/Rules.make

