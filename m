Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSFUAEh>; Thu, 20 Jun 2002 20:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315943AbSFUAEg>; Thu, 20 Jun 2002 20:04:36 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:60678 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S315595AbSFUAEg>;
	Thu, 20 Jun 2002 20:04:36 -0400
Date: Thu, 20 Jun 2002 19:51:14 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <torvalds@transmeta.com>
Subject: [PATCH] 2.5.24 : include/linux/intermezzo_fs.h
Message-ID: <Pine.LNX.4.44.0206201948010.977-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  This addresses a compile error where the struct nameidata was 
referenced, but not defined. The patch fixes this problem.

Regards,
Frank

--- include/linux/intermezzo_fs.h.old	Tue Jun 18 00:13:41 2002
+++ include/linux/intermezzo_fs.h	Tue Jun 18 00:13:26 2002
@@ -19,6 +19,7 @@
 #ifdef __KERNEL__
 #include <linux/smp.h>
 #include <linux/fsfilter.h>
+#include <linux/namei.h>
 
 /* fixups for fs.h */
 #ifndef fs_down

