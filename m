Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbTF0KDr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 06:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbTF0KDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 06:03:47 -0400
Received: from ns.tasking.nl ([195.193.207.2]:55055 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S264198AbTF0KDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 06:03:45 -0400
To: linux-kernel@vger.kernel.org
Subject: drivers/scsi/aic7xxx/aic7xxx_core.c -Werror causes build to stop
Organization: Altium SOFTWARE B.V.
X-Face: "A(HPX!owGRCdtOX\NKs=ac*&x%/sYJMc;M<L&"^kH9ogp5;"w#UVc0yt3K{@n#.E+=k>qd bqZYYQvB9_xdS1l+B2\z;:p71RNxrja;ir>Dj?6%GzFA!o>gOL&G}8X;icnhqP|=TU,O@JVM%5LL:X ,G&IkRk9n%h7hZFUltu%RB=ctrdfu?[vSRV%Wzcn;#o>[K0C6_'q*~^+toc))w-Qb8*,afMHVCrNG6
X-Attribution: KB
Reply-To: kees.bakker@altium.nl (Kees Bakker)
From: kees.bakker@altium.nl (Kees Bakker)
Date: 27 Jun 2003 12:17:19 +0200
Message-ID: <sillvnomds.fsf@koli.tasking.nl>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.96
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To build 2.5.73 using my SuSE 8.2 system (gcc 3.3) I need the following
patch:

--- linux-2.5.73/drivers/scsi/aic7xxx/Makefile.orig	2003-06-22 20:33:34.000000000 +0200
+++ linux-2.5.73/drivers/scsi/aic7xxx/Makefile	2003-06-27 10:38:40.000000000 +0200
@@ -33,7 +33,7 @@
 						   aic79xx_proc.o	\
 						   aic79xx_osm_pci.o
 
-EXTRA_CFLAGS += -Idrivers/scsi -Werror
+EXTRA_CFLAGS += -Idrivers/scsi -Werror -Wno-sign-compare
 #EXTRA_CFLAGS += -g
 
 # Files generated that shall be removed upon make clean
--- linux-2.5.73/drivers/scsi/aic7xxx/aic7xxx_core.c.orig	2003-06-22 20:32:43.000000000 +0200
+++ linux-2.5.73/drivers/scsi/aic7xxx/aic7xxx_core.c	2003-06-27 11:35:37.000000000 +0200
@@ -73,7 +73,6 @@
 	"aic7892",
 	"aic7899"
 };
-static const u_int num_chip_names = NUM_ELEMENTS(ahc_chip_names);
 
 /*
  * Hardware error codes.


