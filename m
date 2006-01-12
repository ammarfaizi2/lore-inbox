Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbWALMuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbWALMuV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 07:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWALMuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 07:50:21 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:39577 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S964912AbWALMuU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 07:50:20 -0500
Date: Thu, 12 Jan 2006 05:50:20 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: Kyle McMartin <kyle@parisc-linux.org>, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] arch/parisc/mm/init.c: fix SMP=y compilation
Message-ID: <20060112125020.GG19769@parisc-linux.org>
References: <20060112092017.GP29663@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060112092017.GP29663@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 10:20:17AM +0100, Adrian Bunk wrote:
> This patch fixes the following compile error with CONFIG_SMP=y:
> @@ -802,7 +800,7 @@ void __init paging_init(void)
>  	pagetable_init();
>  	gateway_init();
>  	flush_cache_all_local(); /* start with known state */
> -	flush_tlb_all_local();
> +	flush_tlb_all_local(NULL);
>  

It's already this way in the parisc tree.  Kyle, did you miss part of
the merge?
