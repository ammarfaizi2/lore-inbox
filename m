Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129431AbQK0Tir>; Mon, 27 Nov 2000 14:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129547AbQK0Tih>; Mon, 27 Nov 2000 14:38:37 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:19718 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129455AbQK0Tic>; Mon, 27 Nov 2000 14:38:32 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: KERNEL BUG: console not working in linux
Date: 27 Nov 2000 11:08:10 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8vubeq$r5r$1@cesium.transmeta.com>
In-Reply-To: <E140Pc3-0003AI-00@the-village.bc.nu> <200011271849.eARInfc255418@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200011271849.eARInfc255418@saturn.cs.uml.edu>
By author:    "Albert D. Cahalan" <acahalan@cs.uml.edu>
In newsgroup: linux.dev.kernel
>
> >> 1) Why did they disable my videocard ?
> >
> > Because your machine is not properly PC compatible
> 
> The same can be said of systems that don't support the
> standard keyboard controller for A20 control.
> 

Yes, it can.  Unfortunately, some "legacy-free" PCs apparently are
starting to take the tack that the KBC is legacy.  Therefore, the use
of port 92h is mandatory on those systems.

Port 92h dates back to at the very least the IBM PS/2.

Either way, the video card of the original poster is broken in more
ways than that.  Ports 0x00-0xFF are reserved for the motherboard
chipset and have been since the original IBM PC.

It would have been somewhat different if there had been a standard
BIOS function for enabling A20, but there isn't one.

Sometimes, in the PC world, you just have to draw a line and say "this
is too broken to use".  I think the original posters' video card falls
in that category.  Get a new video card, they're cheap these days.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
