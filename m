Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311259AbSCQCFJ>; Sat, 16 Mar 2002 21:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311255AbSCQCEz>; Sat, 16 Mar 2002 21:04:55 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:29130 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S311257AbSCQCEm>; Sat, 16 Mar 2002 21:04:42 -0500
Date: Sun, 17 Mar 2002 02:01:45 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Cc: Andreas Dilger <adilger@clusterfs.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Cleanup port 0x80 use (was: Re: IO delay ...)
Message-ID: <20020317020145.A20307@kushida.apsleyroad.org>
In-Reply-To: <20020315185722.GA920@turbolinux.com> <Pine.LNX.4.33.0203152102430.9609-100000@biker.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0203152102430.9609-100000@biker.pdb.fsc.net>; from Martin.Wilck@fujitsu-siemens.com on Fri, Mar 15, 2002 at 09:17:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wilck wrote:
> > > +#define __SLOW_DOWN_IO_PORT 0x80
> > > +#define __SLOW_DOWN_IO "\noutb %%al,$0x80"
> >
> > You may want to change the above to:
> > #define __SLOW_DOWN_IO_ASM	"\noutb %%al,$__SLOW_DOWN_IO_PORT"
> 
> Won't work, cpp doesn't substitute between double quotes.
> (at least the one I'm using). Or am I gettimng something wrong here??

As long as __SLOW_DOWN_IO_PORT is a simple constant, you can just use
this instead:

    #define __SLOW_DOWN_IO_ASM	"\noutb %%al,$" #__SLOW_DOWN_IO_PORT

-- Jamie
