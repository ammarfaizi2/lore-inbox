Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVGLOtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVGLOtf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVGLOsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:48:05 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:25615 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261510AbVGLOrn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:47:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S4xB0bhh4kJFKZ2+6h8Qlr9l9LuHtBBqSdEBsLsc0lHoefcMoz6+aQXnPDHOS/Ty/18/wj8nF1Tl1RPfTWhEOawccQukuVqH3cHb+vnszjKZSsCNE70rScgamzE1lRzaQbf04U2mlqzUdBKvX58RvOxfGoQf5Wd+vdrV9dQpTms=
Message-ID: <d120d5000507120747692ffc7@mail.gmail.com>
Date: Tue, 12 Jul 2005 09:47:16 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Stelian Pop <stelian@popies.net>
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
Cc: Vojtech Pavlik <vojtech@suse.cz>, Peter Osterlund <petero2@telia.com>,
       Andrew Morton <akpm@osdl.org>,
       Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
In-Reply-To: <1121178794.4648.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20050708101731.GM18608@sd291.sivit.org>
	 <20050710120425.GC3018@ucw.cz> <m3y88e9ozu.fsf@telia.com>
	 <1121078371.12621.36.camel@localhost.localdomain>
	 <20050711110024.GA23333@ucw.cz>
	 <1121080115.12627.44.camel@localhost.localdomain>
	 <20050711112121.GA24345@ucw.cz>
	 <1121159126.4656.14.camel@localhost.localdomain>
	 <d120d5000507120713646089ee@mail.gmail.com>
	 <1121178794.4648.31.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/05, Stelian Pop <stelian@popies.net> wrote:
> Le mardi 12 juillet 2005 à 09:13 -0500, Dmitry Torokhov a écrit :
> > Hi,
> >
> > On 7/12/05, Stelian Pop <stelian@popies.net> wrote:
> > >
> > > +       dev->input.id.bustype = BUS_USB;
> > > +       dev->input.id.vendor = id->idVendor;
> > > +       dev->input.id.product = id->idProduct;
> > > +       dev->input.id.version = ATP_DRIVER_VERSION;
> > > +
> >
> > Why don't we do what most of the other input devices and get version
> > from the device too?
> 
> I guess we could, there is not much use for a local driver version
> anyway.
> 
> > Actually we have this in input tree:
> >
> > static inline void
> > usb_to_input_id(const struct usb_device *dev, struct input_id *id)
> 
> This cleans up a lot of code indeed. Too bad this is not upstream yet...
> 

It is in -mm (it is coming from git-input patch).

-- 
Dmitry
