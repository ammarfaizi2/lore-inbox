Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUHJKJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUHJKJU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 06:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUHJKJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 06:09:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21187 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263893AbUHJKIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 06:08:47 -0400
Date: Tue, 10 Aug 2004 12:08:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Fix Device Power Management States
Message-ID: <20040810100846.GD9034@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> <20040809113829.GB9793@elf.ucw.cz> <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net> <1092098630.14100.73.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092098630.14100.73.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Aha, so you are saying these do not need to be done in hardware order?
> > 
> > AFAICT, no.
> 
> As stated in my previous mail, I don't agree here... there are
> dependencies that cannot be dealt otherwise. USB was an example
> (ieee1394 is another), IDE is one, SCSI, i2c, whatever ... 
> 
> Of course, if we consider those "bus" drivers not to have class
> and thus not to be stopped and only the "leaf" devices to get stopped,
> that may work... I'm not sure we are not missing something there
> though...

Stopping only leafs is *not* enough as usb host controllers do DMA.

									Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
