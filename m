Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbUCCDqR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 22:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbUCCDqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 22:46:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32969 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262342AbUCCDqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 22:46:11 -0500
Date: Tue, 2 Mar 2004 19:46:08 -0800
From: "David S. Miller" <davem@redhat.com>
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
Cc: linux-kernel@vger.kernel.org, wesolows@foobazco.org
Subject: Re: [SPARC][patch] sys_ioperm
Message-Id: <20040302194608.3c0445d6.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58L.0403021316370.7737@alpha.zarz.agh.edu.pl>
References: <Pine.LNX.4.58L.0403021316370.7737@alpha.zarz.agh.edu.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004 13:24:03 +0100 (CET)
Wojciech 'Sas' Cieciwa <cieciwa@alpha.zarz.agh.edu.pl> wrote:

> I try to build linux-2.6.4-rc1 with cset-20040302_0009 on SPARC.
> And I got error:
> 
> In file included from include/linux/unistd.h:9,
>                  from init/main.c:21:
> include/asm/unistd.h:464: error: conflicting types for `sys_ioperm'
> include/linux/syscalls.h:291: error: previous declaration of `sys_ioperm'
> make[1]: *** [init/main.o] Error 1
> make: *** [init] Error 2
> 
> Fixed this (?) by this patch: 

We can just remove that line entirely from unistd.h, and that is the
change I have added to my tree.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/03/02 19:40:14-08:00 davem@nuts.davemloft.net 
#   [SPARC]: Kill sys_ioperm decl from unistd.h
# 
# include/asm-sparc/unistd.h
#   2004/03/02 19:37:09-08:00 davem@nuts.davemloft.net +0 -1
#   [SPARC]: Kill sys_ioperm decl from unistd.h
# 
diff -Nru a/include/asm-sparc/unistd.h b/include/asm-sparc/unistd.h
--- a/include/asm-sparc/unistd.h	Tue Mar  2 19:43:19 2004
+++ b/include/asm-sparc/unistd.h	Tue Mar  2 19:43:19 2004
@@ -461,7 +461,6 @@
 				unsigned long addr, unsigned long len,
 				unsigned long prot, unsigned long flags,
 				unsigned long fd, unsigned long pgoff);
-asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int on);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
