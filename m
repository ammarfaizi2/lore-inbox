Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275370AbRIZRnl>; Wed, 26 Sep 2001 13:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275366AbRIZRnb>; Wed, 26 Sep 2001 13:43:31 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:29408 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S275370AbRIZRnR>; Wed, 26 Sep 2001 13:43:17 -0400
Date: Wed, 26 Sep 2001 11:43:25 -0600
Message-Id: <200109261743.f8QHhPU08423@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        <bcrl@redhat.com>, <marcelo@conectiva.com.br>, <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <Pine.LNX.4.33.0109261003480.8327-200000@penguin.transmeta.com>
In-Reply-To: <E15mHjL-0000t8-00@the-village.bc.nu>
	<Pine.LNX.4.33.0109261003480.8327-200000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
>   This message is in MIME format.  The first part should be readable text,
>   while the remaining parts are likely unreadable without MIME-aware tools.
>   Send mail to mime@docserver.cac.washington.edu for more info.

Yuk! MIME! I thought you hated it too?

> 	PIII:
> 		nothing: 32 cycles
> 		locked add: 50 cycles
> 		cpuid: 170 cycles
> 
> 	P4:
> 		nothing: 80 cycles
> 		locked add: 184 cycles
> 		cpuid: 652 cycles
> 
>    Remember: these are for the already-exclusive-cache cases. ]
> 
> What are the athlon numbers?

Athalon 850 MHz:
nothing: 11 cycles
locked add: 12 cycles
cpuid: 64 cycles

BTW: your code had horrible control-M's on each line. So the compiler
choked (with a less-than-helpful error message). Of course, cat t.c
showed nothing amiss. Fortunately emacs doesn't hide information.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
