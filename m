Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbVH2TzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbVH2TzI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 15:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbVH2TzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 15:55:07 -0400
Received: from cantor.suse.de ([195.135.220.2]:22188 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751488AbVH2TzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 15:55:06 -0400
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [patch 2/3] x86_64: Run setup_per_cpu_areas and trap_init sooner
Date: Mon, 29 Aug 2005 21:55:00 +0200
User-Agent: KMail/1.8
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, bob.picco@hp.com
References: <resend.1.2982005.trini@kernel.crashing.org> <1.2982005.trini@kernel.crashing.org> <resend.2.2982005.trini@kernel.crashing.org>
In-Reply-To: <resend.2.2982005.trini@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508292155.01252.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +void __init early_setup_per_cpu_areas(void)
> +{
> +	static char cpu0[PERCPU_ENOUGH_ROOM]
> +		__attribute__ ((aligned (SMP_CACHE_BYTES)));

This needs a __cacheline_aligned too, otherwise there could be false sharing.

-Andi

