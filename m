Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWIHMYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWIHMYO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 08:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWIHMYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 08:24:14 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:15996 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750934AbWIHMYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 08:24:13 -0400
Date: Fri, 8 Sep 2006 14:23:27 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andi Kleen <ak@suse.de>
Subject: Re: 2.6.18-rc6-mm1 - x86_64-mm-lockdep-dont-force-framepointer.patch
Message-ID: <20060908122327.GD6913@osiris.boeblingen.de.ibm.com>
References: <20060908011317.6cb0495a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908011317.6cb0495a.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64-mm-lockdep-dont-force-framepointer.patch does this:

> Don't force frame pointers for lockdep
>
> Now that stacktrace supports dwarf2 don't force frame pointers for lockdep anymore
>
> Cc: mingo@elte.hu
> Signed-off-by: Andi Kleen <ak@suse.de>
>
> ---
>  lib/Kconfig.debug |    1 -
>  1 files changed, 1 deletion(-)
>
> Index: linux/lib/Kconfig.debug
> ===================================================================
> --- linux.orig/lib/Kconfig.debug
> +++ linux/lib/Kconfig.debug
> @@ -218,7 +218,6 @@ config LOCKDEP
>         bool
>         depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
>         select STACKTRACE
> -       select FRAME_POINTER

This patch affects all architecture. I'd like to keep the "select FRAME_POINTER"
for s390, since we don't support dwarf2.
So this patch should be dropped.
