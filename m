Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSEEANB>; Sat, 4 May 2002 20:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315705AbSEEANA>; Sat, 4 May 2002 20:13:00 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:11837 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315260AbSEEAM7>; Sat, 4 May 2002 20:12:59 -0400
Date: Sun, 5 May 2002 02:14:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Francois Romieu <romieu@cogenit.fr>
Cc: linux-kernel@vger.kernel.org, Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: 2.4.19pre8aa2
Message-ID: <20020505021400.I1260@dualathlon.random>
In-Reply-To: <20020504165440.C1260@dualathlon.random> <20020504205653.A27564@fafner.intra.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2002 at 08:56:53PM +0200, Francois Romieu wrote:
> Andrea Arcangeli <andrea@suse.de> :
> [...]
> > Only in 2.4.19pre8aa2: 00_comx-driver-compile-1
> > 
> > 	Export proc_get_inode for kernel/drivers/net/wan/comx.o so
> > 	it can link as a module, noticed by Eyal Lebedinsky.
> 
> http://www.cs.Helsinki.FI/linux/linux-kernel/2001-24/0984.html may be of
> interest.

I also mentioned it would been cleaner if the driver design would be
changed not to use procfs that way. I will back it out as soon as the
driver will stop using it, it's not a change in a monolithic kernel
where it could be forgotten like an -ac or a mainline, it's in a
separate patch called 00_comx-driver-compile-1 so there's no risk to
forget about it.  It cannot hurt anybody to export it until the driver
design is changed to be cleaner, just don't use it in the meantime, if
you use it again in another driver that's your mistake not mine. It is
not a pratical problem (the pratical problem infact happens without the
00_comx-driver-compile-1 patch), it is only a documentation problem and
I think the name of the patch should be clear enough in that sense.

Andrea
