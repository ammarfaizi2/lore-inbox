Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284809AbRL3USd>; Sun, 30 Dec 2001 15:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284850AbRL3US2>; Sun, 30 Dec 2001 15:18:28 -0500
Received: from ns.suse.de ([213.95.15.193]:14603 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284809AbRL3USS>;
	Sun, 30 Dec 2001 15:18:18 -0500
Date: Sun, 30 Dec 2001 21:18:17 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: ACPI thermal compile fix for pre4
Message-ID: <Pine.LNX.4.33.0112302116410.7853-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looks like the includes shake up broke ACPI thermal.
(Needs 'jiffies')

Dave.

diff -u -r1.1.1.1 -r1.2
--- tzpolicy.c	2001/12/12 02:10:09	1.1.1.1
+++ tzpolicy.c	2001/12/30 20:12:40	1.2
@@ -31,6 +31,7 @@
 #include <linux/proc_fs.h>
 #include <linux/sysctl.h>
 #include <linux/pm.h>
+#include <linux/sched.h>

 #include <acpi.h>
 #include <bm.h>



-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs


