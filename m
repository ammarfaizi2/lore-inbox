Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWFTVcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWFTVcZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 17:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWFTVcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 17:32:25 -0400
Received: from mx1.suse.de ([195.135.220.2]:12502 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751188AbWFTVcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 17:32:24 -0400
Date: Tue, 20 Jun 2006 14:29:08 -0700
From: Greg KH <gregkh@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Dave Olson <olson@unixfolk.com>, discuss@x86-64.org,
       Brice Goglin <brice@myri.com>, linux-kernel@vger.kernel.org,
       Greg Lindahl <greg.lindahl@qlogic.com>
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilities
Message-ID: <20060620212908.GA17012@suse.de>
References: <fa.5FgZbVFZIyOdjQ3utdNvbqTrUq0@ifi.uio.no> <fa.URgTUhhO9H/aLp98XyIN2gzSppk@ifi.uio.no> <Pine.LNX.4.61.0606192237560.25433@osa.unixfolk.com> <200606200925.30926.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606200925.30926.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 09:25:30AM +0200, Andi Kleen wrote:
> 
> > Sure, that's true of almost everything new.   It remains broken until people
> > start using it, complain, and get the bugs fixed.   Some of us have a vested
> > interest in having MSI work, since it's the only way we can deliver interrupts.
> > We've already worked with a few BIOS writers to get problems fixed, and we'll
> > keep doing so as we find problems.   If enough hardware vendors and consumers
> > do so, the broken stuff will get fixed, and stay fixed, because it will get
> > tested.
> 
> Sometimes there are new things that work relatively well and only break occassionally
> and then there are things where it seems to be the other way round.
> 
> My point was basically that every time we tried to turn on such a banana green feature
> without white listing it was a sea of pain to get it to work everywhere
> and tended to cause far too many non boots
> 
> (and any non boot is far worse than whatever performance advantage you get
> from it) 
> 
> So if there are any more MSI problems comming up IMHO it should be
> white list/disabled by default and only turn on after a long time when
> Windows uses it by default or something. Greg, do you agree?

No, I don't want a whitelist, as it will be hard to always keep adding
stuff to it (unless we can somehow figure out how to put a "cut-off"
date check in there).  Yes, we do have a number of systems today that
have MSI issues, but the newer ones all work properly, and we should
continue on with the way we have today (blasklist problem boards, as the
rest of the PCI subsystem works with the quirks).

thanks,

greg "the optimist" k-h
