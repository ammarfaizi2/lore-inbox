Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSELWru>; Sun, 12 May 2002 18:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315408AbSELWrt>; Sun, 12 May 2002 18:47:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:31956 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315337AbSELWrt>;
	Sun, 12 May 2002 18:47:49 -0400
Date: Sun, 12 May 2002 18:47:47 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Thunder from the hill <thunder@ngforever.de>
cc: Diego Calleja <DiegoCG@teleline.es>, Becki Minich <bminich@earthlink.net>,
        linux-kernel@vger.kernel.org, johnnyo@mindspring.com
Subject: Re: Reiserfs has killed my root FS!?!
In-Reply-To: <Pine.LNX.4.44.0205121613430.4369-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.GSO.4.21.0205121838230.27629-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 May 2002, Thunder from the hill wrote:

> Hi,
> 
> On Sun, 12 May 2002, Diego Calleja wrote:
> > > attempt to access beyond end of device
> > > 08:12: rw=0 want=268574776 limit=8747392
> > 
> > I'm not an expert, but this perhaps isn't a reiserfs problem.
> 
> Nope. It looks much more like the IDE problem Tomas Szepe addressed in 
> "2.5.15 IDE possibly trying to scribble beyond end of device"

... except that he's using 2.4

BTW, what had caused these reboots?  If it was memory corruption anywhere -
all bets are off and no journalling will save you.  Contrary to the
popular myth, journalling filesystems (or soft-updates, or mounting
everything full-sync) do _NOT_ protect against hardware problems and
kernel bugs.

