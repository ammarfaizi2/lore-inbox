Return-Path: <linux-kernel-owner+w=401wt.eu-S967827AbWLIMF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967827AbWLIMF6 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 07:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967835AbWLIMF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 07:05:58 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:10255 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967827AbWLIMF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 07:05:57 -0500
Date: Sat, 9 Dec 2006 13:05:47 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, clameter@engr.sgi.com, apw@shadowen.org,
       akpm@osdl.org
Subject: Re: [RFC] [PATCH] virtual memmap on sparsemem v3 [2/4] generic virtual mem_map on sparsemem
Message-ID: <20061209120547.GB10380@osiris.ibm.com>
References: <20061208155608.14dcd2e5.kamezawa.hiroyu@jp.fujitsu.com> <20061208160454.33fedd3f.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208160454.33fedd3f.kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +#if (((BITS_PER_LONG/4) * PAGES_PER_SECTION) % PAGE_SIZE) != 0
> +#error "PAGE_SIZE/SECTION_SIZE relationship is not suitable for vmem_map"
> +#endif

Why the BITS_PER_LONG/4? Or to put in other words: why not simply
PAGES_PER_SECTION % PAGE_SIZE != 0 ?
