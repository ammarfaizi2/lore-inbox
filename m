Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261772AbREPCfM>; Tue, 15 May 2001 22:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261770AbREPCev>; Tue, 15 May 2001 22:34:51 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:19593 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S261769AbREPCel>; Tue, 15 May 2001 22:34:41 -0400
Message-ID: <3B01E670.E96A2865@uow.edu.au>
Date: Wed, 16 May 2001 12:31:12 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Lundell <jlundell@pobox.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>,
		<Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com> <p05100330b7277e2beea6@[207.213.214.37]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell wrote:
> 
> ...
> I *like* eth0..n (I'd like net0..n better). And I *can't* ask what
> eth0 and eth1 are, by the way, but I should be able to (Jeff Garzik
> has proposed an extension to ethtool to help out this lack, but it's
> not in Linux today, and needs concrete implementation anyway).
> 
> But that's not my point. I'm *not* proposing that we exchange eth0
> for geographic names. I'm suggesting, though, that the location of
> the device is *not* meaningless, because it's the physically-located
> RJ45 socket (or whatever) that I have to connect a particular cable
> to. Sure, no big deal for systems with a single connection, but it
> becomes a real pain when you've got a dozen, which is a reasonable
> number for some network-infrastructure functions (eg firewalls).
> 
> When I ifconfig one of a collection of interfaces, I'm very much
> talking about the specific physical interface connected via a
> specific physical cable to a specific physical switch port.
> 

Yes, it can be a security trap as well - physically move a card and
your firewall rules end up being applied to the wrong connection.

The 2.4 kernel allows you to rename an interface.  So you can build
a little database of (MAC address/name) pairs. Apply this after booting
and before bringing up the interfaces and everything has the name
you wanted, based on MAC address.

Andi Kleen has an app which does this:

	ftp://ftp.firstfloor.org/pub/ak/smallsrc/nameif.c

but apparently some additional kernel work is needed to make
this work 100% correctly.  I do not know what the specific
problem is.


-
