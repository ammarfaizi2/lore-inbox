Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269239AbUIBWG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269239AbUIBWG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269107AbUIBVcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:32:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:38572 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269177AbUIBV0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:26:43 -0400
Date: Thu, 2 Sep 2004 23:26:34 +0200
From: Andi Kleen <ak@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       Paul Mackerras <paulus@samba.org>, ak@muc.de, davem@davemloft.net,
       Andi Kleen <ak@suse.de>, wli@holomorphy.com,
       "David S. Miller" <davem@redhat.com>, raybry@sgi.com,
       manfred@colorfullife.com, linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>, vrajesh@umich.edu,
       hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64 support added
Message-ID: <20040902212634.GJ16175@wotan.suse.de>
References: <20040827172337.638275c3.davem@davemloft.net> <20040827173641.5cfb79f6.akpm@osdl.org> <20040828010253.GA50329@muc.de> <20040827183940.33b38bc2.akpm@osdl.org> <16687.59671.869708.795999@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0408272021070.16607@schroedinger.engr.sgi.com> <20040827204241.25da512b.akpm@osdl.org> <Pine.LNX.4.58.0408272121300.16949@schroedinger.engr.sgi.com> <20040827223954.7d021aac.akpm@osdl.org> <1094012028.6539.320.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094012028.6539.320.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 02:13:49PM +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2004-08-28 at 15:39, Andrew Morton wrote:
> 
> > atomic64_t already appears to be implemented on alpha, ia64, mips, s390 and
> > sparc64.
> > 
> > As I said - for both these applications we need a new type which is
> > atomic64_t on 64-bit and atomic_t on 32-bit.
> 
> Implementing it on ppc64 is trivial. I'd vote for atomic_long_t though
> that is either 32 bits on 32 bits archs or 64 bits on 64 bits arch, as
> it would be a real pain (spinlock & all) to get a 64 bits atomic on
> ppc32

I would do atomic64 on 64bit archs only and then do a wrapper 
somewhere that defines atomiclongt based on BITSPERLONG 

-Andi

P.S. sorry for the missing underscores, but i am typing this
on a japanese keyboard and i just cannot find it.

