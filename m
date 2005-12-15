Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422668AbVLOJme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422668AbVLOJme (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422664AbVLOJme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:42:34 -0500
Received: from mail.suse.de ([195.135.220.2]:7820 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422668AbVLOJmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:42:33 -0500
Date: Thu, 15 Dec 2005 10:42:32 +0100
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>, dada1@cosmobay.com
Subject: Re: [discuss] [patch 3/3] x86_64: Node local pda take 2 -- node local pda allocation
Message-ID: <20051215094232.GX23384@wotan.suse.de>
References: <20051215023345.GB3787@localhost.localdomain> <20051215023748.GD3787@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215023748.GD3787@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 06:37:48PM -0800, Ravikiran G Thirumalai wrote:
> Patch uses a static PDA array early at boot and reallocates processor PDA
> with node local memory when kmalloc is ready, just before pda_init.
> The boot_cpu_pda is needed since the cpu_pda is used even before pda_init for
> that cpu is called.   
> (pda_init is called when APs are brought on at rest_init().  But
> setup_per_cpu_areas is called early in start_kernel and 
> sched_init uses the per-cpu offset table early)
> 

That is why I suggested to allocate it in smpboot.c in advance before
starting the AP.  Can you please do that change? 

-Andi

