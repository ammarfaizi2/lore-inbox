Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLOE4s>; Thu, 14 Dec 2000 23:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLOE4h>; Thu, 14 Dec 2000 23:56:37 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:21252 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S129257AbQLOE4Y>; Thu, 14 Dec 2000 23:56:24 -0500
Date: Thu, 14 Dec 2000 20:24:11 -0800 (PST)
From: ferret@phonewave.net
To: Alexander Viro <viro@math.psu.edu>
cc: David Riley <oscar@the-rileys.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Miquel van Smoorenburg <miquels@traveler.cistron-office.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Linus's include file strategy redux
In-Reply-To: <Pine.GSO.4.21.0012141958410.10441-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.3.96.1001214201955.12438B-100000@tarot.mentasm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2000, Alexander Viro wrote:

> 
> 
> On Thu, 14 Dec 2000, David Riley wrote:
> 
> > Alexander Viro wrote:
> > > 
> > >         Actually, I suspect that quite a few of us had done that since long -
> > > IIRC I've got burned on 1.2/1.3 and decided that I had enough. Bugger if I
> > > remember what exactly it was - ISTR that it was restore(8) built with
> > > 1.3.<something> headers and playing funny games on 1.2, but it might be
> > > something else...
> > 
> > So then what's the correct header tree to put in /usr/include/linux?  I
> > could use the stock 2.2.14-patched headers that came with the dist, but
> > how often does it need to be updated?  Or should I use the latest 2.2?
> 
> Whatever your libc was built against. It shouldn't matter that much,
> but when shit hits the fan... you really don't want to be there.
> 
> Look at it that way: you don't want to build some object files with one
> set of headers, some - with another and link them together. Now,
> s/some object files/libc/. With a minimal luck you will be OK, but
> it's easier not to ask for trouble in the first place.

Yep. At one point, about six months ago, I recompiled glibc 2.0.7(?)
against 2.2.15(?) with USB backport due to occational USB v4l
device-related bus locks, recompiled the v4l app I was using (w3cam
package I think) and the problems mostly went away. As far as I understand
it's a matter of a kernel/userland seperation. But again, sometimes you
just have to update your libc.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
