Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268253AbTGQTaT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 15:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268736AbTGQTaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 15:30:19 -0400
Received: from ns2.eclipse.net.uk ([212.104.129.133]:50951 "EHLO
	smtp2.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S268253AbTGQTaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 15:30:13 -0400
From: Ian Hastie <lkml@ordinal.freeserve.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6 sound drivers?
Date: Thu, 17 Jul 2003 20:44:02 +0100
User-Agent: KMail/1.5.2
References: <20030716225826.GP2412@rdlg.net> <200307171308.54518.nbensa@gmx.net> <s5hr84pytyi.wl@alsa2.suse.de>
In-Reply-To: <s5hr84pytyi.wl@alsa2.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307172044.04242.lkml@ordinal.freeserve.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 Jul 2003 17:54, Takashi Iwai wrote:
> At Thu, 17 Jul 2003 13:08:51 -0300,
>
> Norberto BENSA wrote:
> > Terje Kvernes wrote:
> > > Norberto BENSA <nbensa@gmx.net> writes:
> > > > Last time I've checked ALSA, it didn't support bass and treble,
> > > > that's why I'm using OSS (emu10k1)
> > >
> > >   I have treble and base support on my emu10k1 via ALSA.
> >
> > How could this be true if:
> >
> > Ian Hastie wrote:
> > > ALSA's support seems usable, but still doesn't allow you to programme
> > > the DSP with your own code.  OSS uses this to enable such things as
> > > bass and treble controls, as well as a selection of audio effects with
> > > code provided.  Anyone know if ALSA will allow this kind of thing in
> > > the future?
> >
> > ???
>
> the treble/bass code is implemented statically.
> (so it is also on OSS emu10k1 as default, btw.)

Are you sure about this?  My recollection from using the SF code was that Bass 
and Treble weren't there until you used the setup script that came with the 
package.  What that does is to load a piece of DSP code which provides extra 
functions.  It also has to set up the appropriate routings to enable the 
extra controls.

The insertion of arbitrary code and the easy setting up of routings are the 
two main things missing at the moment from the ALSA emu10k1 driver.  That's 
how it seems to me anyway.

> note that there is an additional switch to activate bass/treble.
> as default, this is set off.  turn it on via alsamixer to get
> effects.

OK, I was mistaken about this, there is a bass and treble control in 
alsamixer.  They even appear when it is run without a switch of any kind.  I 
can't see any mention of such a switch in the manual page either.  It does 
work, but you have to unmute the tone control switch to enable it.

-- 
Ian.

