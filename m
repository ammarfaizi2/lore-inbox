Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbULLUh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbULLUh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 15:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbULLUh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 15:37:27 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:17423 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261870AbULLUhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 15:37:20 -0500
Message-ID: <41BCAE31.7030702@hp.com>
Date: Sun, 12 Dec 2004 15:46:41 -0500
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ia64 smpboot.c: remove an unused function
References: <20041212193921.GA22324@stusta.de>
In-Reply-To: <20041212193921.GA22324@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>The patch below removes an unused global functions.
>
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
>--- linux-2.6.10-rc2-mm4-full/arch/ia64/kernel/smpboot.c.old	2004-12-12 02:51:04.000000000 +0100
>+++ linux-2.6.10-rc2-mm4-full/arch/ia64/kernel/smpboot.c	2004-12-12 02:51:18.000000000 +0100
>@@ -356,11 +356,6 @@
> 	return cpu_idle();
> }
> 
>-struct pt_regs * __devinit idle_regs(struct pt_regs *regs)
>-{
>-	return NULL;
>-}
>-
> struct create_idle {
> 	struct task_struct *idle;
> 	struct completion done;
>
>  
>
I don't believe this is unused.  At least not in 2.6.10-rc3.  fork_idle 
requires this function.

Bob
