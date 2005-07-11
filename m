Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVGKLVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVGKLVW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 07:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVGKLVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 07:21:22 -0400
Received: from styx.suse.cz ([82.119.242.94]:21719 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261643AbVGKLVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 07:21:21 -0400
Date: Mon, 11 Jul 2005 13:21:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stelian Pop <stelian@popies.net>
Cc: Peter Osterlund <petero2@telia.com>, Andrew Morton <akpm@osdl.org>,
       Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
Message-ID: <20050711112121.GA24345@ucw.cz>
References: <20050708101731.GM18608@sd291.sivit.org> <1120821481.5065.2.camel@localhost> <20050708121005.GN18608@sd291.sivit.org> <20050709191357.GA2244@ucw.cz> <m33bqnr3y9.fsf@telia.com> <20050710120425.GC3018@ucw.cz> <m3y88e9ozu.fsf@telia.com> <1121078371.12621.36.camel@localhost.localdomain> <20050711110024.GA23333@ucw.cz> <1121080115.12627.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121080115.12627.44.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 01:08:35PM +0200, Stelian Pop wrote:

> Possible. The 'fuzz' parameter in input core serves too many usages
> ihmo. Let me try removing the quick motion compensation and see...

It was designed for joysticks and works very well for them. Usefulness
for other device types may vary. And I'll gladly accept patches to
improve it.

> > > I already thought about this, one problem is that the sensors do not
> > > report the pressure but only the amount of surface touched. A person
> > > with thick fingers will always generate higher pressures then one with
> > > thin ones, no matter how hard they push on the touchpad.
> > 
> > That's what all other touchpads do.
> 
> I thought the hardware is capable of calculating real pressure...

Since the sensor is just a multi-layer PCB with a clever trace layout,
it can't.

> > > I don't think this value is reliable enough to be reported to the
> > > userspace as ABS_PRESSURE...
> > 
> > I believe it'd still be more useful than a two-value (0 and 100) output.
> 
> Ok, I'll do it.

Thanks. Should I wait for that or apply the patch you just sent?

> > This could be quite useful, too, for right and middle button taps (2 and
> > 3 fingers) - since the Macs lack these buttons.
> 
> Indeed. But this can be a later improvement, let's make one finger work
> for now :)
 
Agreed.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
