Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264788AbVBDNpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbVBDNpW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 08:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVBDNpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 08:45:22 -0500
Received: from styx.suse.cz ([82.119.242.94]:39660 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S266197AbVBDNpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 08:45:13 -0500
Date: Fri, 4 Feb 2005 14:45:28 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stephen Evanchik <evanchsa@gmail.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Message-ID: <20050204134528.GA12001@ucw.cz>
References: <a71293c20502031443764fb4e5@mail.gmail.com> <200502031934.16642.dtor_core@ameritech.net> <20050204063520.GD2329@ucw.cz> <a71293c205020405174ffa8d9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71293c205020405174ffa8d9d@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 08:17:43AM -0500, Stephen Evanchik wrote:
> On Fri, 4 Feb 2005 07:35:20 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > > >  /*
> > > > + * Try to initialize the IBM TrackPoint
> > > > + */
> > > > +   if (max_proto > PSMOUSE_PS2 && trackpoint_init(psmouse) == 0) {
> > > > +           psmouse->vendor = "IBM";
> > > > +           psmouse->name = "TrackPoint";
> > > > +
> > > > +           return PSMOUSE_PS2;
> > >
> > > Why PSMOUSE_PS2? Reconnect will surely not like it.
> > 
> > Indeed. IIRC this patch killed wheel mouse detection in ubuntu.
> 
> Earlier versions of the patch didn't disable the device while probing
> so events could be interpreted as the magic ID of a TrackPoint. It now
> resets and disables the PS/2 device before detection but not after a
> detect failure.

Since we fixed libps2, this shouldn't happen anymore, as long as the
BIOS doesn't inject an endless stream of data from an USB mouse.

> I'll clean that up so its more sensible.

Thanks.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
