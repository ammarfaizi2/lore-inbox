Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbTCWBNf>; Sat, 22 Mar 2003 20:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbTCWBNf>; Sat, 22 Mar 2003 20:13:35 -0500
Received: from hydra.colinet.de ([194.231.113.36]:2052 "EHLO hydra.colinet.de")
	by vger.kernel.org with ESMTP id <S262190AbTCWBNd>;
	Sat, 22 Mar 2003 20:13:33 -0500
Subject: [PATCH] 2.5.65 fix jiffies compile warning in alpha/kernel/smp.c
To: linux-kernel@vger.kernel.org
Cc: kirk@colinet.de
Message-Id: <kirk-1030323014850.A01215@hydra.colinet.de>
X-Mailer: TkMail 4.0beta9
From: "T. Weyergraf" <kirk@colinet.de>
Date: Sun, 23 Mar 2003 01:48:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix more annoying compile problems due to wrong types
for comparing jiffies. This patch applies to alpha arch.

Regards,
Thomas Weyergraf

 
diff -p1 -urN linux-2.5.65/arch/alpha/kernel/smp.c linux-2.5.65-kirk1/arch/alpha/kernel/smp.c
--- linux-2.5.65/arch/alpha/kernel/smp.c	Mon Mar 17 22:43:50 2003
+++ linux-2.5.65-kirk1/arch/alpha/kernel/smp.c	Sun Mar 23 00:02:37 2003
@@ -114,3 +114,3 @@ wait_boot_cpu_to_stop(int cpuid)
 {
-	long stop = jiffies + 10*HZ;
+	unsigned long stop = jiffies + 10*HZ;
 
@@ -351,3 +351,3 @@ secondary_cpu_start(int cpuid, struct ta
 	struct pcb_struct *hwpcb, *ipcb;
-	long timeout;
+	unsigned long timeout;
 	  
@@ -430,3 +430,3 @@ smp_boot_one_cpu(int cpuid)
 	struct task_struct *idle;
-	long timeout;
+	unsigned long timeout;
 
@@ -818,3 +818,3 @@ smp_call_function_on_cpu (void (*func) (
 	struct smp_call_struct data;
-	long timeout;
+	unsigned long timeout;
 	int num_cpus_to_call;


-- 
Thomas Weyergraf                                                kirk@colinet.de
My Favorite IA64 Opcode-guess ( see arch/ia64/lib/memset.S )
"br.ret.spnt.few" - got back from getting beer, did not spend a lot.


