Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289149AbSAJD4D>; Wed, 9 Jan 2002 22:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289146AbSAJDzy>; Wed, 9 Jan 2002 22:55:54 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:36031 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S289149AbSAJDzk>;
	Wed, 9 Jan 2002 22:55:40 -0500
Date: Thu, 10 Jan 2002 04:55:38 +0100
From: David Weinehall <tao@acc.umu.se>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Announcement] linux-2.0.40-rc1
Message-ID: <20020110045538.Z5235@khan.acc.umu.se>
In-Reply-To: <20020109003424.S5235@khan.acc.umu.se> <3C3CEE53.3B35CCE3@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C3CEE53.3B35CCE3@pp.inet.fi>; from jari.ruusu@pp.inet.fi on Thu, Jan 10, 2002 at 03:28:51AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 03:28:51AM +0200, Jari Ruusu wrote:
> David Weinehall wrote:
> > Hence I'm declaring this the first release candidate for 2.0.40.
> > Try it out, please.
> > 
> > 2.0.40-rc1
> [snip]
> > o       Change array-size from 0 to 1 for       (me)
> >         two arrays in the symbol-table
> >         in include/linux/module.h
> 
> Please revert above change. It makes struct symbol_table.symbol[] one
> entry long, and effectively _kills_ module support.

Well, I don't really like the magic used in module.h one bit, but I'll
revert this for now.

Anyone who could comment on whether usage of [] instead of [0] would
be better? [0] seems to have been deprecated in later versions of gcc,
so there _has_ to be some legal way of expressing what the kernel wants
to do here.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
