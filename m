Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265715AbUBBQNq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 11:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265718AbUBBQNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 11:13:45 -0500
Received: from witte.sonytel.be ([80.88.33.193]:26293 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265715AbUBBQM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 11:12:27 -0500
Date: Mon, 2 Feb 2004 17:11:53 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: jmorris@redhat.com, sds@epoch.ncsc.mil, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] SElinux compile fix
Message-ID: <Pine.GSO.4.58.0402021710460.19699@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Spinlock code needs <linux/sched.h>

--- linux-2.6.2-rc3/security/selinux/ss/services.c	2004-01-01 20:23:54.000000000 +0100
+++ linux-m68k-2.6.2-rc3/security/selinux/ss/services.c	2004-01-09 22:16:22.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/in.h>
+#include <linux/sched.h>
 #include <asm/semaphore.h>
 #include "flask.h"
 #include "avc.h"
--- linux-2.6.2-rc3/security/selinux/ss/sidtab.c	2004-01-01 20:23:54.000000000 +0100
+++ linux-m68k-2.6.2-rc3/security/selinux/ss/sidtab.c	2004-01-09 22:13:55.000000000 +0100
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
+#include <linux/sched.h>
 #include "flask.h"
 #include "security.h"
 #include "sidtab.h"

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
