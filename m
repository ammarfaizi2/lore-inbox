Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317096AbSF1KIB>; Fri, 28 Jun 2002 06:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSF1KIB>; Fri, 28 Jun 2002 06:08:01 -0400
Received: from [194.252.160.219] ([194.252.160.219]:5124 "EHLO is5.invers.fi")
	by vger.kernel.org with ESMTP id <S317096AbSF1KIA>;
	Fri, 28 Jun 2002 06:08:00 -0400
Date: Fri, 28 Jun 2002 14:10:59 +0300 (EEST)
From: tchiwam <tchiwam@ees2.oulu.fi>
X-X-Sender: tchiwam@is5.invers.fi
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.19-rc1 do_mount.c BLK vs BLOCK
Message-ID: <Pine.LNX.4.44.0206281406240.18631-100000@is5.invers.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	Here is a not so significant patch for 2.4.19-rc1. Maybe already
submited ? but this would help some of us not having the linker stoping at
the very end while the problem is at the really begining.

Philippe Trottier

in linux/init/do_mounts.c

--- do_mounts.c~	Fri Jun 28 13:58:16 2002
+++ do_mounts.c	Fri Jun 28 13:53:12 2002
@@ -378,7 +378,7 @@ static int __init create_dev(char *name,
 	return sys_symlink(path + n + 5, name);
 }

-#if defined(CONFIG_BLOCK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
+#if defined(CONFIG_BLK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
 static void __init change_floppy(char *fmt, ...)
 {
 	struct termios termios;

