Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278649AbRKAK0q>; Thu, 1 Nov 2001 05:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278652AbRKAK0g>; Thu, 1 Nov 2001 05:26:36 -0500
Received: from ce06d.unt0.torres.ka0.zugschlus.de ([212.126.206.6]:11274 "EHLO
	torres.ka0.zugschlus.de") by vger.kernel.org with ESMTP
	id <S278649AbRKAK03>; Thu, 1 Nov 2001 05:26:29 -0500
Date: Thu, 1 Nov 2001 11:26:28 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: xircom_cb and promiscious mode
Message-ID: <20011101112628.A30743@torres.ka0.zugschlus.de>
In-Reply-To: <Pine.LNX.4.33.0110181958290.10380-100000@prague.clic.cs.columbia.edu> <3BCF6F2E.DF35CC26@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BCF6F2E.DF35CC26@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Oct 18, 2001 at 08:09:18PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 08:09:18PM -0400, Jeff Garzik wrote:
> Shaya Potter wrote:
> > other thing is, xircom_tulip_cb used to work on my system (2.4.10) (xircom
> > realport card, rebranded for IBM), but with 2.4.12-ac3, it can't seem to
> > drive the card.  it loads fine, detects the card, but no blinky lights.
> 
> It's critical that you get xircom_tulip_cb.c from 2.4.13-pre3. 
> 2.4.12-ac3 does not the long-needing-to-be-applied fixes that are now in
> 2.4.13-pre3's copy of the driver.
> 
> Ion (ionut@cs.columbia.edu) did the changes, so he is pretty close to
> you if you need debugging, too <g>

I am quite interested in the problems that arise with the xircom
cardbus ethernet cards, since I have difficulties with them as well.
However, my problems are not solved by setting promisc mode.

When I try to transmit larger amounts of data (such as scp'ing a 30 MB
file over from a different machine on the LAN), network transfer
stalls. I can abort the user space program, but the network link is
gone. This can be reproduced with:

- kernel 2.4.13, using pcmcia-cs drivers 3.1.25
- kernel 2.4.13, using pcmcia-cs drivers 3.1.29
- kernel 2.4.13, using kernel driver xircom_tulip_cb
- kernel 2.4.13-ac5, using kernel driver xircom_tulip_cb
- kernel 2.4.13-ac5, using kernel driver xircom_cb

I am using Debian/GNU Linux unstable/sid.

I tried this with two different RealPort 2 CardBus Ethernet R2BE100,
and an older RealPort CardBus Ethernet RBE100. I am currently in no
position of trying a different notebook, since the machine in question
(a Maxdata Artist Eton Pro from 1999, most probably a chicony OEM
product) is the only CardBus-able Linux notebook around. All three
Xircom Cards work fine with Windows 98 on that box, and an even older
16 bit Xircom RealPort card works fine with Linux.

Is it possible that I am doing something wrong?

2.4.13-ac5 has the patched xircom_tulip_cb from 2.4.13-pre3?

Any hints will be appreciated.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Karlsruhe, Germany |  lose things."    Winona Ryder | Fon: *49 721 966 32 15
Nordisch by Nature |  How to make an American Quilt | Fax: *49 721 966 31 29
