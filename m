Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbTLKOwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 09:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265066AbTLKOwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 09:52:54 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:63655 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S265079AbTLKOwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 09:52:50 -0500
Subject: Re: PPP over ttyUSB (visor.o, Treo)
From: Stian Jordet <liste@jordet.nu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1071152620.753.1.camel@chevrolet.hybel>
References: <20031210165540.B26394@fi.muni.cz>
	 <20031210212807.GA8784@kroah.com> <1071105744.1154.1.camel@chevrolet.hybel>
	 <1071114290.750.18.camel@chevrolet.hybel> <20031211064441.GA2529@kroah.com>
	 <1071152620.753.1.camel@chevrolet.hybel>
Content-Type: text/plain
Message-Id: <1071154385.721.1.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Dec 2003 15:53:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 11.12.2003 kl. 15.23 skrev Stian Jordet:
> tor, 11.12.2003 kl. 07.44 skrev Greg KH:
> > On Thu, Dec 11, 2003 at 04:44:50AM +0100, Stian Jordet wrote:
> > > tor, 11.12.2003 kl. 02.22 skrev Stian Jordet:
> > > > ons, 10.12.2003 kl. 22.28 skrev Greg KH:
> > > > > Can you try the patch below?  I think it will fix the problem.
> > > > 
> > > > Fixes it for me. Thanks :)
> > > > 
> > > Uhm.. I was a bit too fast. It fixed the problem, okay, but it makes the
> > > kernel spit out a lot of these messages:
> > > 
> > > 
> > > Dec 11 02:29:40 chevrolet kernel: usb 1-1: USB disconnect, address 7
> > > Dec 11 02:29:40 chevrolet kernel: hub 1-0:1.0: new USB device on port 1,
> > > assigned address 8
> > 
> > This has nothing to do with the visor or other usb-serial drivers.  It
> > looks like you have either a flaky USB connection, or a power issue on
> > your USB hub.  Either way, the device keeps disconnecting itself
> > electronically (nothing Linux can do about that) and then reconnecting
> > itself.  Not good.
> > 
> > Is this connected to a powered hub?  If not, I'd recommend using one, or
> > getting a new keyboard/mouse as this is on the fritz.
> 
> It isn't connected to a hub at all. I have never had any usb problems,
> before I tried this patch. Now it's unusable :( What ever is the cause,
> the patch triggers it. 

I just tried 2.4.24-pre1, and I have the same behaviour, so I guess
either the ftdi_sio or my mouse is b0rked. Weird, though, since they are
connected on two different buses, and I have four other usb devices
connected as well, without problem.

Best regards,
Stian

