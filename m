Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287570AbSAEG7U>; Sat, 5 Jan 2002 01:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287568AbSAEG7L>; Sat, 5 Jan 2002 01:59:11 -0500
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:9232 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S287562AbSAEG65>;
	Sat, 5 Jan 2002 01:58:57 -0500
Date: Sat, 5 Jan 2002 01:47:09 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.2-pre8: drivers/char/lp.c compile error
In-Reply-To: <Pine.LNX.4.33.0201050138500.12846-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0201050145270.12858-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch should do the trick.
Regards,
Frank

--- drivers/char/lp.c.old	Sat Jan  5 00:25:41 2002
+++ drivers/char/lp.c	Sat Jan  5 01:44:23 2002
@@ -683,7 +683,7 @@
 
 static kdev_t lp_console_device (struct console *c)
 {
-	return MKDEV(LP_MAJOR, CONSOLE_LP);
+	return mk_kdev(LP_MAJOR, CONSOLE_LP);
 }
 
 static struct console lpcons = {

On Sat, 5 Jan 2002, Frank Davis wrote:

> Hello all,
> 
> While 'make bzImage', I received the following error:
> 
> ...
> lp.c: In function 'lp_console_device':
> lp.c:686: imcompatible type in return
> lp.c:687: warning: control reaches end of non-void function
> Amake[2]: *** [lp.o] Error 1
> make[2]: Leaving directory '/usr/src/linux/drivers/char'
> ...
> 
> Regards,
> Frank
> 
> 

