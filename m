Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262853AbVBBXTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbVBBXTA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 18:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVBBXQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:16:01 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:41129 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262660AbVBBXOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:14:35 -0500
Message-ID: <42015ED8.9000303@us.ibm.com>
Date: Wed, 02 Feb 2005 15:14:32 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386/mach-default/topology.c: make cpu_devices static
References: <20050131234228.GS21437@stusta.de>
In-Reply-To: <20050131234228.GS21437@stusta.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me!

Acked-by: Matthew Dobson <colpatch@us.ibm.com>

Adrian Bunk wrote:

>This patch makes a needlessly global struct static.
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
>---
>
> arch/i386/mach-default/topology.c |    2 +-
> include/asm-i386/cpu.h            |    1 -
> 2 files changed, 1 insertion(+), 2 deletions(-)
>
>This patch was already sent on:
>- 16 Jan 2005
>
>--- linux-2.6.11-rc1-mm1-full/include/asm-i386/cpu.h.old	2005-01-16 05:41:55.000000000 +0100
>+++ linux-2.6.11-rc1-mm1-full/include/asm-i386/cpu.h	2005-01-16 05:42:09.000000000 +0100
>@@ -12,7 +12,6 @@
> struct i386_cpu {
> 	struct cpu cpu;
> };
>-extern struct i386_cpu cpu_devices[NR_CPUS];
> extern int arch_register_cpu(int num);
> #ifdef CONFIG_HOTPLUG_CPU
> extern void arch_unregister_cpu(int);
>--- linux-2.6.11-rc1-mm1-full/arch/i386/mach-default/topology.c.old	2005-01-16 05:42:18.000000000 +0100
>+++ linux-2.6.11-rc1-mm1-full/arch/i386/mach-default/topology.c	2005-01-16 05:42:43.000000000 +0100
>@@ -30,7 +30,7 @@
> #include <linux/nodemask.h>
> #include <asm/cpu.h>
> 
>-struct i386_cpu cpu_devices[NR_CPUS];
>+static struct i386_cpu cpu_devices[NR_CPUS];
> 
> int arch_register_cpu(int num){
> 	struct node *parent = NULL;
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

