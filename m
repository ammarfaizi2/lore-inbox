Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310367AbSCBMsV>; Sat, 2 Mar 2002 07:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310369AbSCBMsK>; Sat, 2 Mar 2002 07:48:10 -0500
Received: from cobae1.consultronics.on.ca ([205.210.130.26]:30875 "EHLO
	cobae1.consultronics.on.ca") by vger.kernel.org with ESMTP
	id <S310367AbSCBMrw>; Sat, 2 Mar 2002 07:47:52 -0500
Date: Sat, 2 Mar 2002 07:47:51 -0500
From: Greg Louis <glouis@dynamicro.on.ca>
To: LKML <linux-kernel@vger.kernel.org>
Subject: mini [PATCH] 2.4.19-pre2-ac1 one sched hunk missing
Message-ID: <20020302124750.GA7351@athame.dynamicro.on.ca>
Reply-To: Greg Louis <glouis@dynamicro.on.ca>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.4.19pre2ac1/init/do_mounts.c.orig	Sat Mar  2 07:39:00 2002
+++ linux-2.4.19pre2ac1/init/do_mounts.c	Sat Mar  2 07:39:00 2002
@@ -527,8 +527,7 @@
 		pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 		if (pid > 0) {
 			while (pid != wait(&i)) {
-				current->policy |= SCHED_YIELD;
-				schedule();
+				yield();
 			}
 		}
 		if (MAJOR(real_root_dev) != RAMDISK_MAJOR


-- 
| G r e g  L o u i s          | gpg public key:      |
|   http://www.bgl.nu/~glouis |   finger greg@bgl.nu |
