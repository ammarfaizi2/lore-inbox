Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbULNTNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbULNTNw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 14:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbULNTNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 14:13:52 -0500
Received: from news.suse.de ([195.135.220.2]:45805 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261619AbULNTNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 14:13:49 -0500
Date: Tue, 14 Dec 2004 20:13:48 +0100
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
Message-ID: <20041214191348.GA27225@wotan.suse.de>
References: <Pine.SGI.4.61.0412141140030.22462@kzerza.americas.sgi.com> <9250000.1103050790@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9250000.1103050790@flay>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 10:59:50AM -0800, Martin J. Bligh wrote:
> > NUMA systems running current Linux kernels suffer from substantial
> > inequities in the amount of memory allocated from each NUMA node
> > during boot.  In particular, several large hashes are allocated
> > using alloc_bootmem, and as such are allocated contiguously from
> > a single node each.
> 
> Yup, makes a lot of sense to me to stripe these, for the caches that

I originally was a bit worried about the TLB usage, but it doesn't
seem to be a too big issue (hopefully the benchmarks weren't too
micro though)

> didn't Manfred or someone (Andi?) do this before? Or did that never
> get accepted? I know we talked about it a while back.

I talked about it, but never implemented it. I am not aware of any
other implementation of this before Brent's.

-Andi
