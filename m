Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286172AbRLJH1D>; Mon, 10 Dec 2001 02:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286174AbRLJH0x>; Mon, 10 Dec 2001 02:26:53 -0500
Received: from zero.tech9.net ([209.61.188.187]:42502 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S286172AbRLJH0o>;
	Mon, 10 Dec 2001 02:26:44 -0500
Subject: Re: "Colo[u]rs"
From: Robert Love <rml@tech9.net>
To: Stevie O <stevie@qrpff.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011210020236.01cca428@whisper.qrpff.net>
In-Reply-To: <5.1.0.14.2.20011210020236.01cca428@whisper.qrpff.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 10 Dec 2001 02:26:47 -0500
Message-Id: <1007969208.1237.32.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-10 at 02:07, Stevie O wrote:
> After a few failed web searches (combos like 'linux cache color' just gave 
> me a bunch of references to video), I am resorting to this list for this 
> question.
> 
> What exactly do y'all mean by these "colors"? Task colors, cache colors, 
> and probably a few other colors i've missed/forgotten about. What do these 
> colors represent? How are they used to group tasks/cache entries? Is what 
> they're actually 

Cache color is how many indexes there are into a cache.  Caches
typically aren't direct mapped: they are indexed into cache lines by a
hash.  This means that certain memory values (of the 2^32 on your PC)
will map to the same cache line.  This means only one can be there at
the same time, and the newer one throws the old one out.

Coloring of data structures is down to give random offsets to data such
that they are not are multiples of the some value and thus don't map to
the same cache line.  This is what Linux's slab allocator is meant to
do.

	Robert Love

