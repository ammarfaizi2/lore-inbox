Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVCVB1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVCVB1l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 20:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVCVBZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 20:25:52 -0500
Received: from fire.osdl.org ([65.172.181.4]:14998 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262282AbVCVBYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:24:24 -0500
Date: Mon, 21 Mar 2005 17:24:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: mjt@tls.msk.ru, linux-kernel@vger.kernel.org
Subject: Re: mouse&keyboard with 2.6.10+
Message-Id: <20050321172411.247e32b6.akpm@osdl.org>
In-Reply-To: <20050314164342.GA1735@ucw.cz>
References: <4235683E.1020403@tls.msk.ru>
	<42357AE0.4050805@tls.msk.ru>
	<20050314142847.GA4001@ucw.cz>
	<4235B367.3000506@tls.msk.ru>
	<20050314162537.GA2716@ucw.cz>
	<4235BDFD.1070505@tls.msk.ru>
	<20050314164342.GA1735@ucw.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> wrote:
>
> On Mon, Mar 14, 2005 at 07:38:21PM +0300, Michael Tokarev wrote:
> 
> > >>>Can you try 'usb-handoff' on the kernel command line?
> > >>
> > >>The problem has nothing to do with USB per se, as far as I can see.
> > >>PS2 keyboard and mouse does not work when the USB subsystem (incl.
> > >>usbcore) is not loaded.  And the problem is with PS2 keyboard/mouse,
> > >>not with USB one which works just fine.
> > > 
> > >Of course. Nevertheless 'usb-handoff' tells the BIOS not to meddle
> > >with the PS/2 interfaces, too. 
> > 
> > Oh me bad, I should listen to whatever is being said, instead of doing
> > my stupid guesses...  Just rebooted into 2.6.11.3 with usb-handoff and
> > both the keyboard and mouse are Just Works, and psmouse driver loads
> > almost immediately too.
> > 
> > Also, it works just fine after turning off USB Keyboard and Mouse
> > support in BIOS and without usb-handoff kernel parameter.
> > 
> > In 2.6.9 (it works just fine too, problem happens with 2.6.10 and up
> > only), there's no such parameter in drivers/pci/quirks.c.  Hmm.
> 
> Any chance the order of module loading changed between the two versions?
> I see you have 'psmouse' as a module. If i8042 (and psmouse) are loaded
> after uhci-hcd (or ohci-hcd), the problem will disappear, too.
> 
> > So is this a bios/mobo problem,
> 
> Yes.
> 
> > or can it be solved in kernel somehow?
> 
> We could have usb-handoff by default.

Did we decide to do that?  If so, will it be in 2.6.12?
