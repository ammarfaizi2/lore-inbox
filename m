Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRBYQFD>; Sun, 25 Feb 2001 11:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129403AbRBYQEy>; Sun, 25 Feb 2001 11:04:54 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:32494 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129401AbRBYQEs>;
	Sun, 25 Feb 2001 11:04:48 -0500
Date: Sun, 25 Feb 2001 11:04:46 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] per-process namespaces for Linux
In-Reply-To: <3A98E20F.3F8D023D@colorfullife.com>
Message-ID: <Pine.GSO.4.21.0102251048280.25245-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Feb 2001, Manfred Spraul wrote:

> 
> >  * large cleanup of boot process (ramdisk handling, etc.)
> 
> Have you thought about supporting .tar.gz into ramfs? Creating custom
> boot images would be simpler.

*uh*. It's definitely easier to do than it used to be, but I'm seriously
sceptical about adding more cruft into the thing. Let's sort it out
and then see what can be added to the sequences. At least now it's in
one place and doesn't have to pull the tricks it used to need for dealing
with IO...

(I presume that you mean "unpacking tar.gz into initrd/floppy-loaded ramdisk"
and not "adding into ramfs a loader of tarballs" - the latter is out of
question, as far as I'm concerned; such code belongs to do_mounts.c if
it belongs anywhere at all)

IOW, look into init/do_mounts.c - that's the right place to do that
stuff.
							Cheers,
								Al

