Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271286AbRHZH7I>; Sun, 26 Aug 2001 03:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271295AbRHZH66>; Sun, 26 Aug 2001 03:58:58 -0400
Received: from web12305.mail.yahoo.com ([216.136.173.103]:3851 "HELO
	web12305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271286AbRHZH6u>; Sun, 26 Aug 2001 03:58:50 -0400
Message-ID: <20010826075906.42641.qmail@web12305.mail.yahoo.com>
Date: Sun, 26 Aug 2001 09:59:06 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Poor Performance for ethernet bonding
To: Ben Greear <greearb@candelatech.com>, Willy Tarreau <wtarreau@free.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B87ED15.77741DF9@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The XOR method has been implemented to hash the
> flows based on the SRC/DST
> > MAC addresses.
> 
> If you are only hashing on MAC addresses, then you
> would become highly un-optimized in the case where a
> machine is communicating with it's default gateway
> primarily.

absolutely right, but I think that when it was
designed
(sun? cisco?), it was primarily intended as many hosts
to one (server, router or switch). A file server, a
router or even a firewall can easily balance their
load
when they are connected to several tens of
workstations. If your concern is really for peer to
peer, then Andy's method is better as long as other
hashing methods have not been implemented in the
bonding code.

> Perhaps the XOR hash is really more sophisticated??

it may be one day, but at the moment, it's designed to
be compatible with other equipments which use it too.

Willy


___________________________________________________________
Do You Yahoo!? -- Un e-mail gratuit @yahoo.fr !
Yahoo! Courrier : http://fr.mail.yahoo.com
