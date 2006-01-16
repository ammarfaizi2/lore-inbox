Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWAPKoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWAPKoW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 05:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWAPKoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 05:44:22 -0500
Received: from styx.suse.cz ([82.119.242.94]:5862 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750891AbWAPKoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 05:44:21 -0500
Date: Mon, 16 Jan 2006 11:44:16 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Olaf Hering <olh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Input: HID - add support for fn key on Apple PowerBooks
Message-ID: <20060116104416.GA23413@suse.cz>
References: <200601141910.k0EJAm65013553@hera.kernel.org> <20060116103341.GA4809@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116103341.GA4809@suse.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 11:33:41AM +0100, Olaf Hering wrote:

> > diff --git a/drivers/usb/input/Kconfig b/drivers/usb/input/Kconfig
> > index 509dd0a..5246b35 100644
> > --- a/drivers/usb/input/Kconfig
> > +++ b/drivers/usb/input/Kconfig
> > @@ -37,6 +37,16 @@ config USB_HIDINPUT
> >  
> >  	  If unsure, say Y.
> >  
> > +config USB_HIDINPUT_POWERBOOK
> > +	bool "Enable support for iBook/PowerBook special keys"
> > +	default n
> > +	depends on USB_HIDINPUT
> > +	help
> > +	  Say Y here if you want support for the special keys (Fn, Numlock) on
> > +	  Apple iBooks and PowerBooks.
> 
> Should this depend on CONFIG_$powerbook?
 
It could, but will still compile and not cause any trouble on
non-powerbooks, so there isn't much reason to restrict it.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
