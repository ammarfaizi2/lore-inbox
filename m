Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317170AbSFLUff>; Wed, 12 Jun 2002 16:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317299AbSFLUfe>; Wed, 12 Jun 2002 16:35:34 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:29446 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317170AbSFLUfd>; Wed, 12 Jun 2002 16:35:33 -0400
Date: Wed, 12 Jun 2002 16:30:10 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Nick Evgeniev <nick@octet.spb.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.19-preX IDE bugs
In-Reply-To: <Pine.LNX.4.10.10206121130160.15604-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.3.96.1020612160915.337C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002, Andre Hedrick wrote:

> The hardware changed and the interrupt parser feature that stablized the
> old chipsets under SMP is gone.  The new chipsets (20268 and above) do not
> have a location with sticky bits.  So in some cases I expect things to go
> south, but in general they should not.  Otherwise promise would be all
> over the issue.

  Okay, thanks, that clarifies it, and if I read it right this may be a
permanent restriction. If the system is running noapic so the ints all go
to CPU0 does that help the situation? In a sane system I agree with Alan
that this is not a performance hit, or at least not significant.
 
> > On Wed, 12 Jun 2002, Alan Cox wrote:

> > > Then I suggest you give up computing, because PC hardware doesnt make
> > > your grade. BTW the general open promise bugs *dont* include data
> > > corruption so I suspect it may be your h/w thats hosed.

> Andre Hedrick
> LAD Storage Consulting Group

Guys, I wasn't questioning anyone's competence, just agreeing with the
original poster that if this is going to be an ongoing issue of stability
it might be held back for a version until there is time to either program
around it or characterize the conditions under which it causes problems. 
And if that means that I can't trust it SMP, I don't think I'm a bad guy
to suggest the config drop the driver if SMP support is selected.

I don't mind moving a card to another system, and even if I didn't have
another system I would rather not take that particular risk. And if it
won't work reliably SMP then perhaps Promise should be taking some action.
There are SMP W2k machines out there, too. 

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

