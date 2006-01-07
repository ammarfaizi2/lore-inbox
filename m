Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752574AbWAGSkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbWAGSkT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 13:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbWAGSkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 13:40:19 -0500
Received: from styx.suse.cz ([82.119.242.94]:4524 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1752574AbWAGSkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 13:40:18 -0500
Date: Sat, 7 Jan 2006 19:40:24 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Peter Osterlund <petero2@telia.com>,
       Luca Bigliardi <shammash@artha.org>, linux-kernel@vger.kernel.org
Subject: Re: request for opinion on synaptics, adb and powerpc
Message-ID: <20060107184024.GA11183@corona.suse.cz>
References: <20060106231301.GG4732@kamaji.shammash.lan> <1136608396.4840.206.camel@localhost.localdomain> <20060107082523.GA6276@corona.ucw.cz> <200601071104.53188.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601071104.53188.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 11:04:52AM -0500, Dmitry Torokhov wrote:
> On Saturday 07 January 2006 03:25, Vojtech Pavlik wrote:
> > 
> > If a relative mode is an absolute must, then a kernel option is IMO
> > sufficient (we have psmouse.proto=imps for the classic PS/2 Synaptics
> > pads), although a sysfs attribute would likely be better.
> > 
> 
> Just FYI, writing into /sys/bus/serio/devices/serioX/protcol allows
> swicthing ptorocol dynamically (this involves teardown of old input
> device and creation of a new one).

I know, but this will not be possible if the Synaptics pad is connected
over ADB, which is the case I believe we are discussing here. 

On the other hand, if it's just PS/2 over ADB, a serio driver instead of
an input driver would make more sense.

> > In theory, we could use EV_SYN, SYN_CONFIG for notifying applications
> > that the device has changed its capabilities, but a
> > disconnect/recreation will work better, since no applications support
> > the SYN_CONFIG notification ATM.
> 
> I could see SYN_CONFIG being used to signal changes in limits (like min
> and max X coordinates) but not to basic device capabilities.

Yes, that's probably more sensible.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
