Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129271AbRBVWiQ>; Thu, 22 Feb 2001 17:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129555AbRBVWh4>; Thu, 22 Feb 2001 17:37:56 -0500
Received: from pasky.ji.cz ([62.44.12.54]:65276 "EHLO pasky.ji.cz")
	by vger.kernel.org with ESMTP id <S129271AbRBVWhy>;
	Thu, 22 Feb 2001 17:37:54 -0500
Date: Thu, 22 Feb 2001 23:37:47 +0100
From: Petr Baudis <pasky@pasky.ji.cz>
To: Lazarus Long <lazarus@workspot.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (BUG) 3c509b and kernel 2.4.x
Message-ID: <20010222233747.B4757@pasky.ji.cz>
Mail-Followup-To: Lazarus Long <lazarus@workspot.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E14VJAd-00007S-00@web1.workspot.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14VJAd-00007S-00@web1.workspot.net>; from lazarus@workspot.net on Tue, Feb 20, 2001 at 12:13:59PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > [1.] Upon boot, the 2.4.1 kernel misconfigures one of two 3c509b NICs
>  > installed in my computer as "BNC" rather than "10baseT".
> 
>  > Boot messages for eth0 in kernel 2.2:
>  > eth0: 3c509 at 0x300 tag 1, 10baseT port, address 00 a0 24 e9 8d a1, IRQ 10.
>  > and in 2.4:
>  > eth0: 3c509 at 0x300, BNC port, address 00 a0 24 e9 8d a1, IRQ 10.
>  >
>  > i don't know why it says BNC port.. but it isn't right, it should be 10baseT
> 
>  > I have three 3com cards( 1 3c590 Vortex, 1 3c900 Cyclone, 1 3c509B) which
>  > have no trouble with 2.2 kernels. But when I am trying to play with 2.4.0
>  > kernel, the 3c509 just can not load.
> 
I'm getting exactly this problems too. If 3c509 is on eth1 (and maybe just eth > 0),
it gets misconfigured port - i have two 3c509 and only second one doesn't work - but
when i force kernel to assign it 10baseT port, it of course works fine. I wanted to
examine this bug more closely, but unfortunately i have too little time now. But
anyway it looks there is bug in some region manipulation...

-- 

				Peter "Pasky" Baudis

Whoever coded that patch should be taken out and shot, hung, drawn and
quartered then forced to write COBOL for the rest of their natural
life.
-- Keith Owens <kaos@ocs.com.au> in linux-kernel

My public PGP key is on: http://pasky.ji.cz/~pasky/pubkey.txt
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS d- s++:++ a--- C+++ UL++++$ P+ L+++ E--- W+ N !o K- w-- !O M-
!V PS+ !PE Y+ PGP+>++ t+ 5 X(+) R++ tv- b+ DI(+) D+ G e-> h! r% y?
------END GEEK CODE BLOCK------
