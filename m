Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270634AbTGaWKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274824AbTGaWKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:10:20 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:1774 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270634AbTGaWKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:10:12 -0400
Date: Fri, 1 Aug 2003 00:09:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Dominik Brugger <ml.dominik83@gmx.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: OHCI problems with suspend/resume
Message-ID: <20030731220958.GA459@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0307251057300.724-100000@ida.rowland.org> <1059153629.528.2.camel@gaston> <3F21B3BF.1030104@pacbell.net> <20030726210123.GD266@elf.ucw.cz> <3F288CAB.6020401@pacbell.net> <1059686596.7187.153.camel@gaston> <3F299069.1010905@pacbell.net> <1059689105.2417.195.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059689105.2417.195.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I suspect that USB should do some non-global PM stuff too.
> > Hub ports can be suspended when the devices connected to them
> > are idle for long enough ... that's not something I'd expect
> > system-wide PM policies to address.
> 
> Indeed, this is not addressed, though it may sense to have
> a way in the device model to call the suspend/resume callbacks
> of "childs" of a given hub only for that purpose, I don't think
> this is implemented yet. Maybe talk to Patrick about it.
> 
> In general "local" power management (automatic disk spin down,
> chipset idle-pm, etc...) is ... local to the driver, though you
> can probably use the power state field of struct device to
> store your current state if it maps to those semantics.

Is not disk spin-down policy, and thus belonging to userspace? Having
daemon poll for inactivity of hubs once every 5 minutes and sending
them to sleep should not hurt, too...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
