Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbULLXth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbULLXth (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 18:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbULLXtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 18:49:33 -0500
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:13189 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262175AbULLXtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 18:49:21 -0500
Date: Mon, 13 Dec 2004 00:42:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041212234256.GK6272@elf.ucw.cz>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BCD5F3.80401@kolivas.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >The overhead is a single l1 cacheline in the paths manipulating HZ
> >(rather than having an immediate value hardcoded in the asm, it reads it
> >from a memory location not in the icache). Plus there are some
> >conversion routines in the USER_HZ usages. It's not a measurable
> >difference.
> 
> Just being devils advocate here...
> 
> I had variable Hz in my tree for a while and found there was one 
> solitary purpose to setting Hz to 100; to silence cheap capacitors.
> 
> The rest of my users that were setting Hz to 100 for so-called 
> performance gains were doing so under the false impression that cpu 
> usage was lower simply because of the woefully inaccurate cpu usage 
> calcuation at 100Hz.
> 
> The performance benefit, if any, is often lost in noise during 
> benchmarks and when there, is less than 1%. So I was wondering if you 
> had some specific advantage in mind for this patch? Is there some 
> arch-specific advantage? I can certainly envision disadvantages to lower Hz.

Actually, I measured about 1W power savings with HZ=100. That's about
as much as spindown of disk saves...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
