Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWHHDjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWHHDjc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 23:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWHHDjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 23:39:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7617 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932299AbWHHDjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 23:39:31 -0400
Date: Mon, 7 Aug 2006 20:39:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg Banks <gnb@melbourne.sgi.com>, Paul Jackson <pj@sgi.com>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1 of 2] cpumask: use EXPORT_SYMBOL_GPL for new exports
Message-Id: <20060807203914.6aec29df.akpm@osdl.org>
In-Reply-To: <1155007534.29877.215.camel@hole.melbourne.sgi.com>
References: <1155007534.29877.215.camel@hole.melbourne.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2006 13:25:34 +1000
Greg Banks <gnb@melbourne.sgi.com> wrote:

> cpumask: use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL to export
> node_2_cpu_mask.  Thanks to Zwane Mwaikambo for pointing this out.
> 
> Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
> ---
> 
>  arch/i386/kernel/smpboot.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.18-rc2/arch/i386/kernel/smpboot.c
> ===================================================================
> --- linux-2.6.18-rc2.orig/arch/i386/kernel/smpboot.c
> +++ linux-2.6.18-rc2/arch/i386/kernel/smpboot.c
> @@ -609,7 +609,7 @@ extern struct {
>  /* which logical CPUs are on which nodes */
>  cpumask_t node_2_cpu_mask[MAX_NUMNODES] __read_mostly =
>  				{ [0 ... MAX_NUMNODES-1] = CPU_MASK_NONE };
> -EXPORT_SYMBOL(node_2_cpu_mask);
> +EXPORT_SYMBOL_GPL(node_2_cpu_mask);
>  /* which node each logical CPU is on */
>  int cpu_2_node[NR_CPUS] __read_mostly = { [0 ... NR_CPUS-1] = 0 };
>  EXPORT_SYMBOL(cpu_2_node);

All the existing exports in lib/cpumask.c are EXPORT_SYMBOL() so I'd be
inclined to make any new exports match that.

<edits the diffs>

OK?
