Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316952AbSEaVWJ>; Fri, 31 May 2002 17:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316954AbSEaVWI>; Fri, 31 May 2002 17:22:08 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:33652 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316952AbSEaVWH>; Fri, 31 May 2002 17:22:07 -0400
Date: Fri, 31 May 2002 23:21:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: jlnance@intrex.net, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4 VM sucks. Again
Message-ID: <20020531212133.GA1172@dualathlon.random>
In-Reply-To: <200205231311.g4NDBO613726@mail.pronto.tv> <20020523141243.A1178@tricia.dyndns.org> <200205241036.g4OAaXR28572@mail.pronto.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 12:36:32PM +0200, Roy Sigurd Karlsbakk wrote:
> On Thursday 23 May 2002 20:12, jlnance@intrex.net wrote:
> > On Thu, May 23, 2002 at 03:11:24PM +0200, Roy Sigurd Karlsbakk wrote:
> > > Starting up 30 downloads from a custom HTTP server (or Tux - or Apache -
> > > doesn't matter), file size is 3-6GB, download speed = ~4.5Mbps. After
> > > some time the kernel (a) goes bOOM (out of memory) if not having any
> > > swap, or (b) goes gong swapping out anything it can.
> >
> > Does this work if the client and the server are on the same machine?  It
> > would make reproducing this a lot easier if it only required 1 machine.
> 
> I guess it'd work fine with only one machine, as IMO, the problem must be the 
> kernel not releasing buffers

too much variable.

Also keep in mind if you grow the socket buffer to hundred mbyte on an
highmem machine the zone-normal will finish too fast and you may run out
of memory. 2.4.19pre9aa2 in such case should at least return -ENOMEM and
not deadlock.

Andrea
