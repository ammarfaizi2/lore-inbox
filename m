Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUHANWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUHANWi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 09:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUHANWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 09:22:38 -0400
Received: from witte.sonytel.be ([80.88.33.193]:31937 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265943AbUHANWf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 09:22:35 -0400
Date: Sun, 1 Aug 2004 15:22:17 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: LKML <linux-kernel@vger.kernel.org>,
       Peter Maydell <pmaydell@chiark.greenend.org.uk>,
       Phil Blundell <philb@gnu.org>, Andrew Morton <akpm@osdl.org>,
       Kars de Jong <jongk@linux-m68k.org>
Subject: Re: [PATCH] Fix up return value from dio_find() (fixing a FIXME)
In-Reply-To: <Pine.LNX.4.60.0407312132490.2660@dragon.hygekrogen.localhost>
Message-ID: <Pine.GSO.4.58.0408011519180.25657@waterleaf.sonytel.be>
References: <Pine.LNX.4.60.0407312132490.2660@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Jul 2004, Jesper Juhl wrote:
> Here's a patch to fix up this FIXME in drivers/dio/dio.c:dio_find() :
>
> * Aargh: we use 0 for an error return code, but select code 0 exists!
> * FIXME (trivial, use -1, but requires changes to all the drivers :-< )
> */
>
> I've changed the return value to -1 as suggested by the comment, and then
> went looking for the drivers that needed to be changed (as the comment
> mentions). I only found two users of dio_find() and I've fixed those up to
> not treat 0 as an error, but only values <0.
> The FIXME implies (to me at least) that there are many drivers that would
> need to be changed, but I could only find two - did I miss anything?
> Also, I don't have the hardware to test the drivers I've changed, so I've
> done compile testing only - could someone please review my changes and
> confirm if they are correct?

I guess most of these are already covered by Kars' patch at the URL below?

    http://linux-m68k-cvs.ubb.ca/~geert/linux-m68k-2.6.x-merging/474-dio.diff

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
