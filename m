Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVGLSNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVGLSNP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 14:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVGLSNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 14:13:14 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:7854 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261904AbVGLSNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 14:13:09 -0400
Date: Tue, 12 Jul 2005 20:13:15 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stelian Pop <stelian@popies.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Peter Osterlund <petero2@telia.com>,
       Johannes Berg <johannes@sipsolutions.net>,
       Frank Arnold <frank@scirocco-5v-turbo.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
Message-ID: <20050712181315.GB1456@ucw.cz>
References: <20050710120425.GC3018@ucw.cz> <m3y88e9ozu.fsf@telia.com> <1121078371.12621.36.camel@localhost.localdomain> <20050711110024.GA23333@ucw.cz> <1121080115.12627.44.camel@localhost.localdomain> <20050711112121.GA24345@ucw.cz> <1121159126.4656.14.camel@localhost.localdomain> <d120d5000507120713646089ee@mail.gmail.com> <1121178794.4648.31.camel@localhost.localdomain> <d120d5000507120747692ffc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d120d5000507120747692ffc7@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 09:47:16AM -0500, Dmitry Torokhov wrote:
> On 7/12/05, Stelian Pop <stelian@popies.net> wrote:
> > Le mardi 12 juillet 2005 ? 09:13 -0500, Dmitry Torokhov a écrit :
> > > Hi,
> > >
> > > On 7/12/05, Stelian Pop <stelian@popies.net> wrote:
> > > >
> > > > +       dev->input.id.bustype = BUS_USB;
> > > > +       dev->input.id.vendor = id->idVendor;
> > > > +       dev->input.id.product = id->idProduct;
> > > > +       dev->input.id.version = ATP_DRIVER_VERSION;
> > > > +
> > >
> > > Why don't we do what most of the other input devices and get version
> > > from the device too?
> > 
> > I guess we could, there is not much use for a local driver version
> > anyway.
> > 
> > > Actually we have this in input tree:
> > >
> > > static inline void
> > > usb_to_input_id(const struct usb_device *dev, struct input_id *id)
> > 
> > This cleans up a lot of code indeed. Too bad this is not upstream yet...
> > 
> 
> It is in -mm (it is coming from git-input patch).
 
Stelian, can you please update the patch to use usb_to_input_id()? It'll
go through -mm first, anyway, so there shouldn't be any issue with
Linus's kernels not having that function yet.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
