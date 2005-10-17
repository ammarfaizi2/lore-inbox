Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVJQQ0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVJQQ0R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVJQQ0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:26:17 -0400
Received: from ns1.suse.de ([195.135.220.2]:39357 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932317AbVJQQ0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:26:16 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
Date: Mon, 17 Oct 2005 18:26:40 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Ravikiran G Thirumalai <kiran@scalex86.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org
References: <20051017093654.GA7652@localhost.localdomain> <200510171740.57614.ak@suse.de> <Pine.LNX.4.64.0510170901460.23590@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510170901460.23590@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510171826.40711.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 October 2005 18:02, Linus Torvalds wrote:
> On Mon, 17 Oct 2005, Andi Kleen wrote:
> > On Monday 17 October 2005 17:27, Linus Torvalds wrote:
> > > On Mon, 17 Oct 2005, Andi Kleen wrote:
> > > > The patch is actually not quite correct - in theory node 0 could be
> > > > too small to contain the full swiotlb bounce buffers.
> > >
> > > Is node 0 guaranteed to be all low-memory? What if it allocates stuff
> > > at the end of memory on NODE(0)?
> >
> > This is 64bit ... only low memory.
>
> Ehh.. No there isn't.
>
> PCI DMA isn't magically 64-bit, even on your Opteron.
>
> So low memory in this case is anything < 32 bits. How many bits the CPU
> has is immaterial.

That's completely new terminology. We always called all of ZONE_NORMAL low 
memory.

The 32bit DMA zone had no special name before the ZONE_DMA32 patches. 
With that they are called dma32 zone.

-Andi
