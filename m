Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbULLTmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbULLTmN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 14:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbULLTmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 14:42:12 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33041 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262091AbULLTmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 14:42:04 -0500
Date: Sun, 12 Dec 2004 20:41:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/kallsyms.c: make some code static
Message-ID: <20041212194154.GC22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 kernel/kallsyms.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/kernel/kallsyms.c.old	2004-12-12 02:56:23.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/kernel/kallsyms.c	2004-12-12 02:56:45.000000000 +0100
@@ -326,7 +326,7 @@
 	return 0;
 }
 
-struct seq_operations kallsyms_op = {
+static struct seq_operations kallsyms_op = {
 	.start = s_start,
 	.next = s_next,
 	.stop = s_stop,
@@ -368,7 +368,7 @@
 	.release = kallsyms_release,
 };
 
-int __init kallsyms_init(void)
+static int __init kallsyms_init(void)
 {
 	struct proc_dir_entry *entry;
 

