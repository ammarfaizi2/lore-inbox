Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281855AbRKRG2I>; Sun, 18 Nov 2001 01:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281531AbRKRG16>; Sun, 18 Nov 2001 01:27:58 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24187 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281513AbRKRG1t>; Sun, 18 Nov 2001 01:27:49 -0500
Date: Sun, 18 Nov 2001 07:27:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.>=13 VM/kswapd/shmem/Oracle issue (was Re: Google's mm problems)
Message-ID: <20011118072743.B25232@athlon.random>
In-Reply-To: <20011117165441.S1381@athlon.random> <Pine.LNX.4.33.0111180711260.644-100000@mikeg.weiden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0111180711260.644-100000@mikeg.weiden.de>; from mikeg@wen-online.de on Sun, Nov 18, 2001 at 07:17:02AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2001 at 07:17:02AM +0100, Mike Galbraith wrote:
> On Sat, 17 Nov 2001, Andrea Arcangeli wrote:
> 
> > If all your hardware is PCI nobody will make an allocation from the
> > ZONE_DMA classzone and so kswapd will never loop on the ZONE_DMA, as
> > instead can happen with -ac as soon as the ZONE_DMA becomes unfreeable
> > and under the low watermark (and "unfreeable" of course also means all
> > anon not locked memory but no swap installed in the machine).
> 
> We don't fallback to ZONE_DMA anymore?  (good)

we still fallback on the ZONE_DMA, otherwise mem=17m wouldn't boot :)

what we don't do is to try to balance the dma zone if nobody is asking
memory explicitly from the dma zone [isa users].

Andrea
