Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbQKPMX7>; Thu, 16 Nov 2000 07:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbQKPMXv>; Thu, 16 Nov 2000 07:23:51 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:7139 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129132AbQKPMXf>;
	Thu, 16 Nov 2000 07:23:35 -0500
Date: Thu, 16 Nov 2000 06:53:30 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: aeb@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10 truncate() change broke `dd'
In-Reply-To: <200011161132.MAA26011@harpo.it.uu.se>
Message-ID: <Pine.GSO.4.21.0011160637290.11017-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2000, Mikael Pettersson wrote:

> On Thu, 16 Nov 2000, Alexander Viro wrote:
> 
> > And what kind of meaning would you assign to truncate on floppy?
> 
> On a block or char device, truncate == lseek seems reasonable.

Huh? On regular files ftruncate() doesn't modify the current position
at all. Try and you'll see. Besides, WTF _is_ lseek() for a character
device?

> My guess is that dd uses ftruncate because that's correct for
> regular files and has happened to also work (as an alias for
> lseek) for devices.
> 
> > Use conv=notrunc.
> 
> I didn't know about notrunc. Yet another GNU invention?

Maybe, but I doubt it. Anyway, it made its way into 4.4BSD, it's present
in Solaris, it's in SuS and AFAIK in POSIX. GNU might be the origin, but
it might equally well be a BSDism.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
