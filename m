Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbTICPNX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263043AbTICPNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:13:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20135 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262702AbTICPNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:13:19 -0400
Date: Wed, 3 Sep 2003 17:13:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, rmk@arm.linux.org.uk
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030903151318.GB30629@atrey.karlin.mff.cuni.cz>
References: <20030831232812.GA129@elf.ucw.cz> <Pine.LNX.4.44.0309010925230.7908-100000@home.osdl.org> <20030901211220.GD342@elf.ucw.cz> <20030901225243.D22682@flint.arm.linux.org.uk> <20030901221920.GE342@elf.ucw.cz> <20030901233023.F22682@flint.arm.linux.org.uk> <20030901224018.GA470@elf.ucw.cz> <20030902171729.GB17807@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902171729.GB17807@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I don't think PCI device support broke - Pat seems to have fixed up
> > > all that fairly nicely, so the driver model change should be
> > > transparent.
> > 
> > As far as I can test, yes, at least UHCI looks broken :-(. It is true
> > that calling convention at PCI level did not change.
> 
> UHCI is broken?  How?  
> 
> Hey, I don't think that the USB code will work at all with suspend
> without just unloading the whole USB core.

Well, it did work okay in -test3. UHCI has support (leftover from APM
times or something like that), and it was properly called from suspend
sequence. USB devices were "disconnected/reconnected", but it all
worked.

								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
