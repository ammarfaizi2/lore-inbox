Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318626AbSHLCwo>; Sun, 11 Aug 2002 22:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318627AbSHLCwo>; Sun, 11 Aug 2002 22:52:44 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:52231 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S318626AbSHLCwn>;
	Sun, 11 Aug 2002 22:52:43 -0400
Date: Sun, 11 Aug 2002 22:44:23 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.31 : fs/intermezzo/vfs.c
Message-ID: <Pine.LNX.4.44.0208112243030.1283-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  This fixes an incorrect assignment within vfs.c . Please review.

Regards,
Frank

--- fs/intermezzo/vfs.c.old	Sun Aug 11 22:40:16 2002
+++ fs/intermezzo/vfs.c	Sun Aug 11 22:39:56 2002
@@ -131,7 +131,7 @@
 {
         int minor = presto_f2m(fset);
         int errorval = upc_comms[minor].uc_errorval;
-        kdev_t dev = fset->fset_mtpt->d_inode->i_dev;
+        kdev_t dev = fset->fset_mtpt->d_inode->i_rdev;
 
         if (errorval && errorval == (long)value && !is_read_only(dev)) {
                 CDEBUG(D_SUPER, "setting device %s read only\n", kdevname(dev));

