Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWG1EeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWG1EeG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 00:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWG1EeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 00:34:06 -0400
Received: from mail.fieldses.org ([66.93.2.214]:11161 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1750870AbWG1EeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 00:34:04 -0400
Date: Fri, 28 Jul 2006 00:34:03 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG() on apm resume in 2.6.18-rc2
Message-ID: <20060728043403.GA21441@fieldses.org>
References: <20060727033819.GA368@fieldses.org> <20060726231049.e9a0346e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726231049.e9a0346e.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 11:10:49PM -0700, Andrew Morton wrote:
> This?

Yep.  With 2.6.18-rc2 + that patch, the BUG() is gone and suspend-resume
works fine.

Thanks!--b.

> --- a/./arch/i386/kernel/cpu/mcheck/mce.h~mce-section-fix
> +++ a/./arch/i386/kernel/cpu/mcheck/mce.h
> @@ -9,6 +9,6 @@ void winchip_mcheck_init(struct cpuinfo_
>  /* Call the installed machine check handler for this CPU setup. */
>  extern fastcall void (*machine_check_vector)(struct pt_regs *, long error_code);
>  
> -extern int mce_disabled __initdata;
> +extern int mce_disabled;
>  extern int nr_mce_banks;
>  
> _
> 
