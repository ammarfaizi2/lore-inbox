Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVCTLOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVCTLOh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 06:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVCTLOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 06:14:37 -0500
Received: from coderock.org ([193.77.147.115]:25739 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262132AbVCTLOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 06:14:33 -0500
Date: Sun, 20 Mar 2005 12:14:27 +0100
From: Domen Puncer <domen@coderock.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, adobriyan@mail.ru
Subject: Re: [patch 06/10 with proper signed-off] init/do_mounts_initrd.c: fix sparse warning
Message-ID: <20050320111426.GA14273@nd47.coderock.org>
References: <20050319131732.75E071F23D@trashy.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319131732.75E071F23D@trashy.coderock.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/init/do_mounts_initrd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN init/do_mounts_initrd.c~sparse-init_do_mounts_initrd init/do_mounts_initrd.c
--- kj/init/do_mounts_initrd.c~sparse-init_do_mounts_initrd	2005-03-20 12:11:17.000000000 +0100
+++ kj-domen/init/do_mounts_initrd.c	2005-03-20 12:11:17.000000000 +0100
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
