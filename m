Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266456AbRGHH0o>; Sun, 8 Jul 2001 03:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266750AbRGHH0e>; Sun, 8 Jul 2001 03:26:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:58105 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266456AbRGHH0Z>;
	Sun, 8 Jul 2001 03:26:25 -0400
Date: Sun, 8 Jul 2001 03:26:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Eugene Crosser <crosser@average.org>, linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
In-Reply-To: <20010707233108.B10109@pcep-jamie.cern.ch>
Message-ID: <Pine.GSO.4.21.0107080320280.28651-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Jul 2001, Jamie Lokier wrote:

> Daniel Phillips wrote:
> > > Reading a tarball is the distillation of what you describe into
> > > efficient form :)
> > 
> > /me downloads tar file definition
> > 
> > Um, gnu tar or posix tar? or some new, improved tar?
> 
> I suggest cpio, which is more compact and in some ways more standard.
> (tar has a silly pad-to-multiple-of-512-byte per file rule, which is
> inappropriate for this).  GNU cpio creates cpio format just fine.

GNU cpio is a race-ridden unmaintained pile of junk. Look at the size
of, say it, Debian patch to upstream source. Then try to read the
patched code.  Quite a few of us simply don't have that FPOS on their
boxen.

Using cpio archive layout is OK, but _please_, don't make it dependent
on GNU cpio.

