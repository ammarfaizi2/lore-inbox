Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263354AbSJFIBM>; Sun, 6 Oct 2002 04:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263357AbSJFIBM>; Sun, 6 Oct 2002 04:01:12 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:27923 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263354AbSJFIBL>;
	Sun, 6 Oct 2002 04:01:11 -0400
Date: Sun, 6 Oct 2002 10:06:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: alan@redhat.com, Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] aacraid - Makefile fix
Message-ID: <20021006100642.A13918@mars.ravnborg.org>
Mail-Followup-To: alan@redhat.com,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove obsolete O_TARGET from Makefile
Make include path relative

===== drivers/scsi/aacraid/Makefile 1.1 vs edited =====
--- 1.1/drivers/scsi/aacraid/Makefile	Wed Oct  2 22:37:46 2002
+++ edited/drivers/scsi/aacraid/Makefile	Sun Oct  6 10:00:06 2002
@@ -1,8 +1,6 @@
-
-EXTRA_CFLAGS	+= -I$(TOPDIR)/drivers/scsi
-
-O_TARGET	:= aacraid.o
-obj-m		:= $(O_TARGET)
+# Adaptec aacraid
+ 
+EXTRA_CFLAGS	+= -Idrivers/scsi
 
 obj-y		:= linit.o aachba.o commctrl.o comminit.o commsup.o \
 		   dpcsup.o rx.o sa.o
