Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129529AbQKWBiR>; Wed, 22 Nov 2000 20:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132306AbQKWBiH>; Wed, 22 Nov 2000 20:38:07 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:20231 "EHLO
        wire.cadcamlab.org") by vger.kernel.org with ESMTP
        id <S129529AbQKWBh7>; Wed, 22 Nov 2000 20:37:59 -0500
Date: Wed, 22 Nov 2000 19:07:47 -0600
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Oliver Poths <oliver.poths@linsoft.de>,
        Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel-2.4.0-test11 crashed again; this time i send you the Oops-message
Message-ID: <20001122190747.K2918@wire.cadcamlab.org>
In-Reply-To: <Pine.LNX.4.21.0011202121000.1664-100000@penguin.homenet> <20001120.22074300@rock> <14873.43836.407559.976245@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14873.43836.407559.976245@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Tue, Nov 21, 2000 at 09:52:44AM +1100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Neil Brown]
> In drivers/md/Makefile, swap the order of "raid5.o xor.o" to be
> "xor.o raid5.o", recompile, install, reboot.

Don't forget the part about adding a comment saying that xor.c does in
fact need to come before raid5.c.  This is the part that most likely
will not happen, so that two months from now nobody will remember it
and eventually it will trip us up again.

That's one of the things that our infamous LINK_FIRST infrastructure
would have done: pointed out special cases automatically so that even
*without* a comment people would look at it and immediately know "there
is *something* link-order-dependent here".  Oh well.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
