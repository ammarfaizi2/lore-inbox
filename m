Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131642AbRAHDBh>; Sun, 7 Jan 2001 22:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132758AbRAHDB2>; Sun, 7 Jan 2001 22:01:28 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:49045 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S131642AbRAHDBM>; Sun, 7 Jan 2001 22:01:12 -0500
Date: Sun, 7 Jan 2001 22:00:58 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: "Karl O. Pinc" <kop@meme.com>
cc: <linux-kernel@vger.kernel.org>, <C.Pollmeier@gmx.net>, <lpp@freelords.org>
Subject: Re: Bug: Frame-buffer (icon) rotates right in 2.4.0 when SMP
In-Reply-To: <200101080107.TAA01299@mofo.meme.com>
Message-ID: <Pine.LNX.4.30.0101072157330.17399-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when you use SMP there's suppOsed to be one icon that shows up for
every CPU you have. 2 cpu = 2 icons, 4 cpu = 4 icon. That's what the for
loop in fbcon_show_logo().

So this really isnt a bug, depending on how you look at it. It's
definitely something the lpp author needs to account for.

On Sun, 7 Jan 2001, Karl O. Pinc wrote:

> When displaying a screen-wide icon in the frame buffer for the
> graphics console:
>
> Linux version 2.4.0
>
> Console Drivers
>   Video mode selection support
>     Support for frame buffer devices (EXPERMENTAL)
>       VESA VGA graphics console
>
> I found the right edge of the image to be displayed on the left edge
> -- perhaps 8 pixels worth?
>
> I compiled for a pentium III, SMP on.  I've a dual processor Pentium
> III with a Matrox Graphics, Inc. MGA G400 AGP video card.  I
> discovered this using the lpp-0.2.0 patch at http://lpp.freelords.org,
> which displays a startup screen.
>
> Fix:  turning SMP off fixed the problem.
>
> FYI: fbcon_show_logo() in drivers/video/fbcon.c seems to have a for
> loop with an odd smp_num_cpus reference.
>

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
