Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312696AbSDXWXQ>; Wed, 24 Apr 2002 18:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312704AbSDXWXP>; Wed, 24 Apr 2002 18:23:15 -0400
Received: from viruswall2.epcnet.de ([62.132.156.25]:28938 "HELO
	viruswall.epcnet.de") by vger.kernel.org with SMTP
	id <S312696AbSDXWXO>; Wed, 24 Apr 2002 18:23:14 -0400
Date: Thu, 25 Apr 2002 00:23:06 +0200
From: jd@epcnet.de
To: greearb@candelatech.com
Subject: AW: Re: AW: Re: AW: Re: VLAN and Network Drivers 2.4.x
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <839712474.avixxmail@nexxnet.epcnet.de>
In-Reply-To: <3CC6F22E.9060402@candelatech.com>
X-Priority: 3
X-Mailer: avixxmail 1.2.2.7
X-MAIL-FROM: <jd@epcnet.de>
Content-Type: text/plain; charset="iso-8859-1";
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: <greearb@candelatech.com>
> Gesendet: 24.04.2002 20:00
>
> > This creates a support issue.  It's almost impossible to field
> > bug reports effectively once you start letting users do stuff
> > like this. 
> We let users do much worse: rm -fr /
> won't even warn you.

But it would do, what we expect. VLAN on a e.g. unpatched tulip driver is somewhat unpredictable.
You can hope any application is using small packets, but if not things get worse.

>  I'm all for warning the user, but since the
> MTU issue can be worked around by setting the VLAN MTU to 1496,
> and sometimes setting the eth0 MTU to 1504, then putting hard
> restrictions in the kernel sounds like a really bad idea.

This sounds very "experimental". What about the non-VLAN packets on eth0, when you set the MTU
1504?

I like the NETIF_F_VLAN_CHALLENGED capability in the driver itself, which is then tested by the net subsystem on
creation of a VLAN. No more tweaks and fiddling around with MTU and framesizes.

Greetings

      Jochen Dolze

