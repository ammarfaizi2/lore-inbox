Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267504AbUBSTgX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267505AbUBSTgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:36:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17281 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267504AbUBSTgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:36:17 -0500
Date: Thu, 19 Feb 2004 14:36:10 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Subject: Re: Intel x86-64 support patch breaks amd64
Message-ID: <20040219193606.GC31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20040219183448.GB8960@atomide.com> <20040220171337.10cd1ae8.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220171337.10cd1ae8.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 05:13:37PM +0100, Andi Kleen wrote:
> --- linux-2.6.3/arch/x86_64/kernel/x8664_ksyms.c-o	2004-02-19 09:01:09.000000000 +0100
> +++ linux-2.6.3/arch/x86_64/kernel/x8664_ksyms.c	2004-02-19 09:08:04.000000000 +0100
> @@ -194,7 +194,9 @@
>  
>  EXPORT_SYMBOL(die_chain);
>  
> +#ifdef CONFIG_SMP_

		    ^ Isn't this a typo?

>  EXPORT_SYMBOL(cpu_sibling_map);
> +#endif
>  
>  extern void do_softirq_thunk(void);
>  EXPORT_SYMBOL_NOVERS(do_softirq_thunk);

	Jakub
