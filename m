Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130247AbQJaOtf>; Tue, 31 Oct 2000 09:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130235AbQJaOt0>; Tue, 31 Oct 2000 09:49:26 -0500
Received: from kanga.kvack.org ([209.82.47.3]:41999 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S130211AbQJaOtU>;
	Tue, 31 Oct 2000 09:49:20 -0500
Date: Tue, 31 Oct 2000 09:48:04 -0500 (EST)
From: <kernel@kvack.org>
To: Brian Gerst <bgerst@didntduck.org>
cc: Andi Kleen <ak@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: kmalloc() allocation.
In-Reply-To: <39FEC1FE.A6AB5C2A@didntduck.org>
Message-ID: <Pine.LNX.3.96.1001031094639.27969B-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000, Brian Gerst wrote:

> Andi Kleen wrote:
> > 
> > On Tue, Oct 31, 2000 at 01:11:29AM -0500, Brian Gerst wrote:
> > > This was just changed in 2.4 so that vmalloced pages are faulted in on
> > > demand.
> > 
> > Could you explain how it handles the vmalloc() -- vfree() -- vmalloc() of same
> > virtual space but different physical race ?
> 
> As far as I can tell (I didn't write the code), vfree didn't change. 
> It's only vmalloc that's lazy now.

The code for vmalloc allocates the pages at vmalloc time, not after.  The
TLB is populated lazily, but most definately not the page tables.

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
