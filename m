Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267110AbSKMDtL>; Tue, 12 Nov 2002 22:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbSKMDtL>; Tue, 12 Nov 2002 22:49:11 -0500
Received: from modemcable217.53-202-24.mtl.mc.videotron.ca ([24.202.53.217]:46854
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267110AbSKMDtL>; Tue, 12 Nov 2002 22:49:11 -0500
Date: Tue, 12 Nov 2002 22:50:38 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH][2.5] smp_init 'CPUS done' looks strange
Message-ID: <Pine.LNX.4.44.0211122246540.24523-100000@montezuma.mastecende.com>
X-Operating-System: Linux 2.4.19-pre5-ac3-zm4
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, it would make sense in the future if smp_cpus_done actually gets a 
value denoting how many cpus are online.

	Zwane

Index: linux-2.5.47/init/main.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.47/init/main.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 main.c
--- linux-2.5.47/init/main.c	11 Nov 2002 03:59:33 -0000	1.1.1.1
+++ linux-2.5.47/init/main.c	13 Nov 2002 03:47:56 -0000
@@ -347,8 +347,8 @@
 	}
 
 	/* Any cleanup work */
-	printk("CPUS done %u\n", max_cpus);
-	smp_cpus_done(max_cpus);
+	printk("CPUS done %u\n", num_online_cpus());
+	smp_cpus_done(num_online_cpus());
 #if 0
 	/* Get other processors into their bootup holding patterns. */
 

-- 
function.linuxpower.ca

