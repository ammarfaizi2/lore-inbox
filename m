Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315599AbSE2WYp>; Wed, 29 May 2002 18:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315606AbSE2WYo>; Wed, 29 May 2002 18:24:44 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:155 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S315599AbSE2WYn>; Wed, 29 May 2002 18:24:43 -0400
Date: Wed, 29 May 2002 15:24:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Linux 2.5.19
Message-ID: <20020529222429.GU5997@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.33.0205291146510.1344-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  The following fixes compilation with CONFIG_BLK_DEV_RAM=y
I assume that Rusty intended to use a test for CONFIG_BLK_DEV_RAM and
not BLOCK_DEV_RAM.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== init/do_mounts.c 1.16 vs edited =====
--- 1.16/init/do_mounts.c	Mon May 27 05:07:34 2002
+++ edited/init/do_mounts.c	Wed May 29 15:22:38 2002
@@ -365,7 +365,7 @@
 	return sys_symlink(path + n + 5, name);
 }
 
-#if defined(BLOCK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
+#if defined(CONFIG_BLK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
 static void __init change_floppy(char *fmt, ...)
 {
 	struct termios termios;
