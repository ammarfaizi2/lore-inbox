Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318274AbSHUN0L>; Wed, 21 Aug 2002 09:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318283AbSHUN0L>; Wed, 21 Aug 2002 09:26:11 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:34064 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S318274AbSHUN0K>; Wed, 21 Aug 2002 09:26:10 -0400
Date: Wed, 21 Aug 2002 15:29:44 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Mike Galbraith <efault@gmx.de>
Cc: Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>,
       Gilad Ben-Yossef <gilad@benyossef.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Alloc and lock down large amounts of memory
In-Reply-To: <5.1.0.14.2.20020821060719.00b7bd48@pop.gmx.net>
Message-ID: <Pine.LNX.4.44.0208211528180.3407-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2002, Mike Galbraith wrote:

> At 03:08 PM 8/20/2002 -0500, Bhavana Nagendra wrote:
> > >
> > > Curiosity:  why do you want to do device DMA buffer
> > > allocation from userland?
> >
> >I need 256M memory for a graphics operation.  It's a requiremment,
> >can't change it. There will be other reasonably sized allocs in kernel
> >space, this is a special case that will be done from userland. As
> >discussed earlier in this thread, there's no good way of alloc()ing
> >and pinning that much in DMA memory space, is there?
> 
> Not that I know of.  It seems to me that any interface that tried
> to provide this would have to know what kind of device is going
> to DMA from/to that ram.
> 
> Usually, when someone needs a large gob of contiguous ram,
> folks suggest doing the allocation in kernel, and early.
> 
BTW: What is the limit for pci_alloc_consistent and friends? Can it really 
provide 256MB?

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

