Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279884AbRKRHOi>; Sun, 18 Nov 2001 02:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280814AbRKRHO2>; Sun, 18 Nov 2001 02:14:28 -0500
Received: from www.wen-online.de ([212.223.88.39]:13580 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S279884AbRKRHOL>;
	Sun, 18 Nov 2001 02:14:11 -0500
Date: Sun, 18 Nov 2001 08:14:00 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Andrea Arcangeli <andrea@suse.de>
cc: Arjan van de Ven <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.>=13 VM/kswapd/shmem/Oracle issue (was Re: Google's mm
 problems)
In-Reply-To: <20011118072743.B25232@athlon.random>
Message-ID: <Pine.LNX.4.33.0111180813110.309-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, Andrea Arcangeli wrote:

> On Sun, Nov 18, 2001 at 07:17:02AM +0100, Mike Galbraith wrote:
> > On Sat, 17 Nov 2001, Andrea Arcangeli wrote:
> >
> > > If all your hardware is PCI nobody will make an allocation from the
> > > ZONE_DMA classzone and so kswapd will never loop on the ZONE_DMA, as
> > > instead can happen with -ac as soon as the ZONE_DMA becomes unfreeable
> > > and under the low watermark (and "unfreeable" of course also means all
> > > anon not locked memory but no swap installed in the machine).
> >
> > We don't fallback to ZONE_DMA anymore?  (good)
>
> we still fallback on the ZONE_DMA, otherwise mem=17m wouldn't boot :)

(oops;)

> what we don't do is to try to balance the dma zone if nobody is asking
> memory explicitly from the dma zone [isa users].

Ah.. all clear.  Thanks.

	-Mike

