Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155429AbPF2Adg>; Mon, 28 Jun 1999 20:33:36 -0400
Received: by vger.rutgers.edu id <S155210AbPF2Acx>; Mon, 28 Jun 1999 20:32:53 -0400
Received: from smtp3.mindspring.com ([207.69.200.33]:5256 "EHLO smtp3.mindspring.com") by vger.rutgers.edu with ESMTP id <S155372AbPF2Ac0>; Mon, 28 Jun 1999 20:32:26 -0400
Date: Mon, 28 Jun 1999 19:37:28 -0500 (CDT)
From: "Paul M. Hirsch" <pauldoom@telebot.com>
To: Zach Brown <zab@zabbo.net>
cc: linux-kernel@vger.rutgers.edu
Subject: Re: FTP benchmark proposal
In-Reply-To: <Pine.LNX.4.10.9906281819340.867-100000@hoser>
Message-ID: <Pine.LNX.4.04.9906281849360.10365-100000@rasputin.mgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

> I've talked with some ZD Labs people, and they're at least interested in
> investigating letting us use their lab for a bit.  It would be silly to
> ignore this offer, as they have all the hardware setup and ready to go and
> good experience running this sort of thing.

Hey, if they will let you play, go for it.  I wasn't saying we should turn
down hardware access or help from ZD Labs or any other source.  I was just
saying that it would be nicer to have something more concrete.  ZD has
other things to test.  If they are willing to help, great, but we can't
expect them to offer up hardware to use forever.  That said, I stand
corrected about thier motives and should not have insinuated they were
offering up support with only themselves in mind.  Perhaps I've grown a
bit too jaded.

> why?  should we also use a single ide drive?  multiple 100mb nics simply
> do not aggregate traffic as well as a single gigabit card.  If I were
> setting up a site of this magnitude I sure as hell wouldn't want to mess
> around with the silliness of having lots of nics.  

No no.  A Gb card is the way to go in the real world, no question,
and it would be a cold day in hell before I would choose multiple NICs
over a Gb in this scenario.  But, there are cases where multiple NICs
makes some sense.  Consider the case of a fileserver serving 4 subnets in
a shop with only a routed 100Mb backbone.  Will they rip out the routers
and throw in Level 3 Gb switches just for thier fileserver?  Cost may
force them to go with 4 NICs, one on to each subnet, instead.  It isn't
like 1xIDE vs. SCSI RAID.  One IDE drive sucks because of its physical
limitations.  4x100Mb NICs don't beat 1 Gb NIC, but NT got more out of 4
NICs than Linux did.  Yes, this is just benchmark and it means little
in the real world, but it shows that there is some sort of scaling problem
in the Linux 2.2.x network code.   

Which leads to:
> The software problem is mostly fixed in 2.3, the fundamental hardware
> problem still remains.

Absolutly Right.  That's how it should be.  Linux can't fix the
hardware, but it should push it to its limits.  Back to the issue of a
test platform, if we have to choose Gb or 100Mb, Gb it the thing to test.
I'm no kernel hacker, but I assume the network folks would like to be able
to test multi interface scaling in addition to Gb NIC performance.

Now, I will shut my yap.

-Paul

----------------------------------------------------------------------
 Paul M. Hirsch             Network Engineer               EXi, Corp.
  smtp[0]-->phirsch@exicorp.com       smtp[1]-->pauldoom@telebot.com
 PGP fingerprint = CF43 3528 BA9D 9681 C242  06C3 6235 8573 71EA 5828
----------------------------------------------------------------------




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
