Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273033AbTGaOJM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 10:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273035AbTGaOJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 10:09:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57605 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S273033AbTGaOJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 10:09:10 -0400
Date: Thu, 31 Jul 2003 16:09:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
Message-ID: <20030731140908.GB16463@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net> <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net> <20030731094231.GA464@elf.ucw.cz> <3F291B9E.10109@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F291B9E.10109@pacbell.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>All of which is a roundabout way of adding to what I
> >>said:  the PM infrastructure USB will need to rely on
> >>seems like it needs polishing yet!  :)
> >
> >
> >Do you need vetoing? Otherwise it should be ready, except for APM.
> 
> USB drivers don't talk suspend/resume yet, so they
> won't notice missing features there.  Regressions
> are a different story though.
> 
> But I can imagine that usb-storage (or is that SCSI?)
> might want to veto suspending devices that are being
> used for some kinds of i/o.  Eventually it should exist.

For what kind of I/O? I do not see a reason for disk to veto
suspend. CD-burner might want to do that, but it still would be bad
idea... (Running on battery, battery goes low, and you destroy your CD
*and* your filesystem.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
