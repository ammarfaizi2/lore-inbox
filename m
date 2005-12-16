Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbVLPATk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbVLPATk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVLPATk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:19:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:11232 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750987AbVLPATk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:19:40 -0500
Date: Fri, 16 Dec 2005 01:19:34 +0100
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>, dada1@cosmobay.com,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: Re: [discuss] [patch 3/3] x86_64: Node local pda take 2 -- node local pda allocation
Message-ID: <20051216001934.GN23384@wotan.suse.de>
References: <20051215023345.GB3787@localhost.localdomain> <20051215023748.GD3787@localhost.localdomain> <20051215094232.GX23384@wotan.suse.de> <20051215184704.GA3882@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215184704.GA3882@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So are you suggesting I use alloc_bootmem_node and allocate PDA for
> NR_CPUS?

Continue to allocate the boot PDA of the BP statically - this should
be ok because BP should be always on node 0 (or if you're paranoid
about it you could also reallocate, but it's probably not needed) 

And for the APs you allocate the PDA in smpboot.c before actually sending
the startup IPI to the AP. 

-Andi

