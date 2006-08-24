Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWHXLdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWHXLdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWHXLdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:33:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:475 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751152AbWHXLdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:33:41 -0400
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] x86_64: mm fix x86 cpuid keys used in alternative_smp fix
Date: Thu, 24 Aug 2006 13:33:35 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Jan Beulich <jbeulich@novell.com>,
       linux-kernel@vger.kernel.org
References: <20060824105846.23508.59971.sendpatchset@sam.engr.sgi.com>
In-Reply-To: <20060824105846.23508.59971.sendpatchset@sam.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608241333.35985.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 August 2006 12:58, Paul Jackson wrote:
> From: Paul Jackson <pj@sgi.com>
> 
> The x86_64 crosstool build was failing due to:
> 
>   kernel/built-in.o(.smp_altinstructions+0x58): \
>     include/asm/spinlock.h:54: undefined reference to `X86_FEATURE_UP'
> 
> This reference to X86_FEATURE_UP was added to the definition of
> the alternative_smp() macro in alternative.h by the patch:
>   x86_64-mm-fix-x86-cpuid-keys-used-in-alternative_smp
> 
> The alternative_smp() macro is used in spinlock.h.
> 
> The definition of X86_FEATURE_UP is in asm-x86_64/cpufeature.h.
> If this is included in alternative.h, then the build succeeds.

Ok it seems to depend on the .config, but nobody before submitted 
the buggy .config

I folded the patch in

-Andi
