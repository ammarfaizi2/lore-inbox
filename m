Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVBDGzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVBDGzL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 01:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVBDGzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 01:55:10 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:62423 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261557AbVBDGyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 01:54:37 -0500
Date: Fri, 4 Feb 2005 07:54:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Stephen Evanchik <evanchsa@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Message-ID: <20050204065454.GA2796@ucw.cz>
References: <a71293c20502031443764fb4e5@mail.gmail.com> <200502031934.16642.dtor_core@ameritech.net> <20050204063520.GD2329@ucw.cz> <200502040152.39728.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502040152.39728.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 01:52:39AM -0500, Dmitry Torokhov wrote:
> On Friday 04 February 2005 01:35, Vojtech Pavlik wrote:
> > On Thu, Feb 03, 2005 at 07:34:16PM -0500, Dmitry Torokhov wrote:
> > > On Thursday 03 February 2005 17:43, Stephen Evanchik wrote:
> > > > Vojtech,
> > > > 
> > > > Here is a patch that exposes the IBM TrackPoint's extended properties
> > > > as well as scroll wheel emulation.
> > > > 
> > > > 
> > > 
> > > Hi,
> > > 
> > > Very nice although I have a couple of comments.
> > > 
> > > >  /*
> > > > + * Try to initialize the IBM TrackPoint
> > > > + */
> > > > +	if (max_proto > PSMOUSE_PS2 && trackpoint_init(psmouse) == 0) {
> > > > +		psmouse->vendor = "IBM";
> > > > +		psmouse->name = "TrackPoint";
> > > > + 
> > > > +		return PSMOUSE_PS2;
> > > 
> > > Why PSMOUSE_PS2? Reconnect will surely not like it.
> > 
> > Indeed. IIRC this patch killed wheel mouse detection in ubuntu.
> > 
> 
> We may need yet another psmouse_reset after unsuccessful test.
 
We probably should do one after every test for isolation. It's not that
big a problem now that we do the probing from a thread.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
