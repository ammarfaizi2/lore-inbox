Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318748AbSIKMuY>; Wed, 11 Sep 2002 08:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318749AbSIKMuY>; Wed, 11 Sep 2002 08:50:24 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:46770 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S318748AbSIKMuX>; Wed, 11 Sep 2002 08:50:23 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Wed, 11 Sep 2002 14:33:52 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michael Durket <durket@rlucier-home2.stanford.edu>,
       Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ignore pci devices?
Message-ID: <20020911123352.GB6863@bytesex.org>
References: <20020910134708.GA7836@bytesex.org> <1031668032.31549.60.camel@irongate.swansea.linux.org.uk> <20020911105131.GB5955@bytesex.org> <1031744938.2768.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031744938.2768.37.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 12:48:58PM +0100, Alan Cox wrote:
> On Wed, 2002-09-11 at 11:51, Gerd Knorr wrote:
> > Well, at least nothing in PCI space.  It looks just like a random,
> > cheap bt878 card.
> 
> Arggh read the email properly this time 8)
> 
> If its a BT878 on a board then assuming we can't tell the difference I
> guess it doesn't work mixed with tv cards. Does it work in windows
> paired with a real video capture card by some cheapo cardmaker that also
> doesn't set the ssid ?

Don't know, Cc:'ed the owner of the card.  Currently it is paired with
another bt878 grabber card which has a PCI Subsystem ID.

The windows driver's I've seen so far do check the ssid, althrough some
handle it better than others:  The (old) Hauppauge drivers I have become
greatly confused if they find a card with a unknown ssid.  Maybe that is
fixed by now.  The Terratec Windows drivers just pick the card they know
about and ignore the other one as they should.  Don't know what the
generic/reference/cheapo-card drivers do.

The problem bttv has here is that it can't simply ignore cards without
ssid because that would break all the crap^Wcheap boards out there ...

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
