Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317639AbSIJQZk>; Tue, 10 Sep 2002 12:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317698AbSIJQZk>; Tue, 10 Sep 2002 12:25:40 -0400
Received: from albireo.ucw.cz ([81.27.194.19]:33541 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id <S317639AbSIJQZj>;
	Tue, 10 Sep 2002 12:25:39 -0400
Date: Tue, 10 Sep 2002 18:30:23 +0200
From: Martin Mares <mj@ucw.cz>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ignore pci devices?
Message-ID: <20020910163023.GA3862@ucw.cz>
References: <20020910134708.GA7836@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020910134708.GA7836@bytesex.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have a small problem:  Some vendor has built a PCI board which
> (ab-)uses the bt848/878 chip in creative ways to do some DMA.  It is
> *not* a video card, thus letting the bttv driver control the card isn't
> very useful and causes trouble.  The card has no PCI Subsystem ID, so I
> can't identify and blacklist it easily.  Thus I need some way to allow
> the users to tell bttv (or the kernel) to ignore that particular PCI
> card.
> 
> Is there already something generic for this?  Some kernel parameter
> which makes pci_module_init() skip a given PCI device for example?

What about writing a "driver" which will just bind to a given
PCI device, so that the other drivers will see it's already handled?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
For every complex problem, there's a solution that is simple, neat and wrong.
