Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282645AbRKZX0R>; Mon, 26 Nov 2001 18:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282652AbRKZX0I>; Mon, 26 Nov 2001 18:26:08 -0500
Received: from tahallah.demon.co.uk ([158.152.175.193]:60941 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S282645AbRKZXZ6>; Mon, 26 Nov 2001 18:25:58 -0500
Date: Mon, 26 Nov 2001 23:13:45 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] show_trace_task() sparc32
Message-ID: <Pine.LNX.4.33.0111262311170.29479-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since show_trace_task() has not been implemented in traps.c in the sparc32
tree, here's a quick and dirty patch to get the kernel to link properly.

--- linux-2.4.16/arch/sparc/kernel/traps.c.orig Mon Nov 26 23:13:32 2001
+++ linux-2.4.16/arch/sparc/kernel/traps.c      Mon Nov 26 23:14:21 2001
@@ -84,6 +84,14 @@
        printk("\n");
 }

+void show_trace_task (struct task_struct *tsk)
+{
+      if (!tsk)
+              return;
+
+       printk("show_trace_task() - not implemented yet.\n");
+}
+
 #define __SAVE __asm__ __volatile__("save %sp, -0x40, %sp\n\t")
 #define __RESTORE __asm__ __volatile__("restore %g0, %g0, %g0\n\t")

I don't know enough about the task stuff to implement this properly. I did
this patch for 2.4.15-pre9 but just noticed that 2.4.16 doesn't have it in
place.

-- 
Broken hearted, but not down.

http://www.tahallah.demon.co.uk

