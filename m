Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276640AbRJGXW6>; Sun, 7 Oct 2001 19:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276641AbRJGXWs>; Sun, 7 Oct 2001 19:22:48 -0400
Received: from CPE-61-9-149-34.vic.bigpond.net.au ([61.9.149.34]:49656 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S276640AbRJGXWf>; Sun, 7 Oct 2001 19:22:35 -0400
Message-ID: <3BC0E21F.8F926D2F@eyal.emu.id.au>
Date: Mon, 08 Oct 2001 09:15:43 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: 2.4.11-pre5: Makefile fixes for symbol exports
Content-Type: multipart/mixed;
 boundary="------------E5F993B61993CFF7C9E18C69"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E5F993B61993CFF7C9E18C69
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Some modules with exported symbols are missing from their respective
Makefile and cause a build failure. This simply adds them there.

drivers/ieee1394/Makefile
drivers/ide/Makefile

I only test the i386 build.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
--------------E5F993B61993CFF7C9E18C69
Content-Type: text/plain; charset=us-ascii;
 name="2.4.11-pre5-exports-ieee1394.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.11-pre5-exports-ieee1394.patch"

--- linux/drivers/ieee1394/Makefile.orig	Mon Oct  8 08:53:16 2001
+++ linux/drivers/ieee1394/Makefile	Mon Oct  8 08:53:39 2001
@@ -4,7 +4,7 @@
 
 O_TARGET := ieee1394drv.o
 
-export-objs := ieee1394_syms.o
+export-objs := ieee1394_syms.o ohci1394.o
 
 list-multi := ieee1394.o
 ieee1394-objs := ieee1394_core.o ieee1394_transactions.o hosts.o \

--------------E5F993B61993CFF7C9E18C69
Content-Type: text/plain; charset=us-ascii;
 name="2.4.11-pre5-exports-ide.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.11-pre5-exports-ide.patch"

--- linux/drivers/ide/Makefile.orig	Mon Oct  8 08:52:14 2001
+++ linux/drivers/ide/Makefile	Mon Oct  8 08:52:33 2001
@@ -10,7 +10,7 @@
 
 O_TARGET := idedriver.o
 
-export-objs		:= ide.o ide-features.o
+export-objs		:= ide.o ide-features.o ataraid.o
 list-multi		:= ide-mod.o ide-probe-mod.o
 
 obj-y		:=

--------------E5F993B61993CFF7C9E18C69--

