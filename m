Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285153AbRLFOxw>; Thu, 6 Dec 2001 09:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285164AbRLFOxn>; Thu, 6 Dec 2001 09:53:43 -0500
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:14791 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S285153AbRLFOxY>; Thu, 6 Dec 2001 09:53:24 -0500
Date: Thu, 6 Dec 2001 15:51:47 +0100 (CET)
From: Frank Cornelis <fcorneli@elis.rug.ac.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Russell King <rmk@arm.linux.org.uk>,
        Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: Re: misc_cache_init
In-Reply-To: <E16BEYZ-0001vX-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0112061545350.23443-100000@trappist.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > We already have this under a slightly different name (Alan didn't merge it
> > into Linus' kernel though from what I remember): pgtable_cache_init.
>
> I started merging it then Linus said no more low priority bits
>
> > This was used in -ac to initialise the ARM PTE slab, as well as the x86
> > PAE slabs immediately after the call to kmem_cache_sizes_init.
>
> its in Marcelo's tree I believe.

mmm... pgtable_cache_init is there for initing the pgtable cache, not 
other misc caches; it would be confusing start putting other cache inits 
inthere. Anyway I already solved my problem using 
	__initcall(my_cache_init_func);
which is a nice way to init stuff.

Frank.


