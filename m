Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312374AbSCUPqg>; Thu, 21 Mar 2002 10:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312375AbSCUPq1>; Thu, 21 Mar 2002 10:46:27 -0500
Received: from pool-151-197-241-89.phil.east.verizon.net ([151.197.241.89]:34491
	"EHLO porsche.genebrew.com") by vger.kernel.org with ESMTP
	id <S312374AbSCUPqO>; Thu, 21 Mar 2002 10:46:14 -0500
Message-ID: <57588.165.89.84.243.1016725824.squirrel@porsche.genebrew.com>
Date: Thu, 21 Mar 2002 10:50:24 -0500 (EST)
Subject: Re: 3Com 556B Tornado not working
From: "Rahul Karnik" <rahul@genebrew.com>
To: <akpm@zip.com.au>
In-Reply-To: <3C9822CD.47ED9565@zip.com.au>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.4)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

> How did you manage to get this message to come out with a modular
> driver?  Are there other driver options in modules.conf?

I used modprobe 3c59x options=8 debug=7, as recommended by you (or maybe
Bogdan) on the vortex mailing list. This was after I had tried it without
the options argument.

>> Transceiver type in use:  Autonegotiate.
>>  MAC settings: half-duplex.
>
> Do you expect half-duplex?

Nope, it is connected to a Linksys BEFSR41 4-port 100Mbps router, and my
desktop connects at full-duplex to the same router.

> Lots of bad things there.  Remove any special options, then
> re-run mii-diag and vortex-diag.  If your cables and peer
> are behaving then you should see happy output indicating the
> desired duplex, speed and negotiation status.

As I stated above, I tried the special options only after I was not able to
connect without them.

> If it still doesn't work, try statically assigning the IP
> address (get rid of DHCP somehow).  There were some workarounds
> in later drivers for strange interactions between some hardware
> combinations and some DHCP clients.

Tried this, it did not help.

> If it *still* doesn't work then it's time to sniff the connection
> and try to see those arp messages.

How would I do this?

> And try different cables, different link peers.

I am able to connect successfully with a 3Com Cardbus card to the same
router , using the same cable.

> And try another you-know-which operating system.  If that works OK then
> we know the hardware's good.

This would be my last effort, but I am afraid it might be my only option. At
this point, the link light never comes on, and I am afraid that I might have
installed the card incorrectly. OTOH, there seem to be several unresolved
bug reports regarding this card on the vortex mailing list, where the card
works correctly with Windows but not under Linux. Do we know of people using
this card (the 3C556B version, not the vanilla 3C556) successfully?

Thanks for your help, and please let me know if you need any other
information.
-Rahul


