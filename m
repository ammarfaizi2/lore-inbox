Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRALCJJ>; Thu, 11 Jan 2001 21:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132400AbRALCI6>; Thu, 11 Jan 2001 21:08:58 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:25611 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129742AbRALCIr>; Thu, 11 Jan 2001 21:08:47 -0500
Date: Thu, 11 Jan 2001 18:08:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
In-Reply-To: <20010111184645.B828@athlon.random>
Message-ID: <Pine.LNX.4.10.10101111803580.18517-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could people with Athlons please verify that pre3 works for them?

It's basically Andrea's patch, but I moved the FPU save/restore games away
from arch/i386/lib/mmx.c, so that everything is properly done in one place
and others call the appropriate helper functions instead of thinking that
they know how the lazy FP switching is done.

It also makes the fxsr disable act the same way the TSC disable does.

(And yes, I forgot to update the Makefile release number - sue me, I'm
too lazy to upload a new patch with that fixed ;).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
