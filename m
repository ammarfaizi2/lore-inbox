Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313132AbSDYNwF>; Thu, 25 Apr 2002 09:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313137AbSDYNwE>; Thu, 25 Apr 2002 09:52:04 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:16132 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313132AbSDYNwD>;
	Thu, 25 Apr 2002 09:52:03 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [patch] 2.5.10 trivial fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 25 Apr 2002 23:51:46 +1000
Message-ID: <4158.1019742706@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cannot tell if any of these have been done in bk.  I don't use bk and
http://linux.bkbits.net:8080/linux-2.5/ChangeSet@-3d?nav=index.html
shows no activity in the last 65 hours, it does not even show 2.5.10.

diff -ur 2.5.10-pristine/drivers/isdn/hardware/avm/Config.in 2.5.10-trivial/drivers/isdn/hardware/avm/Config.in
--- 2.5.10-pristine/drivers/isdn/hardware/avm/Config.in	Thu Apr 25 00:28:51 2002
+++ 2.5.10-trivial/drivers/isdn/hardware/avm/Config.in	Thu Apr 25 23:15:10 2002
@@ -14,7 +14,7 @@
    dep_mbool    '    AVM B1 PCI V4 support'       CONFIG_ISDN_DRV_AVMB1_B1PCIV4  $CONFIG_ISDN_DRV_AVMB1_B1PCI
 
    dep_tristate '  AVM T1/T1-B ISA support'       CONFIG_ISDN_DRV_AVMB1_T1ISA    $CONFIG_ISDN_CAPI
-q
+
    dep_tristate '  AVM B1/M1/M2 PCMCIA support'   CONFIG_ISDN_DRV_AVMB1_B1PCMCIA $CONFIG_ISDN_CAPI
 
    dep_tristate '  AVM B1/M1/M2 PCMCIA cs module' CONFIG_ISDN_DRV_AVMB1_AVM_CS   $CONFIG_ISDN_DRV_AVMB1_B1PCMCIA $CONFIG_PCMCIA
diff -ur 2.5.10-pristine/drivers/isdn/i4l/Makefile 2.5.10-trivial/drivers/isdn/i4l/Makefile
--- 2.5.10-pristine/drivers/isdn/i4l/Makefile	Tue Apr 23 11:00:24 2002
+++ 2.5.10-trivial/drivers/isdn/i4l/Makefile	Thu Apr 25 23:15:48 2002
@@ -18,7 +18,7 @@
 isdn-objs-$(CONFIG_ISDN_X25)		+= isdn_concap.o isdn_x25iface.o
 isdn-objs-$(CONFIG_ISDN_AUDIO)		+= isdn_audio.o
 isdn-objs-$(CONFIG_ISDN_TTY_FAX)	+= isdn_ttyfax.o
-isdn-objs-$(CONFIG_ISDN_WITH_ABC)	+= isdn_dwabc.o
+# isdn-objs-$(CONFIG_ISDN_WITH_ABC)	+= isdn_dwabc.o		no source for isdn_dwabc
 
 isdn-objs				+= $(isdn-objs-y)
 
diff -ur 2.5.10-pristine/drivers/net/wan/dscc4.c 2.5.10-trivial/drivers/net/wan/dscc4.c
--- 2.5.10-pristine/drivers/net/wan/dscc4.c	Tue Apr 23 11:00:28 2002
+++ 2.5.10-trivial/drivers/net/wan/dscc4.c	Thu Apr 25 23:42:51 2002
@@ -1552,7 +1552,7 @@
 				rx_fd->state1 &= ~Hold;
 				rx_fd->state2 = 0x00000000;
 				rx_fd->end = 0xbabeface;
-			}
+			//}
 			goto try;
 		}
 		if (state & Fi) {
diff -ur 2.5.10-pristine/fs/exportfs/expfs.c 2.5.10-trivial/fs/exportfs/expfs.c
--- 2.5.10-pristine/fs/exportfs/expfs.c	Tue Apr 23 11:00:34 2002
+++ 2.5.10-trivial/fs/exportfs/expfs.c	Thu Apr 25 23:16:08 2002
@@ -34,7 +34,7 @@
 
 #define	CALL(ops,fun) ((ops->fun)?(ops->fun):export_op_default.fun)
 
-#define dprintk(x, ...) do{}while(0)
+#define dprintk(x...) do{}while(0)
 
 struct dentry *
 find_exported_dentry(struct super_block *sb, void *obj, void *parent,

