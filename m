Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbUDFLsW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 07:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263853AbUDFLsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 07:48:22 -0400
Received: from witte.sonytel.be ([80.88.33.193]:24974 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263834AbUDFLqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 07:46:49 -0400
Date: Tue, 6 Apr 2004 13:46:41 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andi Kleen <ak@muc.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: {put,get}_user() side effects
In-Reply-To: <m3fzbhfijh.fsf@averell.firstfloor.org>
Message-ID: <Pine.GSO.4.58.0404061344390.4158@waterleaf.sonytel.be>
References: <1HVGV-1Wl-21@gated-at.bofh.it> <m3fzbhfijh.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2004, Andi Kleen wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On most (all?) architectures {get,put}_user() has side effects:
> >
> > #define put_user(x,ptr)                                                 \
> >   __put_user_check((__typeof__(*(ptr)))(x),(ptr),sizeof(*(ptr)))
>
> Neither typeof not sizeof are supposed to have side effects. If your
> compiler generates them that's a compiler bug.

>From a simple compile test, you seem to be right... Weird, since it does expand
to 3 times 'pIndex++', but pIndex is incremented only once.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
