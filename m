Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbUKCRFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbUKCRFQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 12:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUKCRE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 12:04:29 -0500
Received: from cantor.suse.de ([195.135.220.2]:19657 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261739AbUKCREQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 12:04:16 -0500
Date: Wed, 3 Nov 2004 18:02:08 +0100
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Matt Tolentino <metolent@snoqualmie.dp.intel.com>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] remove direct mem_map refs for x86-64
Message-ID: <20041103170208.GB1514@wotan.suse.de>
References: <200411031647.iA3GlmBm016951@snoqualmie.dp.intel.com> <1099499567.2813.24.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099499567.2813.24.camel@laptop.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 05:32:47PM +0100, Arjan van de Ven wrote:
> On Wed, 2004-11-03 at 08:47 -0800, Matt Tolentino wrote:
> > -                       page = pgdat->node_mem_map + i;
> > -		total++;
> > +			page = pfn_to_page(pgdat->node_start_pfn + i);
> > +			total++;
> 
> this can't be correct... pfn_to_page starts to count from address 0
> while the original code starts from the start of the node..

That is why he adds node_start_pfn

-Andi
