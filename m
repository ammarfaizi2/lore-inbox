Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTKEKYR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 05:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbTKEKYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 05:24:17 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:59145 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S262790AbTKEKYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 05:24:03 -0500
Date: Wed, 5 Nov 2003 21:23:47 +1100
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [SYSCTL] BUS_ISA -> CTL_BUS_ISA
Message-ID: <20031105102347.GA31413@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This is a patch from Greg KH which fixes the name conflict between sysctl.h
and input.h on BUS_ISA.  It's been part of 2.5 for more than a year.

Thanks,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.4/include/linux/sysctl.h
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/include/linux/sysctl.h,v
retrieving revision 1.6
diff -u -r1.6 sysctl.h
--- kernel-source-2.4/include/linux/sysctl.h	3 Sep 2003 10:27:20 -0000	1.6
+++ kernel-source-2.4/include/linux/sysctl.h	5 Nov 2003 10:20:34 -0000
@@ -69,7 +69,7 @@
 /* CTL_BUS names: */
 enum
 {
-	BUS_ISA=1		/* ISA */
+	CTL_BUS_ISA=1		/* ISA */
 };
 
 /* CTL_KERN names: */
Index: kernel-source-2.4/arch/arm/kernel/isa.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/arch/arm/kernel/isa.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 isa.c
--- kernel-source-2.4/arch/arm/kernel/isa.c	18 Sep 2000 22:15:25 -0000	1.1.1.3
+++ kernel-source-2.4/arch/arm/kernel/isa.c	5 Nov 2003 10:20:25 -0000
@@ -38,7 +38,7 @@
 
 static struct ctl_table_header *isa_sysctl_header;
 
-static ctl_table ctl_isa[2] = {{BUS_ISA, "isa", NULL, 0, 0555, ctl_isa_vars},
+static ctl_table ctl_isa[2] = {{CTL_BUS_ISA, "isa", NULL, 0, 0555, ctl_isa_vars},
 			       {0}};
 static ctl_table ctl_bus[2] = {{CTL_BUS, "bus", NULL, 0, 0555, ctl_isa},
 			       {0}};

--EVF5PPMfhYS0aIcm--
