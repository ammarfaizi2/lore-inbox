Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269999AbTGaWDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274882AbTGaWDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:03:23 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:64748 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270634AbTGaWDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:03:15 -0400
Date: Fri, 1 Aug 2003 00:03:00 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
Message-ID: <20030731220300.GB487@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net> <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net> <1059686596.7187.153.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059686596.7187.153.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The pm_*() is how a handful of sound drivers and other random
> > stuff register themselves -- and how PCI does it.
> > 
> > I'd sure have expected PCI to only use the driver model stuff,
> > and I'll hope all those users will all be phased out by the
> > time that 2.6 gets near the end of its test cycle.
> 
> PCI is broken since it does both (and thus, if we call both rounds
> of notifiers, we end up suspending PCI twice, the second time without
> any ordering constraints). In my trees, I comment out that "legacy"
> stuff (though I also don't call the old-style pm_* stuff anymore
> neither)

Can you mail me a patch? [Where does PCI do its "second round"? From a
quick look I did not see that.]

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
