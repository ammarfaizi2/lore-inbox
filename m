Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVDYVot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVDYVot (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVDYVoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:44:39 -0400
Received: from mail.dif.dk ([193.138.115.101]:12443 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261234AbVDYVoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:44:22 -0400
Date: Mon, 25 Apr 2005 23:47:16 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: john stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, vojtech@suse.cz,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] i386: fix hpet for systems that don't support legacy
 replacement  (v. A0)
In-Reply-To: <1114463827.18098.22.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.62.0504252345500.2941@dragon.hyggekrogen.localhost>
References: <1114117417.19541.239.camel@cog.beaverton.ibm.com>
 <1114463827.18098.22.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2005, john stultz wrote:

> Andrew,
> 	Currently the i386 HPET code assumes the entire HPET implementation
> from the spec is present. This breaks on boxes that do not implement the
> optional legacy timer replacement functionality portion of the spec.
> 
> This patch, which is very similar to my x86-64 patch for the same issue,
> fixes the problem allowing i386 systems that cannot use the HPET for the
> timer interrupt and RTC to still use the HPET as a time source. I've
> tested this patch on a system systems without HPET, with HPET but
> without legacy timer replacement, as well as HPET with legacy timer
> replacement.
> 
> There has been no changes since this patch was sent out to lkml for
> review.
> 

Tiny, tiny nit : 

> -		if (is_hpet_enabled()){
> +		if (is_hpet_enabled() && hpet_use_timer){
                                                       ^^-- space here?


-- 
Jesper Juhl

