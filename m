Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVLYAwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVLYAwO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 19:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVLYAwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 19:52:13 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:46671 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750764AbVLYAwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 19:52:13 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PowerBook5,8 - TrackPad update
Date: Sat, 24 Dec 2005 19:52:09 -0500
User-Agent: KMail/1.8.3
Cc: Pavel Machek <pavel@ucw.cz>, Michael Hanselmann <linux-kernel@hansmi.ch>,
       Stelian Pop <stelian@popies.net>,
       Parag Warudkar <kernel-stuff@comcast.net>,
       debian-powerpc@lists.debian.org,
       linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
       johannes@sipsolutions.net
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net> <20051224231928.GC2183@elf.ucw.cz> <1135470801.6387.1.camel@localhost.localdomain>
In-Reply-To: <1135470801.6387.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512241952.10687.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 December 2005 19:33, Benjamin Herrenschmidt wrote:
> 
> > It should be doable once in gpm, all other apps can use gpm's repeater
> > mode...
> > 
> > > When it's in raw mode for use by the synaptics X driver, if course, it's
> > > expected that those things are to be done by that driver.
> > 
> > ...but you are right, doing it in /dev/input/mice emulation layer
> > makes some sense. OTOH I thought we were moving away from
> > /dev/input/mice... Its Dmitry's call I guess.
> 
> Heh, yes, it is. No hurry anyway, I finally got synaptics working
> properly in X ...
> 
> Why would we move away from the mouse mux ? It's proven to be very
> useful to me at least :)
>

It is very limited - number of buttons, wheels, etc. Once X supports
hotplugging mouse multipexor outgrows its usefullness (GPM can simply
be restarted every time we detect new input device).

-- 
Dmitry
