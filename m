Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284613AbRLZRgk>; Wed, 26 Dec 2001 12:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284615AbRLZRgV>; Wed, 26 Dec 2001 12:36:21 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:28084 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S284613AbRLZRgL>;
	Wed, 26 Dec 2001 12:36:11 -0500
Date: Wed, 26 Dec 2001 12:36:09 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Legacy Fishtank <garzik@havoc.gtf.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre2 forces ramfs on
In-Reply-To: <20011226122044.A7125@havoc.gtf.org>
Message-ID: <Pine.GSO.4.21.0112261228180.2716-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Dec 2001, Legacy Fishtank wrote:

> On Wed, Dec 26, 2001 at 03:04:40PM +0000, Alan Cox wrote:
> > > Because it's small, and if it wasn't there, we'd have to have the small
> > > "rootfs" anyway (which basically duplicated ramfs functionality).
> > 
> > Can ramfs=N longer term actually come back to be "use __init for the RAM
> > fs functions". That would seem to address any space issues even the most 
> > embedded fanatic has. 
> 
> Nifty idea... We could use __rootfs or similar in the module.

Um, folks - rootfs does _not_ go away after you mount final root over it.
Having absolute root always there makes life much simpler in a lot of
places...

What's more, quite a few ramfs methods are good candidates for library
functions, since they are already shared with other filesystems and
number of such cases is going to grow.

