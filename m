Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314491AbSD1U2R>; Sun, 28 Apr 2002 16:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314492AbSD1U2Q>; Sun, 28 Apr 2002 16:28:16 -0400
Received: from viruswall2.epcnet.de ([62.132.156.25]:11278 "HELO
	viruswall.epcnet.de") by vger.kernel.org with SMTP
	id <S314491AbSD1U2P>; Sun, 28 Apr 2002 16:28:15 -0400
Date: Sun, 28 Apr 2002 22:28:06 +0200
From: jd@epcnet.de
To: davem@redhat.com
Subject: Re: VLAN and Network Drivers 2.4.x
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <467685860.avixxmail@nexxnet.epcnet.de>
In-Reply-To: <20020427.194302.02285733.davem@redhat.com>
X-Priority: 3
X-Mailer: avixxmail 1.2.2.8
X-MAIL-FROM: <jd@epcnet.de>
Content-Type: text/plain; charset="iso-8859-1";
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: <davem@redhat.com>
> Gesendet: 28.04.2002 04:54
>
>    I don't know how many cards won't support VLAN nowadays. But i will test
>    these changes with my third party driver (just recompile it against pre-2.4.19)
>    and report the results.
>    
> This will tell us exactly nothing.  It will continue to tell us
> nothing until I make the change whereby NETIF_F_VLAN_CHALLENGED is set
> by default and devices known to work are updated to clear it.

Then i understood it right. I hope your change is made in this way only for the 2.5 tree.
Changing all drivers is ok for 2.5, but most third party driver supplier update their drivers
only rarely.

> Please don't bother posting the results, we know what will happen.

I think your solution is ok for 2.5 but not for 2.4. On the 2.4 series it would be easier to
add a flag which is set if the driver is VLAN ready. This wouldn't break third party drivers,
which are not VLAN ready. And vconfig would report the right thing without changing any
driver code (as it was intended by one of my former postings).

Greetings

   Jochen Dolze

