Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWG0Ga0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWG0Ga0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 02:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWG0Ga0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 02:30:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:25513 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932079AbWG0Ga0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 02:30:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=epu0PKViVcBNHzFgB4EXfCxoZpsxvgD1+glmJBCOee0njpHxQVJDNtM7NBw+Ya27IUG2wcxcTOoxL6nMUsVZrpQK3JywRBrUpN7Pd6DnT7k1Uicqz/pGPsQUVKWdv9L+dEsWxRwxNb/OiYMEHkyoOHBo1dFot/1E0lFiGpJi7bI=
Date: Thu, 27 Jul 2006 08:29:32 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: BUG() on apm resume in 2.6.18-rc2
Message-ID: <20060727062932.GA32598@leiferikson.gentoo>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060727033819.GA368@fieldses.org> <20060726231049.e9a0346e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726231049.e9a0346e.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (GNU/Linux)
From: Johannes Weiner <hnazfoo@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 26, 2006 at 11:10:49PM -0700, Andrew Morton wrote:
> This?
> 
> --- a/./arch/i386/kernel/cpu/mcheck/mce.h~mce-section-fix
> +++ a/./arch/i386/kernel/cpu/mcheck/mce.h
> @@ -9,6 +9,6 @@ void winchip_mcheck_init(struct cpuinfo_
>  /* Call the installed machine check handler for this CPU setup. */
>  extern fastcall void (*machine_check_vector)(struct pt_regs *, long error_code);
>  
> -extern int mce_disabled __initdata;
> +extern int mce_disabled;
>  extern int nr_mce_banks;

What hinted you to that? I didn't read much oopses, so...

Thanks,
Hannes
