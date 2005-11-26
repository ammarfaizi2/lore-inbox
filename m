Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVKZTZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVKZTZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 14:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVKZTZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 14:25:57 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20155 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750721AbVKZTZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 14:25:56 -0500
Date: Sat, 26 Nov 2005 20:24:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: David Vrabel <dvrabel@cantab.net>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, dkrivoschokov@dev.rtsoft.ru
Subject: Re: pxa27x_udc -- support for usb gadget for pxa27x?
Message-ID: <20051126192436.GC17663@elf.ucw.cz>
References: <20051103221402.GA28206@elf.ucw.cz> <1131057308.8523.92.camel@localhost.localdomain> <20051106204506.GH29901@elf.ucw.cz> <436F2BB2.3040008@cantab.net> <1131360232.8375.50.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131360232.8375.50.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Pavel Machek wrote:
> > > 
> > > ...for the spitz. Do you think I can just copy this one? ...eh, no,
> > > will not fly, there's no SPITZ_GPIO_USB_PULLUP.
> > 
> > There are internal pull-ups (and pull-downs) perhaps you can use those?
> > 
> > Hmmm. Though the C5 stepping might be different -- best to check the
> > "specification update".
> 
> I can confirm that you'll need to use the internal pxa27x pullups
> for

How can I use pxa27x pullups?

> this. You'll probably also need to make sure GPIO 35 is low to ensure
> the usb Vcc line isn't powered (as it would be in usb host mode.

Are you sure? spitz_ohci_init() seems to play with GPIO 37.

(Perhaps spitz_ohci_init should disable the other GPIO?)

> Ultimately, it would be nice to have the Zaurus detect whether a usb
> host or client was present (using gpio 41 maybe?) and then activate the
> host (ohci) or client (pxa27x_udc) driver as appropriate.

Unfortunately, that would make ohci unfunctional for me. I have normal
usb device cable, connected to "USB gender changer" -- basically two
female connectors -- so that I can plug USB network card into that.

								Pavel

-- 
Thanks, Sharp!
