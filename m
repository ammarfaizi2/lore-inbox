Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbTI0UVU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 16:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbTI0UVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 16:21:19 -0400
Received: from gprs151-62.eurotel.cz ([160.218.151.62]:30336 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262133AbTI0UVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 16:21:18 -0400
Date: Sat, 27 Sep 2003 22:19:51 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, akpm@osdl.org,
       petero2@telia.com, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] Add BTN_TOUCH to Synaptics driver. Update mousedev.
Message-ID: <20030927201951.GA401@elf.ucw.cz>
References: <10645086121286@twilight.ucw.cz> <200309251323.33416.dtor_core@ameritech.net> <20030925223032.GA32130@ucw.cz> <200309260224.54264.dtor_core@ameritech.net> <20030926075408.GA7330@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030926075408.GA7330@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > IMHO we should let input device driver explicitly request which input
> > handler it wishes to bind to (for example by passing a bitmap of desired
> > input handlers when registering input device and everyone binds to evdev). 
> > It is not as flexible as capabilities checking solution but much more 
> > simple and predictable. I do not thing that there will be that many handlers 
> > implemented...
> 
> No, it won't work. It assumes that all the handlers are known
> beforehand. Someone may want to load their own input handler module and
> it wouldn't bind to any device, because it wouldn't be on the list.
> 
> Also, we need to communicate the information not just to kernel
> handlers, but also to userspace programs/drivers ...
> 
> One thing I tried to avoid is a 'device class' kind of field, that'd
> tell if a device is a mouse a touchpad, touchscreen, tablet, whatever.
> I tried to avoid it because there are devices that don't fall into any
> predefined class and if we make enough classes, someone someday will
> make a device that won't fit again.

I believe having "is overlaid over screen" bit gets it right :-).

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
