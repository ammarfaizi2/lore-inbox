Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752133AbWAEKrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbWAEKrd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 05:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbWAEKrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 05:47:33 -0500
Received: from seanodes.co.fr.clara.net ([212.43.220.11]:18056 "EHLO
	seanodes.co.fr.clara.net") by vger.kernel.org with ESMTP
	id S1752133AbWAEKrc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 05:47:32 -0500
From: =?iso-8859-1?q?Ga=EBl_UTARD?= <gael.utard@seanodes.com>
Organization: Seanodes
To: kai@germaschewski.name, sam@ravnborg.org
Subject: [PATCH] kbuild: fix external modules build
Date: Thu, 5 Jan 2006 11:46:58 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601051146.58824.gael.utard@seanodes.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch 2dd34b488a99135ad2a529e33087ddd6a09e992a breaks external modules 
build since include/linux/autoconf.h is not found in the header files 
directories.

Signed-off-by: Gaël Utard <gael.utard@seanodes.com>

--- linux-2.6.15/Makefile.orig	2006-01-05 10:54:15.000000000 +0100
+++ linux-2.6.15/Makefile	2006-01-05 10:55:05.000000000 +0100
@@ -348,7 +348,7 @@
 # Needed to be compatible with the O= option
 LINUXINCLUDE    := -Iinclude \
                    $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
-		   -include include/linux/autoconf.h
+		   -include linux/autoconf.h
 
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
