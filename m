Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262599AbSJTGmR>; Sun, 20 Oct 2002 02:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262582AbSJTGmR>; Sun, 20 Oct 2002 02:42:17 -0400
Received: from 78-168.M.dial.o-tel-o.net ([212.144.78.168]:48904 "EHLO
	dd8ne.ampr.org") by vger.kernel.org with ESMTP id <S262495AbSJTGmR>;
	Sun, 20 Oct 2002 02:42:17 -0400
Message-Id: <200210200648.g9K6mkD05952@dd8ne.ampr.org>
Content-Type: text/plain; charset=US-ASCII
From: Hans-Joachim Hetscher <dd8ne@dd8ne.ampr.org>
Reply-To: dd8ne@bnv-bamberg.de
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.44: net/ipv4/ip_proc.c compile error fix for AX25 enabled 
Date: Sun, 20 Oct 2002 08:48:45 +0200
X-Mailer: KMail [version 1.3.1]
Cc: ralf@linux-mips.org.linux-hams@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ip_proc.c does't compile for CONFIG_AX25.

Here the patch ...


diff -u net/ipv4/ip_proc.c~ net/ipv4/ip_proc.c
--- net/ipv4/ip_proc.c~ Sun Oct 20 08:15:20 2002
+++ net/ipv4/ip_proc.c  Sun Oct 20 08:19:03 2002
@@ -33,7 +33,7 @@

 #ifdef CONFIG_PROC_FS
 #ifdef CONFIG_AX25
-
+#include <linux/ax25.h>
 /* ------------------------------------------------------------------------ */
 /*
  *     ax25 -> ASCII conversion
