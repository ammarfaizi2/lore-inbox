Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135795AbREGSOs>; Mon, 7 May 2001 14:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136483AbREGSOj>; Mon, 7 May 2001 14:14:39 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:53778 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S135795AbREGSOa>; Mon, 7 May 2001 14:14:30 -0400
Date: Mon, 7 May 2001 20:13:57 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: [PATCH] kernel-api book should also include kernel/module.c
Message-ID: <20010507201357.H5208@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes a minor bug the Kernel API book: it should include the
functions in kernel/module.c as well. The patch is against linux-2.4.4,
but should work as well against 2.4.5-pre1 and 2.4.4-ac5. Please apply.


Erik

PS: Thanks to Timur Tabi for pointing out this "bug".

Index: Documentation/DocBook/Makefile
===================================================================
RCS file: /home/erik/cvsroot/elinux/Documentation/DocBook/Makefile,v
retrieving revision 1.1.1.25
diff -u -r1.1.1.25 Makefile
--- Documentation/DocBook/Makefile	2001/04/26 12:44:59	1.1.1.25
+++ Documentation/DocBook/Makefile	2001/05/07 17:51:15
@@ -95,6 +98,7 @@
 		$(TOPDIR)/kernel/pm.c \
 		$(TOPDIR)/kernel/ksyms.c \
 		$(TOPDIR)/kernel/kmod.c \
+		$(TOPDIR)/kernel/module.c \
 		$(TOPDIR)/kernel/printk.c \
 		$(TOPDIR)/kernel/sched.c \
 		$(TOPDIR)/kernel/sysctl.c \
Index: Documentation/DocBook/kernel-api.tmpl
===================================================================
RCS file: /home/erik/cvsroot/elinux/Documentation/DocBook/kernel-api.tmpl,v
retrieving revision 1.1.1.20
diff -u -r1.1.1.20 kernel-api.tmpl
--- Documentation/DocBook/kernel-api.tmpl	2001/04/26 12:45:00	1.1.1.20
+++ Documentation/DocBook/kernel-api.tmpl	2001/05/07 17:59:04
@@ -140,8 +140,13 @@
   </chapter>
 
   <chapter id="modload">
-     <title>Module Loading</title>
+     <title>Module Support</title>
+     <sect1><title>Module Loading</title>
 !Ekernel/kmod.c
+     </sect1>
+     <sect1><title>Inter Module support</title>
+!Ekernel/module.c
+     </sect1>
   </chapter>
 
   <chapter id="hardware">



-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
