Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSEPM4t>; Thu, 16 May 2002 08:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSEPM4s>; Thu, 16 May 2002 08:56:48 -0400
Received: from [195.223.140.120] ([195.223.140.120]:32295 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312560AbSEPM4r>; Thu, 16 May 2002 08:56:47 -0400
Date: Thu, 16 May 2002 14:56:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa3
Message-ID: <20020516125641.GI1025@dualathlon.random>
In-Reply-To: <20020516020134.GC1025@dualathlon.random> <Pine.LNX.4.44L.0205152303500.32261-100000@imladris.surriel.com> <20020516023238.GE1025@dualathlon.random> <20020516093630.B5540@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2002 at 09:36:30AM +0100, Russell King wrote:
> On Thu, May 16, 2002 at 04:32:38AM +0200, Andrea Arcangeli wrote:
> > On Wed, May 15, 2002 at 11:06:51PM -0300, Rik van Riel wrote:
> > > --- snip from linuxrc ----
> > > mount --ro -t $rootfs $rootdev /sysroot
> > > pivot_root /sysroot /sysroot/initrd
> > > ------
> > > 
> > > This way you can specify both the root fs and - if wanted -
> > > special mount options to the root fs. Then you pivot_root(2)
> > > to move the root fs to / and the (old) initrd to /initrd.
> > 
> > both lines are completly superflous, very misleading as well. I
> > recommend to drop such two lines from all the full blown bug-aware
> > linuxrc out there (of course after you apply the ordering fix to the
> > kernel).
> 
> Have you thought about reading Documentation/initrd.txt and following
> the described method?  (last modified December 2000 according to the
> comments and the mtime on the file).

I didn't noticed the API changed in the docs, so my suggestion of
yesterday to remove such two lines is wrong sorry. I was only reading
the kernel code and I was using my own old debugging initrd were I could
reproduce the ext3 problem. Interestingly there's no way to guess the
new API by only reading the kernel code like I was doing.

Andrea
