Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbTJVLUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 07:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbTJVLUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 07:20:47 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:53775 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263606AbTJVLUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 07:20:45 -0400
Date: Wed, 22 Oct 2003 21:20:35 +1000
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: scx200_wdt: Include linux/fs.h for struct file
Message-ID: <20031022112035.GA25439@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

This patch adds an explicit inclusion of linux/fs.h as it needs to
dereference struct file *.  This is needed for it to compile on
non-i386 architectures.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/drivers/char/watchdog/scx200_wdt.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/char/watchdog/scx200_wdt.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 scx200_wdt.c
--- kernel-source-2.5/drivers/char/watchdog/scx200_wdt.c	9 Aug 2003 08:11:55 -0000	1.1.1.3
+++ kernel-source-2.5/drivers/char/watchdog/scx200_wdt.c	22 Oct 2003 11:16:59 -0000
@@ -27,6 +27,7 @@
 #include <linux/reboot.h>
 #include <linux/pci.h>
 #include <linux/scx200.h>
+#include <linux/fs.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>

--WIyZ46R2i8wDzkSu--
