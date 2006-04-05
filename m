Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWDERHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWDERHB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 13:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWDERG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 13:06:58 -0400
Received: from xenotime.net ([66.160.160.81]:2200 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751294AbWDERGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 13:06:52 -0400
Date: Wed, 5 Apr 2006 10:09:07 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org, horms@verge.net.au,
       fastboot@osdl.org
Subject: Re: [PATCH] kexec: typo in machine_kexec()
Message-Id: <20060405100907.ff1318cf.rdunlap@xenotime.net>
In-Reply-To: <m13bgs3tuz.fsf@ebiederm.dsl.xmission.com>
References: <20060404234806.GA25761@verge.net.au>
	<20060404200557.1e95bdd8.rdunlap@xenotime.net>
	<20060405055754.GA3277@verge.net.au>
	<200604051624.35358.kernel@kolivas.org>
	<m13bgs3tuz.fsf@ebiederm.dsl.xmission.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2006 09:49:40 -0600 Eric W. Biederman wrote:

one typo (below):

> How does this look for making that comment readable?
> 
> Eric
> 
> 
> diff --git a/arch/i386/kernel/machine_kexec.c b/arch/i386/kernel/machine_kexec.c
> index f73d737..7a344b6 100644
> --- a/arch/i386/kernel/machine_kexec.c
> +++ b/arch/i386/kernel/machine_kexec.c
> @@ -189,14 +189,11 @@ NORET_TYPE void machine_kexec(struct kim
>  	memcpy((void *)reboot_code_buffer, relocate_new_kernel,
>  						relocate_new_kernel_size);
>  
> -	/* The segment registers are funny things, they are
> -	 * automatically loaded from a table, in memory wherever you
> -	 * set them to a specific selector, but this table is never
> -	 * accessed again you set the segment to a different selector.
> -	 *
> -	 * The more common model is are caches where the behide
> -	 * the scenes work is done, but is also dropped at arbitrary
> -	 * times.
> +	/* The segment registers are funny things, they have both a
> +	 * visible and an invisible part.  Whenver the visible part is
*                                          Whenever
> +	 * set to a specific selector, the invisible part is loaded
> +	 * with from a table in memory.  At no other time is the
> +	 * descriptor table in memory accessed. 
>  	 *
>  	 * I take advantage of this here by force loading the
>  	 * segments, before I zap the gdt with an invalid value.

Much better, thanks.

---
~Randy
