Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130541AbQLRJuV>; Mon, 18 Dec 2000 04:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130835AbQLRJuC>; Mon, 18 Dec 2000 04:50:02 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:27657 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130541AbQLRJtt>; Mon, 18 Dec 2000 04:49:49 -0500
Date: Mon, 18 Dec 2000 03:19:13 -0600
From: Peter Samuelson <peter@cadcamlab.org>
To: J Sloan <jjs@pobox.com>
Cc: Niels Kristian Bech Jensen <nkbj@image.dk>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: test13-pre3 woes
Message-ID: <20001218031912.E3199@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.30.0012180702380.16423-100000@hafnium.nkbj.dk> <3A3DD010.225F721C@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A3DD010.225F721C@pobox.com>; from jjs@pobox.com on Mon, Dec 18, 2000 at 12:51:29AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[J Sloan]
> The module now compiles and gets installed -
> Unfortunately, attempting to load it does not go well:
> 
> kernel/drivers/char/drm/tdfx.o: unresolved symbol remap_page_range
> kernel/drivers/char/drm/tdfx.o: unresolved symbol __wake_up
> kernel/drivers/char/drm/tdfx.o: unresolved symbol mtrr_add
> kernel/drivers/char/drm/tdfx.o: unresolved symbol __generic_copy_from_user
> kernel/drivers/char/drm/tdfx.o: unresolved symbol schedule
> kernel/drivers/char/drm/tdfx.o: unresolved symbol kmalloc
> kernel/drivers/char/drm/tdfx.o: unresolved symbol si_meminfo

Those symbols are rather generic and rather important.  Sounds like a
generic module problem.  Do other modules load?  Does your kernel use
MODVERSIONS?  (This module apparently doesn't.)  Are you using a recent
version of modutils?

Puzzled.  Maybe Keith Owens knows something.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
