Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbVCSN33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbVCSN33 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbVCSNWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:22:09 -0500
Received: from coderock.org ([193.77.147.115]:1160 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262478AbVCSNRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:17:42 -0500
Subject: [patch 06/10] init/do_mounts_initrd.c: fix sparse warning
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, adobriyan@mail.ru
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:17:32 +0100
Message-Id: <20050319131732.75E071F23D@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/init/do_mounts_initrd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN init/do_mounts_initrd.c~sparse-init_do_mounts_initrd init/do_mounts_initrd.c
--- kj/init/do_mounts_initrd.c~sparse-init_do_mounts_initrd	2005-03-18 20:05:18.000000000 +0100
+++ kj-domen/init/do_mounts_initrd.c	2005-03-18 20:05:18.000000000 +0100
@@ -41,7 +41,7 @@ static int __init do_linuxrc(void * shel
 static void __init handle_initrd(void)
 {
 	int error;
-	int i, pid;
+	int pid;
 
 	real_root_dev = new_encode_dev(ROOT_DEV);
 	create_dev("/dev/root.old", Root_RAM0, NULL);
@@ -58,7 +58,7 @@ static void __init handle_initrd(void)
 
 	pid = kernel_thread(do_linuxrc, "/linuxrc", SIGCHLD);
 	if (pid > 0) {
-		while (pid != sys_wait4(-1, &i, 0, NULL))
+		while (pid != sys_wait4(-1, NULL, 0, NULL))
 			yield();
 	}
 
_
