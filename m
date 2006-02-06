Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWBFKHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWBFKHv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWBFKHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:07:51 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:18113 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1750907AbWBFKHu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:07:50 -0500
Message-ID: <43E71FEC.6020506@cosmosbay.com>
Date: Mon, 06 Feb 2006 11:07:40 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: bcrl@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, V2] i386: instead of poisoning .init zone, change protection
 bits to force a fault
References: <m1r76rft2t.fsf@ebiederm.dsl.xmission.com>	<m17j8jfs03.fsf@ebiederm.dsl.xmission.com>	<20060128235113.697e3a2c.akpm@osdl.org>	<200601291620.28291.ioe-lkml@rameria.de>	<20060129113312.73f31485.akpm@osdl.org>	<43DD1FDC.4080302@cosmosbay.com>	<20060129200504.GD28400@kvack.org>	<43DD2C15.1090800@cosmosbay.com>	<20060204144111.7e33569f.akpm@osdl.org>	<43E7108A.8030001@cosmosbay.com> <20060206012809.3045207c.akpm@osdl.org>
In-Reply-To: <20060206012809.3045207c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 06 Feb 2006 11:07:43 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :

> But I'm inclined to drop the whole patch - I don't see how it can detect
> any bugs which CONFIG_DEBUG_PAGEALLOC won't find.
> 

If CONFIG_DEBUG_PAGEALLOC is selected, does a page freed by free_page(addr); 
guaranted not being reused later ?

Anyway, the CONFIG_DEBUG_INITDATA was a temporary patch in order to track the 
accesses to non possible cpus percpu data. So if you feel all such accesses 
were cleaned, we can drop the patch...

Eric
