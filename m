Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293175AbSCRWjA>; Mon, 18 Mar 2002 17:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293164AbSCRWiv>; Mon, 18 Mar 2002 17:38:51 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:42759 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293181AbSCRWih>; Mon, 18 Mar 2002 17:38:37 -0500
Date: Mon, 18 Mar 2002 23:38:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Jonathan Barker <jbarker@ebi.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: VFS mediator?
Message-ID: <20020318223827.GD1740@atrey.karlin.mff.cuni.cz>
In-Reply-To: <E16lej0-0002FE-00@the-village.bc.nu> <Pine.GSO.4.21.0203141825070.329-100000@weyl.math.psu.edu> <20020318192502.GD194@elf.ucw.cz> <shs1yeha5b4.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>     >> * NFS (v2,v3): Portable.  And that's the only good thing to say
>     >> about it - it's stateless, it has messy semantics all over the
>     >> place and implementing userland server requires a lot of glue.
> 
>      > Does not work... If you mount nfs server on localhost, you can
>      > deadlock.
> 
> Huh? Examples please? A hell of a lot of work has gone into ensuring
> that this cannot happen. I do most of my NFS client work on this sort
> of setup, so it had bloody well better work...

Okay, take userland nfs-server. (This thread was about userland
filesystems).

Then, make memory full of dirty pages. Imagine that nfs-server is
swapped-out by some bad luck. What you have is extremely nasty
deadlock, AFAICS. [To free memory you have to write out dirty data,
but you can't do that because you don't have enough memory for
nfs-server].
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
