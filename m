Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVCNQnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVCNQnP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 11:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVCNQnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 11:43:14 -0500
Received: from styx.suse.cz ([82.119.242.94]:19181 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261566AbVCNQnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 11:43:03 -0500
Date: Mon, 14 Mar 2005 17:43:42 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mouse&keyboard with 2.6.10+
Message-ID: <20050314164342.GA1735@ucw.cz>
References: <4235683E.1020403@tls.msk.ru> <42357AE0.4050805@tls.msk.ru> <20050314142847.GA4001@ucw.cz> <4235B367.3000506@tls.msk.ru> <20050314162537.GA2716@ucw.cz> <4235BDFD.1070505@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4235BDFD.1070505@tls.msk.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 07:38:21PM +0300, Michael Tokarev wrote:

> >>>Can you try 'usb-handoff' on the kernel command line?
> >>
> >>The problem has nothing to do with USB per se, as far as I can see.
> >>PS2 keyboard and mouse does not work when the USB subsystem (incl.
> >>usbcore) is not loaded.  And the problem is with PS2 keyboard/mouse,
> >>not with USB one which works just fine.
> > 
> >Of course. Nevertheless 'usb-handoff' tells the BIOS not to meddle
> >with the PS/2 interfaces, too. 
> 
> Oh me bad, I should listen to whatever is being said, instead of doing
> my stupid guesses...  Just rebooted into 2.6.11.3 with usb-handoff and
> both the keyboard and mouse are Just Works, and psmouse driver loads
> almost immediately too.
> 
> Also, it works just fine after turning off USB Keyboard and Mouse
> support in BIOS and without usb-handoff kernel parameter.
> 
> In 2.6.9 (it works just fine too, problem happens with 2.6.10 and up
> only), there's no such parameter in drivers/pci/quirks.c.  Hmm.

Any chance the order of module loading changed between the two versions?
I see you have 'psmouse' as a module. If i8042 (and psmouse) are loaded
after uhci-hcd (or ohci-hcd), the problem will disappear, too.

> So is this a bios/mobo problem,

Yes.

> or can it be solved in kernel somehow?

We could have usb-handoff by default.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
