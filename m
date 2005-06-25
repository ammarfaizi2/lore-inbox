Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263322AbVFYEBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbVFYEBB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 00:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263316AbVFYEBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 00:01:01 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:29647 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261416AbVFYEAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 00:00:54 -0400
Date: Sat, 25 Jun 2005 06:00:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jim Crilly <jim@why.dont.jablowme.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org
Subject: Re: aic79xx -> can't  suspend
Message-ID: <20050625040051.GF22393@atrey.karlin.mff.cuni.cz>
References: <1119549104.13259.1.camel@mindpipe> <20050623193224.GD2251@voodoo> <1119558145.1609.3.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119558145.1609.3.camel@mindpipe>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I have a machine with an Adaptec 2940U2W adapter running 2.6.11.  When I
> > > try to go into standby like so:
> > > 
> > >     echo standby > /sys/power/state
> > > 
> > > this is what happens:
> > 
> > AFAIK no SCSI drivers have had power management functions implemented, a
> > quick grep for PM_ in drivers/scsi seems to confirm that only the PCMCIA
> > SCSI drivers even look for PM events.
> 
> Hmm, actually, this is still pretty bad.  Shouldn't the suspend fail
> with "power management not implemented for device aic9xxx?" rather than
> crashing and burning?

That check is simply not there. We don't know if device is "suspend
not yet implemented" or "suspend is not needed" class... Sorry.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
