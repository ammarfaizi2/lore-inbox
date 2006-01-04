Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWADUxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWADUxH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 15:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWADUxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 15:53:07 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:36813 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1030248AbWADUxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 15:53:06 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] i386: enable 4k stacks by default
Date: Thu, 05 Jan 2006 07:53:00 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <35dor152f8ehril7qh22oi8sgkjdohd9jv@4ax.com>
References: <20060104145138.GN3831@stusta.de>
In-Reply-To: <20060104145138.GN3831@stusta.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006 15:51:38 +0100, Adrian Bunk <bunk@stusta.de> wrote:

>This patch enables 4k stacks by default.
>
>4k stacks have become a well-tested feature used fore a long time in 
>Fedora and even in RHEL 4.
>
>There are no known problems in in-kernel code with 4k stacks still 
>present after Neil's patch that went into -mm nearly two months ago.
>
>Defaulting to 4k stacks in -mm kernel will give some more testing 
>coverage and should show whether there are really no problems left.
>
>Keeping the option for now should make the people happy who want to use 
>the experimental -mm kernel but don't trust the well-tested 4k stacks.
>
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
>--- linux-2.6.15-rc5-mm3-full/arch/i386/Kconfig.debug.old	2006-01-04 11:43:55.000000000 +0100
>+++ linux-2.6.15-rc5-mm3-full/arch/i386/Kconfig.debug	2006-01-04 11:44:14.000000000 +0100
>@@ -53,8 +53,8 @@
> 	  If in doubt, say "N".
> 
> config 4KSTACKS
>-	bool "Use 4Kb for kernel stacks instead of 8Kb"
>-	depends on DEBUG_KERNEL
>+	bool "Use 4Kb for kernel stacks instead of 8Kb" if DEBUG_KERNEL
>+	default y
> 	help
> 	  If you say Y here the kernel will use a 4Kb stacksize for the
> 	  kernel stack attached to each process/thread. This facilitates

Perhaps mention 4k + 4k stacks, the separate irq stacks used with 4k option?  

Grant.
