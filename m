Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289832AbSAWMcw>; Wed, 23 Jan 2002 07:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289833AbSAWMcm>; Wed, 23 Jan 2002 07:32:42 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:169 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289832AbSAWMc1>; Wed, 23 Jan 2002 07:32:27 -0500
Date: Wed, 23 Jan 2002 14:28:54 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Ingo Molnar <mingo@elte.hu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: 2.5.2-pre2-3 SMP broken on UP boxen
In-Reply-To: <Pine.LNX.4.44.0201231420270.20635-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0201231426500.20902-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Zwane Mwaikambo wrote:

> Al Viro just asked me to try something, patch coming in...

Here's Al's suggestion, unfortunately the box is at home so i can't test 
it right now.


Cheers,
	Zwane Mwaikambo

--- linux-2.5.3-pre3/arch/i386/kernel/smpboot.c.orig	Wed Jan 23 14:23:49 2002
+++ linux-2.5.3-pre3/arch/i386/kernel/smpboot.c	Wed Jan 23 14:24:33 2002
@@ -1018,7 +1018,7 @@
 	boot_cpu_logical_apicid = logical_smp_processor_id();
 	map_cpu_to_boot_apicid(0, boot_cpu_apicid);
 
-	global_irq_holder = 0;
+	global_irq_holder = NO_PROC_ID;
 	current->cpu = 0;
 	smp_tune_scheduling();
 


