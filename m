Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbUCOQND (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 11:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbUCOQMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 11:12:54 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:52476 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S262672AbUCOQMg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 11:12:36 -0500
Date: Mon, 15 Mar 2004 09:12:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>, Andrew Morton <akpm@osdl.org>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.4-bk3 ppc32 compile fix
Message-ID: <20040315161235.GE4342@smtp.west.cox.net>
References: <20040314225913.4654347b@jack.colino.net> <20040315155120.GA4342@smtp.west.cox.net> <035701c40aa5$1549b490$3cc8a8c0@epro.dom> <20040315160313.GB4342@smtp.west.cox.net> <036801c40aa7$06d40170$3cc8a8c0@epro.dom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <036801c40aa7$06d40170$3cc8a8c0@epro.dom>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 05:03:16PM +0100, Colin Leroy wrote:
> Hi again,
> 
> > The problem is that on PPC32 (and probably sparc64) 'asmlinkage' is a
> > useless keyword, and should just be removed from
> > include/asm-ppc/unistd.h.
> 
> Here's another patch, then :)
> (not changing sparc64 stuff... I can't test it)

Here it is inline:

--- include/asm-ppc/unistd.h.orig	2004-03-11 03:55:23.000000000 +0100
+++ include/asm-ppc/unistd.h	2004-03-15 17:01:49.000000000 +0100
@@ -415,10 +415,10 @@
 int sys_pipe(int __user *fildes);
 int sys_ptrace(long request, long pid, long addr, long data);
 struct sigaction;
-asmlinkage long sys_rt_sigaction(int sig,
-				const struct sigaction __user *act,
-				struct sigaction __user *oact,
-				size_t sigsetsize);
+long sys_rt_sigaction(int sig,
+		      const struct sigaction __user *act,
+		      struct sigaction __user *oact,
+		      size_t sigsetsize);
 
 #endif /* __KERNEL_SYSCALLS__ */
 

Andrew, can you please take this up?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
