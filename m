Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267575AbSKQUJ2>; Sun, 17 Nov 2002 15:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267579AbSKQUJ2>; Sun, 17 Nov 2002 15:09:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55817 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267575AbSKQUJ0>; Sun, 17 Nov 2002 15:09:26 -0500
Date: Sun, 17 Nov 2002 12:16:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matthew Wilcox <willy@debian.org>
cc: Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>,
       <kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: [PATCH] change allow_write_access/deny_write_access prototype
In-Reply-To: <20021117194742.D7530@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0211171212360.1370-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Nov 2002, Matthew Wilcox wrote:
> 
> I'm quite happy to test that my header cleanups don't break things --
> but there are many things which don't currently compile anyway.  I try
> to enable the things I think my changes will break, but I didn't spot
> the isapnp one my pci_dev changes broke.  Could I ask that you update
> defconfig with your .config again so we can be sure things don't break
> _your_ build?

Breaking my build is ok, I can trivially fix those. Usually it's a 
one-liner, and that's not the thing I worry about.

I worry about the fact that I'm aboud to releaser 2.5.48, and then it
doesn't compile for some silly reason, even though I've obviously tested 
it on my configurations and fixed the problems _I_ saw.

Cleaning up header files is fine, but the trivial part is to remove the 
line that includes another header file. The _real_ work is trying to 
figure out that nothing else broke as a result, and I think that's what a 
janitor who does these things should really care about.

The whole "janitor" name to me implies somebody who does the hand and ugly 
and mostly boring thing that needs to be done to clean stuff up and make 
sure things work smoothly. A "janitorial" patch that leaves broken pieces 
in random places of the tree doesn't sound very janitorial to me, if you 
see what I mean..

			Linus

