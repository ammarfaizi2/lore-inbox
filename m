Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318176AbSHDSkD>; Sun, 4 Aug 2002 14:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318184AbSHDSkD>; Sun, 4 Aug 2002 14:40:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32271 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318176AbSHDSkC>; Sun, 4 Aug 2002 14:40:02 -0400
Date: Sun, 4 Aug 2002 11:43:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Gruenbacher <agruen@suse.de>
cc: Alan Cox <alan@redhat.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Caches that shrink automatically
In-Reply-To: <200208041308.51638.agruen@suse.de>
Message-ID: <Pine.LNX.4.44.0208041142170.10314-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 4 Aug 2002, Andreas Gruenbacher wrote:
> 
> Currently there is no way for modules to define dynamically sized caches that 
> shrink upon memory pressure. We need this for implementing Extended Attribute 
> caches on ext2, ext3, and ReiserFS. Other caches could also make use of the 
> same mechanism (e.g., nfsd's permission cache, dcache, icache, dqache).

This is what the slablru patches should do.. Any slab user should be able 
to get a callback when the LRU decides that the page seems to be unused.

		Linus

