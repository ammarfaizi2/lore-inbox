Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVBDG7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVBDG7q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 01:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVBDG4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 01:56:21 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:10635 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263434AbVBDGwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 01:52:41 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2.6.11-rc3] IBM Trackpoint support
Date: Fri, 4 Feb 2005 01:52:39 -0500
User-Agent: KMail/1.7.2
Cc: Stephen Evanchik <evanchsa@gmail.com>, linux-kernel@vger.kernel.org
References: <a71293c20502031443764fb4e5@mail.gmail.com> <200502031934.16642.dtor_core@ameritech.net> <20050204063520.GD2329@ucw.cz>
In-Reply-To: <20050204063520.GD2329@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502040152.39728.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 February 2005 01:35, Vojtech Pavlik wrote:
> On Thu, Feb 03, 2005 at 07:34:16PM -0500, Dmitry Torokhov wrote:
> > On Thursday 03 February 2005 17:43, Stephen Evanchik wrote:
> > > Vojtech,
> > > 
> > > Here is a patch that exposes the IBM TrackPoint's extended properties
> > > as well as scroll wheel emulation.
> > > 
> > > 
> > 
> > Hi,
> > 
> > Very nice although I have a couple of comments.
> > 
> > >  /*
> > > + * Try to initialize the IBM TrackPoint
> > > + */
> > > +	if (max_proto > PSMOUSE_PS2 && trackpoint_init(psmouse) == 0) {
> > > +		psmouse->vendor = "IBM";
> > > +		psmouse->name = "TrackPoint";
> > > + 
> > > +		return PSMOUSE_PS2;
> > 
> > Why PSMOUSE_PS2? Reconnect will surely not like it.
> 
> Indeed. IIRC this patch killed wheel mouse detection in ubuntu.
> 

We may need yet another psmouse_reset after unsuccessful test.

-- 
Dmitry
