Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317389AbSGDKyC>; Thu, 4 Jul 2002 06:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317390AbSGDKyB>; Thu, 4 Jul 2002 06:54:01 -0400
Received: from cc36426-a.deven1.ov.nl.home.com ([212.120.104.114]:26214 "EHLO
	topicus.nl") by vger.kernel.org with ESMTP id <S317389AbSGDKyA>;
	Thu, 4 Jul 2002 06:54:00 -0400
Subject: 2.4.19-rc1 initrd typo fix
From: Klaasjan Brand <kjb@dds.nl>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 04 Jul 2002 12:55:41 +0200
Message-Id: <1025780141.12120.78.camel@topicus6>
Mime-Version: 1.0
X-MDRemoteIP: 192.168.3.5
X-Return-Path: kjb@dds.nl
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'm totally at a loss to where to send this, but I needed this fix to
build a kernel with initrd on sparc. Probably on every arch. Seems like
a typo to me.

Klaasjan


--- init/do_mounts.c.orig	Thu Jul  4 12:47:33 2002
+++ init/do_mounts.c	Thu Jul  4 12:47:50 2002
@@ -378,7 +378,7 @@
 	return sys_symlink(path + n + 5, name);
 }
 
-#if defined(CONFIG_BLOCK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
+#if defined(CONFIG_BLK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
 static void __init change_floppy(char *fmt, ...)
 {
 	struct termios termios;


