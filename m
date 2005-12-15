Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161061AbVLOIW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161061AbVLOIW7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 03:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbVLOIW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 03:22:59 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:56968 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1161061AbVLOIW6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 03:22:58 -0500
Message-ID: <43A127D3.1070106@cosmosbay.com>
Date: Thu, 15 Dec 2005 09:22:43 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>, dada1@cosmobay.com
Subject: Re: [patch 3/3] x86_64: Node local pda take 2 -- node local pda allocation
References: <20051215023345.GB3787@localhost.localdomain> <20051215023748.GD3787@localhost.localdomain>
In-Reply-To: <20051215023748.GD3787@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai a écrit :
> Patch uses a static PDA array early at boot and reallocates processor PDA
> with node local memory when kmalloc is ready, just before pda_init.
> The boot_cpu_pda is needed since the cpu_pda is used even before pda_init for
> that cpu is called.   
> (pda_init is called when APs are brought on at rest_init().  But
> setup_per_cpu_areas is called early in start_kernel and 
> sched_init uses the per-cpu offset table early)

That seems good, thank you !

Do you have an idea of the performance gain we could expect from this node 
local pda allocation ?

Say a CPU is on Node 1,  was a change in pda (allocated on Node 0) immediatly 
mirrored on remote node or not ?

Eric
