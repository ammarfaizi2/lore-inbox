Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132096AbQKWC3M>; Wed, 22 Nov 2000 21:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131679AbQKWC2w>; Wed, 22 Nov 2000 21:28:52 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:54795 "EHLO saturn.cs.uml.edu")
        by vger.kernel.org with ESMTP id <S129994AbQKWC2s>;
        Wed, 22 Nov 2000 21:28:48 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011230158.eAN1wSr138515@saturn.cs.uml.edu>
Subject: Re: kernel-2.4.0-test11 crashed again; this time i send you the Oops-message
To: peter@cadcamlab.org (Peter Samuelson)
Date: Wed, 22 Nov 2000 20:58:28 -0500 (EST)
Cc: neilb@cse.unsw.edu.au (Neil Brown), oliver.poths@linsoft.de (Oliver Poths),
        tigran@veritas.com (Tigran Aivazian), linux-kernel@vger.kernel.org
In-Reply-To: <20001122190747.K2918@wire.cadcamlab.org> from "Peter Samuelson" at Nov 22, 2000 07:07:47 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson writes:
> [Neil Brown]

>> In drivers/md/Makefile, swap the order of "raid5.o xor.o" to be
>> "xor.o raid5.o", recompile, install, reboot.
>
> Don't forget the part about adding a comment saying that xor.c does in
> fact need to come before raid5.c.  This is the part that most likely
> will not happen, so that two months from now nobody will remember it
> and eventually it will trip us up again.
>
> That's one of the things that our infamous LINK_FIRST infrastructure
> would have done: pointed out special cases automatically so that even
> *without* a comment people would look at it and immediately know "there
> is *something* link-order-dependent here".  Oh well.

The infamous LINK_FIRST infrastructure was sort of half-way done.

It would be best to cause drivers with an unspecified link order
to move around a bit, so that errors may be discovered more quickly.

LINK_FIRST is pretty coarse. One would want a topological sort,
or at least LINK_0 through LINK_9 _without_ anything else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
