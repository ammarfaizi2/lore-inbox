Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262771AbUKXRLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbUKXRLq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUKXRKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:10:40 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:29589 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262771AbUKXRHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:07:36 -0500
Subject: Suspend 2 merge: 32/51: Make show task non-static.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101297602.5805.317.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:59:55 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to show the state of a task when a process fails to enter
the refrigerator.

diff -ruN 819-export-show-task-old/kernel/sched.c 819-export-show-task-new/kernel/sched.c
--- 819-export-show-task-old/kernel/sched.c	2004-11-06 09:27:29.549112136 +1100
+++ 819-export-show-task-new/kernel/sched.c	2004-11-04 16:27:41.000000000 +1100
@@ -32,7 +32,6 @@
 #include <linux/security.h>
 #include <linux/notifier.h>
 #include <linux/profile.h>
-#include <linux/suspend.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
 #include <linux/smp.h>
@@ -3719,7 +3718,7 @@
 	return list_entry(p->sibling.next,struct task_struct,sibling);
 }
 
-static void show_task(task_t * p)
+void show_task(task_t * p)
 {
 	task_t *relative;
 	unsigned state;


