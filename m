Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315233AbSDWP15>; Tue, 23 Apr 2002 11:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315234AbSDWP14>; Tue, 23 Apr 2002 11:27:56 -0400
Received: from jalon.able.es ([212.97.163.2]:23494 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S315233AbSDWP14>;
	Tue, 23 Apr 2002 11:27:56 -0400
Date: Tue, 23 Apr 2002 17:27:49 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Robert Love <rml@tech9.net>
Subject: exporting task_nice in O(1)-sched
Message-ID: <20020423152749.GC1697@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Found this building bproc. New O(1) scheduler kills the nice field in
task struct. It gives a way to fix the niceness (set_user_nice()), but
the funtion to _query_ is not exported. Any particular reason ?

Patch:

--- linux/kernel/ksyms.c.org	2002-04-23 16:56:27.000000000 +0200
+++ linux/kernel/ksyms.c	2002-04-23 16:56:47.000000000 +0200
@@ -455,6 +455,7 @@
 EXPORT_SYMBOL(schedule_timeout);
 EXPORT_SYMBOL(sys_sched_yield);
 EXPORT_SYMBOL(set_user_nice);
+EXPORT_SYMBOL(task_nice);
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL_GPL(set_cpus_allowed);
 #endif

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre7-jam6 #2 SMP mar abr 23 16:56:56 CEST 2002 i686
