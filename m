Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVCGHj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVCGHj0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 02:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVCGHf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 02:35:27 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:43981 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261678AbVCGHdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 02:33:20 -0500
Date: Mon, 7 Mar 2005 08:34:06 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kenan Esau <kenan.esau@conan.de>
Cc: harald.hoyer@redhat.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Message-ID: <20050307073406.GA2026@ucw.cz>
References: <1108649993.2994.18.camel@localhost> <20050217150455.GA1723@ucw.cz> <20050217194217.GA2458@ucw.cz> <1108817681.5774.44.camel@localhost> <20050219131639.GA4922@ucw.cz> <1108973216.5774.72.camel@localhost> <20050224090338.GA3699@ucw.cz> <1109664709.18617.10.camel@localhost> <20050301120839.GA5720@ucw.cz> <1110180436.3444.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110180436.3444.17.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 08:27:16AM +0100, Kenan Esau wrote:
 
> > > > > At the end of this mail you'll find some traces I did.
> > > > > 
> > > > > I also wonder if it is possible at all to probe this device. I think
> > > > > not. IMHO we should go for a module-parameter which enforces the
> > > > > lifebook-protokoll. Something like "force_lb=1". Any Ideas /
> > > > > suggestions? 
> > > > 
> > > > I'd suggest using psmouse.proto=lifebook
> > > 
> > > The current patch has implemented it that way. But the meaning is a
> > > little bit different. With proto=lifebook you ENFORCE the lifebook
> > > protocol. As far as I read the meaning of the other ones this does not
> > > really enforce these protocols.
> > 
> > That's OK. I'd like to keep the DMI probing as well, though, so it's not
> > absolutely necessary to provide the parameter.
> 
> You mean if the device is in the appropriate DMI-database use the
> lifebook protocol and if the parameter is provided use it also (although
> it might not be in the DMI database)? 

Yes.

> > > > > How does this work out with a second/external mouse?
> > > > 
> > > > The external mouse has to be in bare PS/2 mode anyway, so we don't need
> > > > to care.
> > > 
> > > Why that?
> > 
> > Can you send any commands to the external mouse? How the touchscreen
> > reacts when the mouse starts sending 4-byte responses? 
> 
> No idea yet -- I will test this.

OK.

> > We process the external mouse packets inside lifebook.c anyway and
> > we don't have any support for the enhanced protocols there.
> 
> Ah OK. 

However, if it was possible to forward commands to the external mouse,
we could implement a full passthrough like synaptics.c has, and then
support any kind of external mouse (including wheels, bells and
whistles.)

> I personally never used an external mouse. But last weekend I played
> around a little bit and recognized that there are some BIOS-settings
> which control the behavior of the touchscreen, quickpoint-device and
> external mouse. I have to play around with those a little bit more. But
> as far as I can see you can never have all three at the same time.

That's probably because the quickpoint is connected in place of the
external mouse.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
