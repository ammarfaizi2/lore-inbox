Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316199AbSHRVPP>; Sun, 18 Aug 2002 17:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316217AbSHRVPP>; Sun, 18 Aug 2002 17:15:15 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:40452 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S316199AbSHRVPP>;
	Sun, 18 Aug 2002 17:15:15 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200208182119.g7ILJE205417@oboe.it.uc3m.es>
Subject: [PATCH] 2.5.31 missing EXPORT devfs/base.c
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Sun, 18 Aug 2002 23:19:14 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devfs_find_and_unregister is listed in the header files, but
not exported from the place where it matters. It's needed
in module cleanups/exit code.

Peter


--- linux-2.5.31/fs/devfs/base.c.orig	Sun Aug 11 03:41:22 2002
+++ linux-2.5.31/fs/devfs/base.c	Sun Aug 18 17:01:33 2002
@@ -2327,6 +2327,7 @@
 EXPORT_SYMBOL(devfs_auto_unregister);
 EXPORT_SYMBOL(devfs_get_unregister_slave);
 EXPORT_SYMBOL(devfs_get_name);
+EXPORT_SYMBOL(devfs_find_and_unregister);
 
 
 /**
