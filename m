Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262185AbRETTjI>; Sun, 20 May 2001 15:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262183AbRETTi6>; Sun, 20 May 2001 15:38:58 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:4366 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262178AbRETTin>; Sun, 20 May 2001 15:38:43 -0400
Date: Sun, 20 May 2001 12:38:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
In-Reply-To: <Pine.GSO.4.21.0105201530580.8940-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0105201235000.7759-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Davem, check the last thing, please.

On Sun, 20 May 2001, Alexander Viro wrote:
> 
> On Sun, 20 May 2001, Linus Torvalds wrote:
> 
> > > How about moratorium on new ioctls in the meanwhile? Whatever we do in
> > > fs/ioctl.c, it _will_ take time.
> > 
> > Ehh.. Telling people "don't do that" simply doesn't work. Not if they can
> > do it easily anyway. Things really don't get fixed unless people have a
> > certain pain-level to induce it to get fixed.
> 
> Umm... How about the following:  you hit delete on patches that introduce
> new ioctls, I help to provide required level of pain.  Deal?

It still doesn't work.

That only makes people complain about my fascist tendencies. See the
thread about device numbers, where Alan just says "ok, I'll do it without
Linus then". 

The whole point of open source is that I don't have that kind of power. I
can only guide, but the most powerful guide is by guiding the _design_,
not micro-managing.

> BTW, -pre4 got new bunch of ioctls. On procfs, no less.

I know. David has zero taste. 

Davem, why didn't you just make new entries in /proc/bus/pci and let
people do "mmap(/proc/bus/pci/xxxx/mem)" instead of having idiotic ioctl's
to set "this is a IO handle" and "this is a MEM handle"? This particular
braindamage is not too late to fix..

		Linus

