Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129799AbQLPXMw>; Sat, 16 Dec 2000 18:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129997AbQLPXMn>; Sat, 16 Dec 2000 18:12:43 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:7694 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129799AbQLPXMZ>; Sat, 16 Dec 2000 18:12:25 -0500
Date: Sat, 16 Dec 2000 16:41:51 -0600
To: Dana Lacoste <dana.lacoste@peregrine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linus's include file strategy redux
Message-ID: <20001216164151.J3199@cadcamlab.org>
In-Reply-To: <NBBBJGOOMDFADJDGDCPHIENJCJAA.law@sgi.com> <91bnoc$vij$2@enterprise.cistron.net> <20001215155741.B4830@ping.be> <01cf01c066ab$036fc030$890216ac@ottawa.loran.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01cf01c066ab$036fc030$890216ac@ottawa.loran.com>; from dana.lacoste@peregrine.com on Fri, Dec 15, 2000 at 10:23:44AM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Dana Lacoste]
> Essentially, whatever solution is implemented MUST ensure :
> 
> 1 - glibc will work properly (the headers in /usr/include/* don't
>     change in an incompatible manner)
> 
> 2 - programs that need to compile against the current kernel MUST
>     be able to do so in a quasi-predictable manner.

(2) is bogus.  NO program needs to compile against the current kernel
headers.  The only things that need to compile against the current
kernel headers are kernel modules and perhaps libc itself.  As I put it
a few days ago--

  http://marc.theaimsgroup.com/?l=linux-kernel&m=97658613604208&w=2

So for your external modules, let me suggest the lovely
/lib/modules/{version}/build/include/.  Recent-ish modutils required.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
