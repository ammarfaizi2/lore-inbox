Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbTBOQia>; Sat, 15 Feb 2003 11:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbTBOQia>; Sat, 15 Feb 2003 11:38:30 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:30218 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262208AbTBOQi3>; Sat, 15 Feb 2003 11:38:29 -0500
Date: Sat, 15 Feb 2003 16:48:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: clean up SLAB_KERNEL non-usage
Message-ID: <20030215164824.C21238@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030215114054.GA32256@holomorphy.com> <20030215114931.A18281@infradead.org> <20030215120324.GG29983@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030215120324.GG29983@holomorphy.com>; from wli@holomorphy.com on Sat, Feb 15, 2003 at 04:03:24AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 04:03:24AM -0800, William Lee Irwin III wrote:
> On Sat, Feb 15, 2003 at 03:40:54AM -0800, William Lee Irwin III wrote:
> >> Use SLAB_KERNEL and SLAB_ATOMIC instead of GFP_KERNEL and GFP_ATOMIC
> >> when passing args to slab allocation functions.
> 
> On Sat, Feb 15, 2003 at 11:49:31AM +0000, Christoph Hellwig wrote:
> > Why?  I'd prefer to completly get rid of the SLAB_ flags instead.
> > (stupid slowaris compat..)
> 
> IMHO different API, different flags. The inverse is not that difficult
> to produce, though.

I don't think this make much sense - kmalloc is a a different interface to
the same slab code and uses GFP_ flags, and __alloc_pages uses it aswell.

