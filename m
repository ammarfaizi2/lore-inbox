Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269440AbUI3TKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269440AbUI3TKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269438AbUI3TKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:10:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35496 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S269420AbUI3TGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:06:21 -0400
Date: Thu, 30 Sep 2004 20:54:47 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: mlock(1)
Message-ID: <20040930185447.GC475@openzaurus.ucw.cz>
References: <41547C16.4070301@pobox.com> <20040924132247.W1973@build.pdx.osdl.net> <1096060045.10800.4.camel@localhost.localdomain> <20040924225900.GY3309@dualathlon.random> <1096069581.3591.23.camel@desktop.cunninghams> <20040925010759.GA3309@dualathlon.random> <1096114881.5937.18.camel@desktop.cunninghams> <20040925145315.GJ3309@dualathlon.random> <20040928084850.GA18819@elf.ucw.cz> <20040930174244.GL22008@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040930174244.GL22008@dualathlon.random>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > There must be some way of being able to check the password is correct
> > > > without compromising security by encrypting static text and storing it
> > > > at a known location! Darned if I know what it is though.
> > > 
> > > good point! Maybe we can pick random signed chars in a 4k block and
> > > guarantee their sum is always -123456. Would that be secure against
> > > plaintext attack right? It's more like a checksum than a magic number,
> > > but it should be a lot more secure than the "double" typo probability
> > > (and this way the password will be asked only once during resume).
> > > Generating those random numbers will not be the easiest thing though.
> > 
> > Actually, better solution probably is to encrypt 32-bit zero.
> > 
> > Then, you have 1:2^32 probability of accepting wrong password, still
> > if you try to brute-force it, you'll find many possible passwords.
> 
> this is just the first step an attacker needs to rule out all the
> impossible passwords and extend the crack to the other known bits. I
> don't think it's secure. My suggestion OTOH sounds completely secure
> (though much harder to implement).

Actually if your cipher is not resistant to known plaintext attack,
you have other problems anyway. There's a lot of nearly-lnown data 
(like name of process with pid 1) that single 32bit zero is no problem.

So I'm not compromising anything...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

