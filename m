Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281877AbRLLUQc>; Wed, 12 Dec 2001 15:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281887AbRLLUQW>; Wed, 12 Dec 2001 15:16:22 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:16166 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S281877AbRLLUQU> convert rfc822-to-8bit; Wed, 12 Dec 2001 15:16:20 -0500
Date: Wed, 12 Dec 2001 18:22:30 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Andrea Arcangeli <andrea@suse.de>
cc: Jens Axboe <axboe@suse.de>, "David S. Miller" <davem@redhat.com>,
        <gibbs@scsiguy.com>, <LB33JM16@yahoo.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: highmem, aic7xxx, and vfat: too few segs for dma mapping
In-Reply-To: <20011212143213.E4801@athlon.random>
Message-ID: <20011212181507.T1853-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Dec 2001, Andrea Arcangeli wrote:

> On Wed, Dec 12, 2001 at 10:36:54AM +0100, Jens Axboe wrote:

> > > If one really wants for some marketing reason to support these ugly and
> > > stinky '32 bit machines that want to provide more than 4GB of memory by
> > > shoe-horning complexity all over the place', one should use his brain,
> > > when so-featured, prior to writing clueless code.
> >
> > First of all, virt_to_bus just cannot work on some archetectures that
> > are just slightly more advanced than x86. I'm quite sure Davem is ready
> > to lecture you on this.
>
> yes, the whole point of the iommu work (replacement for virt_to_bus) is
> for the 64bit machines, not for the 32bit machines. It's to allow the
> 64bit machines to do zerocopy dma (no bounce buffers) on memory above 4G
> with pci32 devices that doesn't support DAC.

So, the PCI group should just have specified a 16 bit BUS and have told
that systems should implement some IOMMU in order to address the whole
memory. :-)

PCI was intended to be implemented as a LOCAL BUS with all agents on the
LOCAL BUS being able to talk with any other agent using a flat addressing
scheme. Your PCI thing does not look like true PCI to me, but rather like
some bad mutant that has every chance not to survive a long time.

  Gérard.

