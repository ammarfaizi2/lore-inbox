Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267371AbTAQEvh>; Thu, 16 Jan 2003 23:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267373AbTAQEvh>; Thu, 16 Jan 2003 23:51:37 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:11787
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267371AbTAQEvg>; Thu, 16 Jan 2003 23:51:36 -0500
Date: Fri, 17 Jan 2003 00:01:10 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@digeo.com>
Subject: [PATCH][2.5] fix for_each_cpu compilation on UP
Message-ID: <Pine.LNX.4.44.0301162358060.24250-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a definition for for_each_cpu when !CONFIG_SMP

Please apply

Index: linux-2.5.58-cpu_hotplug/include/linux/smp.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.58/include/linux/smp.h,v
retrieving revision 1.1.1.1.2.3
diff -u -r1.1.1.1.2.3 smp.h
--- linux-2.5.58-cpu_hotplug/include/linux/smp.h	17 Jan 2003 03:13:12 -0000	1.1.1.1.2.3
+++ linux-2.5.58-cpu_hotplug/include/linux/smp.h	17 Jan 2003 03:14:40 -0000
@@ -109,6 +109,7 @@
 #define num_booting_cpus()			1
 #define cpu_possible(cpu)			({ BUG_ON((cpu) != 0); 1; })
 #define smp_prepare_boot_cpu()			do {} while (0)
+#define for_each_cpu(cpu, mask)			for (cpu = 0; cpu == 0; cpu++)
 
 struct notifier_block;
 

-- 
function.linuxpower.ca

