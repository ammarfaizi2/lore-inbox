Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310475AbSCBWrE>; Sat, 2 Mar 2002 17:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310476AbSCBWqy>; Sat, 2 Mar 2002 17:46:54 -0500
Received: from ja.mac.ssi.bg ([212.95.166.194]:16649 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S310475AbSCBWqo>;
	Sat, 2 Mar 2002 17:46:44 -0500
Date: Sun, 3 Mar 2002 00:46:12 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@u.domain.uli
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: erich@uruk.org, Szekeres Bela <szekeres@lhsystems.hu>,
        Daniel Gryniewicz <dang@fprintf.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network Security hole (was -> Re: arp bug )
In-Reply-To: <E16hIAb-0000E6-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0203030035030.9147-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Sat, 2 Mar 2002, Alan Cox wrote:

> > behavior causes some problems for setups with rp_filter protection
> > and interfaces attached to same hub. If you want to find the reason
> > for this, here it is:
>
> rp_filter is an add on - not exactly default standards behaviour. If you
> want to make the case that rp_filter = 2 means apply a both way rule then
> I've personally no problem with that argument

	The rp_filter value of 2 is not support from Linux and
after reading the "5.3.8 Source Address Validation" paragraph
from rfc1812 it seems rp_filter 1 covers it. What exactly do
you mean by value of 2? Note that the remote box does not want to
spoof, it was directed from BOX1 to a wrong MAC where the traffic is 
spoofed, the remote hosts are not guilty. They connect to the MAC we 
provide by broadcasts.

	To Erich, rfc1812, 5.3.8 Source Address Validation:

If this feature is implemented, it MUST be disabled by default

Regards

--
Julian Anastasov <ja@ssi.bg>

