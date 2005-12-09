Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbVLIWUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVLIWUr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 17:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVLIWUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 17:20:47 -0500
Received: from ns2.suse.de ([195.135.220.15]:1167 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932476AbVLIWUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 17:20:46 -0500
Date: Fri, 9 Dec 2005 23:20:45 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Christoph Lameter <clameter@engr.sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-ia64@ver.kernel.org, ak@suse.de
Subject: Re: [RFC] Introduce atomic_long_t
Message-ID: <20051209222045.GL11190@wotan.suse.de>
References: <Pine.LNX.4.62.0512091053260.2656@schroedinger.engr.sgi.com> <20051209201127.GE23349@stusta.de> <Pine.LNX.4.62.0512091352590.3182@schroedinger.engr.sgi.com> <20051209220226.GG23349@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209220226.GG23349@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd say the sequence is:
> 1. create an linux/atomic.h the #include's asm/atomic.h
> 2. convert all asm/atomic.h to use linux/atomic.h
> 3. move common code to linux/atomic.h

I don't think there is much common code actually. atomic_t 
details vary widly between architectures. Just defining
a few macros to others is really not significant. I think 
Christoph's original patch was just fine.

-Andi
