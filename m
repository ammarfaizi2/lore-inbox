Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267204AbRGPFzw>; Mon, 16 Jul 2001 01:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267209AbRGPFzl>; Mon, 16 Jul 2001 01:55:41 -0400
Received: from sunny-legacy.pacific.net.au ([210.23.129.40]:7622 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S267204AbRGPFzg>; Mon, 16 Jul 2001 01:55:36 -0400
Message-Id: <200107160555.f6G5tMtK019295@typhaon.pacific.net.au>
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: Alexander Viro <viro@math.psu.edu>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Adam <adam@eax.com>,
        Alex Buell <alex.buell@tahallah.demon.co.uk>,
        Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Duplicate '..' in /lib 
In-Reply-To: Message from Alexander Viro <viro@math.psu.edu> 
   of "Mon, 16 Jul 2001 01:38:40 EDT." <Pine.GSO.4.21.0107160128320.26491-100000@weyl.math.psu.edu> 
In-Reply-To: <Pine.GSO.4.21.0107160128320.26491-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 16 Jul 2001 15:55:22 +1000
From: David Luyer <david_luyer@pacific.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, 16 Jul 2001, Albert D. Cahalan wrote:
> 
> > Adam writes:
> > 
> > >> /lib
> > >>    4 drwxr-xr-x   19 root     root         4096 Jun  9 16:06 ..
> > >>    4 -rw-rw-r--    1 root     root           27 Jun  9 15:55 ..
> > >>
> > >> How can I get rid of this? I'm on kernel 2.2.19, running on sparc-linux.
> > >
> > > first it is not a pair directories, but a directory and a file.
> > > 
> > > second, are you sure both of the mare just ".." for example
> > 
> > I don't think so! Look at the "4" on the left. If that is the
> > inode number from "ls -lia /lib", his disk is seriously messed up.
> > The inode number for "/lib/.." should be 2, and an inode may not
> > be shared between a file and a directory.
> 
> Erm... It _can't_ be an inode number. Something is very fishy there.

I'd say that's a 'ls -las'; both the small file and the directory above take
up a 4k block.

The second is, say, ".. " and the first is just "..".

Nothing interesting at all.

David.
-- 
David Luyer                                        Phone:   +61 3 9674 7525
Engineering Projects Manager   P A C I F I C       Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T      Mobile:  +61 4 1111 2983
http://www.pacific.net.au/                         NASDAQ:  PCNTF


