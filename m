Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264297AbRFGDbF>; Wed, 6 Jun 2001 23:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264298AbRFGDaz>; Wed, 6 Jun 2001 23:30:55 -0400
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:33547 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S264297AbRFGDas>; Wed, 6 Jun 2001 23:30:48 -0400
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
Subject: xircom_cb problems
Message-ID: <991884643.3b1ef5637fca7@eargle.com>
Date: Wed, 06 Jun 2001 23:30:43 -0400 (EDT)
From: Tom Sightler <ttsig@tuxyturvy.com>
Cc: Tom Sightler <ttsig@tuxyturvy.com>, linux-kernel@vger.kernel.org,
        arjan@fenrus.demon.nl
In-Reply-To: <200106062154.f56LsE115507@moisil.badula.org>
In-Reply-To: <200106062154.f56LsE115507@moisil.badula.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The patch does only one thing: it instructs the card not to negotiate
> full-duplex modes, because (for undocumented and yet unexplained
> reasons)
> full-duplex modes don't work well on this card.
> 
> If you had problems before, then their cause is most likely elsewhere.
> 1-second ping time is definitely wrong.

Well, I compiled the driver from 2.4.4-ac11, 2.4.5-ac3, and 2.4.5-ac9 all with
the exact same source from 2.4.5-ac9, and my problems are 100% repeatable on my
hardware.

At home where I have a 10Mb half-duplex hub connection all of the drivers work
properly.

At work where I have a 10/100Mb full-duplex switch connection the drivers work
exactly as I described before:

2.4.4-ac11 -- mostly works fine -- minor problems awaking from sleep

2.4.5-ac3 -- seems to work but pings are >1 second (yes really a full second)

2.4.5-ac9 -- keeps logging "Link is absent" then "Linux is 100 mbit" over and
over when trying to pull an IP address via dhcp using pump or dhcpcd. 
Interestingly manually setting an IP address seems to work fine with this driver.

> The thing is, I don't really see any significant differences between
> the
> 2.4.4-ac11 driver and the 2.4.5-ac9 driver. I see lots of clean-ups,
> some
> power management stuff, and the half-duplex stuff. None of them should
> affect the core functionality directly..

I looked at this before posting, and generally agree, but the results are 100%
reproducable on my machine as listed above, so they must be having some affect.
 My current working system is 2.4.5-ac9 with the driver source from 2.4.4-ac11
recomiled for it and it's working great (minor resume problems aside).

> Please do me a favor: comment out the call to set_half_duplex() (in
> xircom_up), recompile and see if it makes a difference.

I'll do this tomorrow morning when I get in and report back.  Thanks for the
help, I'd really like to see this card get stable as we have it in a lot of our
laptops here at work.

> > One other note, the version in 2.4.4-ac11 is listed as 1.33 while
> the
> > version in 2.4.5-ac9 is 1.11, why did we go backwards?  Were there
> > significant problems with the newer version?  The 1.33 sure seems to
> work
> > better for me.
> 
> The CVS version is almost irrelevant, I guess Arjan simply rebuild his
> repository.

And you would be correct as Arjan confirmed in a follow up messages, sorry about
that, it just looked strange.

Thanks for the help,
Tom

