Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290909AbSASEhf>; Fri, 18 Jan 2002 23:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290910AbSASEhZ>; Fri, 18 Jan 2002 23:37:25 -0500
Received: from sunny-legacy.pacific.net.au ([210.23.129.40]:16097 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S290909AbSASEhO>; Fri, 18 Jan 2002 23:37:14 -0500
From: "David Luyer" <david_luyer@pacific.net.au>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "'Oliver Xymoron'" <oxymoron@waste.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: vm philosophising
Date: Sat, 19 Jan 2002 15:42:45 +1100
Organization: Pacific Internet (Australia)
Message-ID: <004301c1a0a3$bd172a90$46943ecb@pacific.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3311
Importance: Normal
In-Reply-To: <E16Rec7-0007fg-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > There is another VM that has a property that people would like:
> > deterministically handling memory exhaustion. Unfortunately, that VM
> > probably can't co-exist with over-commit and the 
> performance gains that
> > affords.
> 
> It can definitely co-exist. Overcommit control is just a book keeping
> exercise on address space commits.

And that's a _definitely_; other OS's have done it.  Digital Unix, for
one,
on the basis of a file called 'swapdefault', swapped between overcommit
and precommit modes.  I was rather disappointed when I first tried to
enable overcommit mode on Solaris 2.x (where 'x' was probably somewhere
around 4) and searched for quite some time before giving up and deciding
it wasn't a tunable option...

Although I've never actually deliberately run a system in precommit
mode,
it always used to be the first thing to "fix" on a Digital Unix box, and
when I discovered Solaris had the same "flaw" my suggestion was to move
the affected applications (large applications which fork before exec'ing
or fork short lived-children, at around 1/2Gb+ each, which should just
be short-lived COW shared mappings and not exhaust memory) to Linux.

And while precommit may be something people ask for, I'd have to say
many
of them would, having experienced the difference on identical hardware,
then realise what a bad idea it was and go back to the current mode.
That is, it sounds like a big waste of time to implement the
'traditional'
behaviour which Linux is already so much better than.

David.
--
David Luyer                                     Phone:   +61 3 9674 7525
Network Manager                P A C I F I C    Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T   Mobile:  +61 4 1111 BYTE
http://www.pacific.net.au/                      NASDAQ:  PCNTF

