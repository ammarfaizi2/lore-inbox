Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVAUHVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVAUHVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 02:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVAUHVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 02:21:06 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:63323
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262155AbVAUHVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:21:04 -0500
Date: Fri, 21 Jan 2005 08:21:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: OOM fixes 2/5
Message-ID: <20050121072104.GH17050@dualathlon.random>
References: <20050121054840.GA12647@dualathlon.random> <20050121054916.GB12647@dualathlon.random> <20050120222056.61b8b1c3.akpm@osdl.org> <1106289375.5171.7.camel@npiggin-nld.site> <20050120224645.3351d22c.akpm@osdl.org> <m14qhb1cpm.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m14qhb1cpm.fsf@muc.de>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 08:08:21AM +0100, Andi Kleen wrote:
> So at least for GFP_DMA it seems to be definitely needed.

Indeed. Plus if you add pci32 zone, it'll be needed for it too on
x86-64, like for the normal zone on x86, since ptes will go in highmem
while pci32 allocations will not. So while floppy might be fixed, this
issue would be for brand new pci32 zone needed by some device (i.e.
nvidia, so not such a unlikely corner case).
