Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129421AbRBKUJA>; Sun, 11 Feb 2001 15:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129486AbRBKUIu>; Sun, 11 Feb 2001 15:08:50 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:36810 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S129231AbRBKUIp>;
	Sun, 11 Feb 2001 15:08:45 -0500
Date: Sun, 11 Feb 2001 21:08:26 +0100
From: David Weinehall <tao@acc.umu.se>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Nick Urbanik <nicku@vtc.edu.hk>,
        Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-pre3 compile error in 6pack.c
Message-ID: <20010211210826.D20267@khan.acc.umu.se>
In-Reply-To: <E14S04y-0004Tb-00@the-village.bc.nu> <3A86EF11.20C17FD8@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3A86EF11.20C17FD8@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, Feb 11, 2001 at 02:59:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2001 at 02:59:13PM -0500, Jeff Garzik wrote:
> Alan Cox wrote:
> > 
> > > 2.4.2-pre3 doesn't compile with 6pack as a module; I had to disable it;
> > > now it compiles (and so far, works fine).
> > 
> > It has a slight dependancy on -ac right now.
> > 
> > KMALLOC_MAXSIZE is the alloc size limit - 131072. It checks this as kmalloc
> > now panics if called with an oversize request
> 
> Would it be costly/reasonable to have kmalloc -not- panic if given a
> too-large size?  Principle of Least Surprises says it should return NULL
> at the very least.

It's on purpose; to find the erroneous drivers.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
