Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTHJKlI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 06:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTHJKlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 06:41:08 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:41923 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262273AbTHJKlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 06:41:05 -0400
Date: Sun, 10 Aug 2003 12:40:49 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test3
In-Reply-To: <Pine.LNX.4.44.0308082228470.1852-100000@home.osdl.org>
Message-ID: <Pine.GSO.4.21.0308101238570.19901-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Aug 2003, Linus Torvalds wrote:
> Merging the SELinux security architecture also ends up growing the patch, 
> even though it may not be all that noticeable for most normal users.

I need these patches to make it compile for m68k:

--- linux-2.6.0-test3/security/selinux/avc.c	Sat Aug  9 21:43:41 2003
+++ linux-m68k-2.6.0-test3/security/selinux/avc.c	Sun Aug 10 11:09:44 2003
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/dcache.h>
+#include <linux/init.h>
 #include <linux/skbuff.h>
 #include <net/sock.h>
 #include <linux/un.h>
--- linux-2.6.0-test3/security/selinux/ss/global.h	Sat Aug  9 21:43:41 2003
+++ linux-m68k-2.6.0-test3/security/selinux/ss/global.h	Sun Aug 10 11:22:59 2003
@@ -7,7 +7,7 @@
 #include <linux/ctype.h>
 #include <linux/in.h>
 #include <linux/spinlock.h>
-#include <asm/semaphore.h>
+#include <linux/sched.h>
 
 #include "flask.h"
 #include "avc.h"

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

