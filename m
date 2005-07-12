Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVGLOiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVGLOiN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVGLOiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:38:08 -0400
Received: from gw.alcove.fr ([81.80.245.157]:15050 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S261458AbVGLOg2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:36:28 -0400
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
From: Stelian Pop <stelian@popies.net>
To: dtor_core@ameritech.net
Cc: Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <petero2@telia.com>,
       Andrew Morton <akpm@osdl.org>,
       Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
In-Reply-To: <d120d5000507120713646089ee@mail.gmail.com>
References: <20050708101731.GM18608@sd291.sivit.org>
	 <20050709191357.GA2244@ucw.cz> <m33bqnr3y9.fsf@telia.com>
	 <20050710120425.GC3018@ucw.cz> <m3y88e9ozu.fsf@telia.com>
	 <1121078371.12621.36.camel@localhost.localdomain>
	 <20050711110024.GA23333@ucw.cz>
	 <1121080115.12627.44.camel@localhost.localdomain>
	 <20050711112121.GA24345@ucw.cz>
	 <1121159126.4656.14.camel@localhost.localdomain>
	 <d120d5000507120713646089ee@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Tue, 12 Jul 2005 16:33:13 +0200
Message-Id: <1121178794.4648.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 12 juillet 2005 à 09:13 -0500, Dmitry Torokhov a écrit :
> Hi,
> 
> On 7/12/05, Stelian Pop <stelian@popies.net> wrote:
> >
> > +       dev->input.id.bustype = BUS_USB;
> > +       dev->input.id.vendor = id->idVendor;
> > +       dev->input.id.product = id->idProduct;
> > +       dev->input.id.version = ATP_DRIVER_VERSION;
> > +
> 
> Why don't we do what most of the other input devices and get version
> from the device too? 

I guess we could, there is not much use for a local driver version
anyway.

> Actually we have this in input tree:
> 
> static inline void
> usb_to_input_id(const struct usb_device *dev, struct input_id *id)

This cleans up a lot of code indeed. Too bad this is not upstream yet...

Stelian.
-- 
Stelian Pop <stelian@popies.net>

