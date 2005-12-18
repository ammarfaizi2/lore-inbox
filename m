Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965293AbVLRWXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965293AbVLRWXa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 17:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965294AbVLRWX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 17:23:29 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:5040 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965293AbVLRWX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 17:23:29 -0500
Subject: Re: 2.6.15-rc5-rt2 build error
From: Lee Revell <rlrevell@joe-job.com>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20051218210614.75f424eb@mango.fruits.de>
References: <20051218210614.75f424eb@mango.fruits.de>
Content-Type: text/plain
Date: Sun, 18 Dec 2005 17:00:55 -0500
Message-Id: <1134943256.14510.13.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-18 at 21:06 +0100, Florian Schmidt wrote:
> config attached [cat .config|grep -v "#" >config]
> 
>   CC      lib/rwsem.o

Try the patches that Steven Rostedt posted in the "2.6.15-rc5-rt1 will
not compile" thread.  Not all of those seem to have made it into -rt2.

FWIW in order to compile -rt2 on x86-64 with !PREEMPT_RT this patch is
required:

Index: linux-2.6.15-rc5-rt1/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.15-rc5-rt1.orig/arch/x86_64/Kconfig       2005-12-12
10:56:37.000000000 -0500
+++ linux-2.6.15-rc5-rt1/arch/x86_64/Kconfig    2005-12-12
21:33:56.000000000 -0500
@@ -240,7 +240,6 @@
 
 config RWSEM_GENERIC_SPINLOCK
        bool
-       depends on PREEMPT_RT
        default y
 
 config RWSEM_XCHGADD_ALGORITHM


Lee

