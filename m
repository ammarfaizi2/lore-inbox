Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262160AbSJJTtY>; Thu, 10 Oct 2002 15:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262159AbSJJTtD>; Thu, 10 Oct 2002 15:49:03 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:32529 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S262178AbSJJTsw>;
	Thu, 10 Oct 2002 15:48:52 -0400
Date: Thu, 10 Oct 2002 21:53:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: drivers/net/hamradio/soundmodem: distributed clean
Message-ID: <20021010215326.D577@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021010213440.A508@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021010213440.A508@mars.ravnborg.org>; from sam@ravnborg.org on Thu, Oct 10, 2002 at 09:34:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.748.1.3 -> 1.748.1.4
#	drivers/net/hamradio/soundmodem/Makefile	1.7     -> 1.8    
#	            Makefile	1.321   -> 1.322  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/10	sam@mars.ravnborg.org	1.748.1.4
# drivers/net/hamradio/soundmodem: distributed clean
# Move list of files out where it belongs
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Thu Oct 10 21:22:31 2002
+++ b/Makefile	Thu Oct 10 21:22:31 2002
@@ -683,10 +683,6 @@
 # Files removed with 'make mrproper'
 MRPROPER_FILES += \
 	include/linux/autoconf.h include/linux/version.h \
-	drivers/net/hamradio/soundmodem/sm_tbl_{afsk1200,afsk2666,fsk9600}.h \
-	drivers/net/hamradio/soundmodem/sm_tbl_{hapn4800,psk4800}.h \
-	drivers/net/hamradio/soundmodem/sm_tbl_{afsk2400_7,afsk2400_8}.h \
-	drivers/net/hamradio/soundmodem/gentbl \
 	sound/oss/*_boot.h sound/oss/.*.boot \
 	sound/oss/msndinit.c \
 	sound/oss/msndperm.c \
diff -Nru a/drivers/net/hamradio/soundmodem/Makefile b/drivers/net/hamradio/soundmodem/Makefile
--- a/drivers/net/hamradio/soundmodem/Makefile	Thu Oct 10 21:22:31 2002
+++ b/drivers/net/hamradio/soundmodem/Makefile	Thu Oct 10 21:22:31 2002
@@ -19,6 +19,12 @@
 host-progs := gentbl
 HOST_LOADLIBES := -lm
 
+# Files generated that shall be removed upon make clean
+clean-files  :=	sm_tbl_afsk1200.h   sm_tbl_afsk2400_7.h	\
+		sm_tbl_afsk2400_8.h sm_tbl_afsk2666.h	\
+		sm_tbl_psk4800.h    sm_tbl_hapn4800.h	\
+		sm_tbl_fsk9600.h
+
 include $(TOPDIR)/Rules.make
 
 # Dependencies on generates files need to be listed explicitly
