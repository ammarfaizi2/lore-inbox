Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132260AbQLNDmT>; Wed, 13 Dec 2000 22:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132261AbQLNDmM>; Wed, 13 Dec 2000 22:42:12 -0500
Received: from ip252.uni-com.net ([205.198.252.252]:9734 "HELO www.nondot.org")
	by vger.kernel.org with SMTP id <S132260AbQLNDmB>;
	Wed, 13 Dec 2000 22:42:01 -0500
Date: Wed, 13 Dec 2000 21:12:05 -0600 (CST)
From: Chris Lattner <sabre@nondot.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "Mohammad A. Haque" <mhaque@haque.net>, Ben Ford <ben@kalifornia.com>,
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.GSO.4.21.0012132037110.6300-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0012132106070.24665-100000@www.nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I do have one sensible question. Given that corba is while flexible a 
> > relatively expensive encoding system, wouldn't it be better to keep corba
> > out of kernel space and talk something which is a simple and cleaner encoding

> p9fs exists.  I didn't see these patches since August, but probably I can poke
> Roman into porting it to the current tree.  9P is quite simple and unlike
> CORBA it had been designed for taking kernel stuff to userland.  Besides,
> authors definitely understand UNIX...

One thing that you might want to mention Alexander: 9P is not a general
communications protocol.  In fact, it doesn't work very well across the
internet at all.  To get decent performance, the Plan9 group (which, is a
very cool group.  :) has to specify a new protocol that competes with TCP
on the level of complexity (IL: http://plan9.bell-labs.com/sys/doc/il/il.html)

Also, 9P is a general communications framework only in the context of
Plan9 itself.  In reality it only applys directly/well to filesystem
related issues... the reason it works well in Plan9 is that _everything_
is a file (part of the beauty of plan9).  

With some elbow grease, 9P could probably be made to work in the kORBit
framework.  It's not even that big of a deal: it just takes time.  Believe
me when I say that IIOP is not a very good user->kernel communications
mechanism.  :)

-Chris

http://www.nondot.org/~sabre/os/
http://www.nondot.org/MagicStats/
http://korbit.sourceforge.net/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
