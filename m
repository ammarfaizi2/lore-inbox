Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277727AbRJIF7v>; Tue, 9 Oct 2001 01:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277726AbRJIF7l>; Tue, 9 Oct 2001 01:59:41 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:32144 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S277725AbRJIF7f>; Tue, 9 Oct 2001 01:59:35 -0400
Date: Mon, 8 Oct 2001 23:59:39 -0600
Message-Id: <200110090559.f995xd923187@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: torvalds@transmeta.com, arjanv@redhat.com, andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ATA RAID breaks modular IDE compile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, all. In 2.4.11-pre6, the ATA RAID code breaks compiling IDE as a
module: I get duplicate "init_module" symbols. I don't even have
ATA RAID enabled!

I've appended a (crude) patch for drivers/ide/Makefile that fixed the
immediate problem for me. Perhaps this should be applied in order to
encourage a better fix to be submitted promptly ;-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

--- Makefile~	Mon Oct  8 23:07:43 2001
+++ Makefile	Mon Oct  8 23:48:30 2001
@@ -10,7 +10,7 @@
 
 O_TARGET := idedriver.o
 
-export-objs		:= ide.o ide-features.o ataraid.o
+export-objs		:= ide.o ide-features.o #ataraid.o
 list-multi		:= ide-mod.o ide-probe-mod.o
 
 obj-y		:=
