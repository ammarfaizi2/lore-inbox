Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267309AbTAPWxo>; Thu, 16 Jan 2003 17:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267313AbTAPWxo>; Thu, 16 Jan 2003 17:53:44 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:13140 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S267309AbTAPWxo>; Thu, 16 Jan 2003 17:53:44 -0500
Date: Fri, 17 Jan 2003 10:00:42 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Robert Wruck <robert@rw-it.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Timer bug fix ported to 2.4.20
In-Reply-To: <20030116185653.GB5780@router.local.rw-it.net>
Message-ID: <Pine.LNX.4.05.10301170945150.2751-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2003, Robert Wruck wrote:

> I recently upgraded from 2.2.19 to 2.4.20 and noted that the via timer
> bugfix has disappeared.
> 
> I'm not sure if this is a VIA problem, because it happens on my PIII
> i440BX-based board, Gigabyte GA-6BXE, which does not seem to have any
> chips made by VIA. (82443BX, 32371EB PIIX4, ITE 8671 SuperIO)

Different people have reported this check triggered on various hardware
which doesn't have VIA686-anything.  In my case on both an old AcerNote
and a Toshiba-1800.

> However, whenever i start X, the system clock slows down significantly
> (it takes about 10 real seconds for 1 system second to elapse).

Ouch! Interesting to see that your system triggers the "VIA bug really
present.", whereas mine doesn't and I haven't found any gross time-keeping
problems.  Also, while we both report "read" and "re-read" values over a
narrow range they are quite different ranges.

I wonder if we are seeing different bugs which exhibit similar symptoms?

> The only patch I could find for this was the one by Neale Banks:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.1/0005.html

OK, just to set the record straight, my involvement has been merely to
port Vojtech's patch (for the original see:
http://marc.theaimsgroup.com/?l=linux-kernel&m=100560251020988&w=2 ), add
the ''disable with "timer=no-via686a"'' bit (which people more
knowledgeable than I say is quite unnecessary) and to report some
"interesting" results (see:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102621884412934&w=2 ).

> I ported this to 2.4.20 and it works (at least for me..)
> It can still be disabled with "timer=no-via686a" (from the original patch)
> 
> Any comments? (I'm not subscribed to linux-kernel)

HTH,
Neale.

