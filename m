Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281083AbRKDSbC>; Sun, 4 Nov 2001 13:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281069AbRKDSaw>; Sun, 4 Nov 2001 13:30:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:51420 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281082AbRKDSaj>;
	Sun, 4 Nov 2001 13:30:39 -0500
Date: Sun, 4 Nov 2001 13:30:38 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Tim Jansen <tim@tjansen.de>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Jakob =?iso-8859-1?q?=D8stergaard=20?= <jakob@unthought.net>,
        linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <160Rpw-0rLDCyC@fmrl05.sul.t-online.com>
Message-ID: <Pine.GSO.4.21.0111041321300.21449-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Nov 2001, Tim Jansen wrote:

> So if only some programs use the 'dot-files' and the other still use the 
> crappy text interface we still have the old problem for scripts, only with a 
> much larger effort.

Folks, could we please deep-six the "ASCII is tough" mentality?  Idea of
native-endian data is so broken that it's not even funny.  Exercise:
try to export such thing over the network.  Another one: try to use
that in a shell script.  One more: try to do it portably in Perl script.

It had been tried.  Many times.  It had backfired 100 times out 100.
We have the same idiocy to thank for fun trying to move a disk with UFS
volume from Solaris sparc to Solaris x86.  We have the same idiocy to
thank for a lot of ugliness in X.

At the very least, use canonical bytesex and field sizes.  Anything less
is just begging for trouble.  And in case of procfs or its equivalents,
_use_ the_ _damn_ _ASCII_ _representations_.  scanf(3) is there for
purpose.

