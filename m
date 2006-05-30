Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWE3Bca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWE3Bca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWE3Bc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:32:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21953 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932125AbWE3Bc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:32:27 -0400
Date: Mon, 29 May 2006 18:36:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 61/61] lock validator: enable lock validator in Kconfig
Message-Id: <20060529183641.09ca4e08.akpm@osdl.org>
In-Reply-To: <20060529212812.GI3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212812.GI3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:28:12 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> offer the following lock validation options:
> 
>  CONFIG_PROVE_SPIN_LOCKING
>  CONFIG_PROVE_RW_LOCKING
>  CONFIG_PROVE_MUTEX_LOCKING
>  CONFIG_PROVE_RWSEM_LOCKING
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  lib/Kconfig.debug |  167 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 167 insertions(+)
> 
> Index: linux/lib/Kconfig.debug
> ===================================================================
> --- linux.orig/lib/Kconfig.debug
> +++ linux/lib/Kconfig.debug
> @@ -184,6 +184,173 @@ config DEBUG_SPINLOCK
>  	  best used in conjunction with the NMI watchdog so that spinlock
>  	  deadlocks are also debuggable.
>  
> +config PROVE_SPIN_LOCKING
> +	bool "Prove spin-locking correctness"
> +	default y

err, I think I'll be sticking a `depends on X86' in there, thanks very
much.  I'd prefer that you be the first to test it ;)

