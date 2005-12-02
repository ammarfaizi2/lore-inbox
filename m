Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932735AbVLBLnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbVLBLnv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 06:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbVLBLnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 06:43:51 -0500
Received: from cantor.suse.de ([195.135.220.2]:22425 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932735AbVLBLnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 06:43:50 -0500
Date: Fri, 2 Dec 2005 12:43:49 +0100
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, shai@scalex86.org
Subject: Re: [patch 1/3] x86_64: Node local PDA -- early cpu_to_node
Message-ID: <20051202114349.GL997@wotan.suse.de>
References: <20051202081028.GA5312@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202081028.GA5312@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_ACPI_NUMA
> + 	/*
> + 	 * Setup cpu_to_node using the SRAT lapcis & ACPI MADT table
> + 	 * info.
> + 	 */
> + 	for (i = 0; i < NR_CPUS; i++)
> + 		cpu_to_node[i] = apicid_to_node[x86_cpu_to_apicid[i]];
> +#endif

This should be in a separate function in srat.c. 

And are you sure it will work with k8topology.c. Doesn't look like
that to me.

-Andi
