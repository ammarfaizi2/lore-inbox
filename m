Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVAUHRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVAUHRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 02:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVAUHRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 02:17:19 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55643
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262310AbVAUHRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:17:11 -0500
Date: Fri, 21 Jan 2005 08:17:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: OOM fixes 2/5
Message-ID: <20050121071711.GG17050@dualathlon.random>
References: <20050121054840.GA12647@dualathlon.random> <20050121054916.GB12647@dualathlon.random> <20050120222056.61b8b1c3.akpm@osdl.org> <1106289375.5171.7.camel@npiggin-nld.site> <20050120224645.3351d22c.akpm@osdl.org> <1106291065.5171.23.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106291065.5171.23.camel@npiggin-nld.site>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 06:04:25PM +1100, Nick Piggin wrote:
> OK this is a fairly lame example... but the current code is more or
> less just lucky that ZONE_DMA doesn't usually fill up with pinned mem
> on machines that need explicit ZONE_DMA allocations.

Yep. For the DMA zone all slab cache will be a memory pin (like ptes for
highmem, but not that many people runs with 3G of ram in ptes, and I
guess the ones doing it aren't normally using a mainline kernel in the
first place so they're likely not running into it either). While slab
cache pinning the normal zone has more probability of being reproduced
on l-k in random usages.
