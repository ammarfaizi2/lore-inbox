Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130065AbRBVUkG>; Thu, 22 Feb 2001 15:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129994AbRBVUj5>; Thu, 22 Feb 2001 15:39:57 -0500
Received: from [199.239.160.155] ([199.239.160.155]:64780 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S129688AbRBVUjn>; Thu, 22 Feb 2001 15:39:43 -0500
Date: Thu, 22 Feb 2001 12:39:40 -0800
From: Robert Read <rread@datarithm.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] use correct include dir for build tools
Message-ID: <20010222123940.A20319@tenchi.datarithm.net>
Mail-Followup-To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please apply one line patch to the top level Makefile.  This points
the build tools at the correct linux include dir.

diff -ru linux/Makefile linux-makefile/Makefile
--- linux/Makefile      Wed Feb 21 16:54:15 2001
+++ linux-makefile/Makefile     Thu Feb 22 12:34:57 2001
@@ -16,7 +16,7 @@
 FINDHPATH      = $(HPATH)/asm $(HPATH)/linux $(HPATH)/scsi $(HPATH)/net
 
 HOSTCC         = gcc
-HOSTCFLAGS     = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
+HOSTCFLAGS     = -I$(HPATH) -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
 
 CROSS_COMPILE  =

