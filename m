Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318310AbSGRTEd>; Thu, 18 Jul 2002 15:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318313AbSGRTEd>; Thu, 18 Jul 2002 15:04:33 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:42475 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318310AbSGRTEc>; Thu, 18 Jul 2002 15:04:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@wanadoo.fr>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.5.26 hotplug failure
Date: Thu, 18 Jul 2002 21:07:23 +0200
User-Agent: KMail/1.4.2
Cc: linux-kernel@vger.kernel.org
References: <200207180950.42312.duncan.sands@wanadoo.fr> <20020718183617.GI15529@kroah.com>
In-Reply-To: <20020718183617.GI15529@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207182107.23947.duncan.sands@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 20:36, Greg KH wrote:
> On Thu, Jul 18, 2002 at 09:50:42AM +0200, Duncan Sands wrote:
> > I just gave 2.5.26 a whirl.  The first thing I noticed was
> > that the hotplug system didn't run the script for my usb
> > modem...
> >
> > kernel: usb.c: USB disconnect on device 2
> > kernel: hub.c: new USB device 00:0b.0-2, assigned address 4
> > kernel: usb.c: USB device 4 (vend/prod 0x6b9/0x4061) is not claimed by
> > any active driver. /etc/hotplug/usb.agent: ... no modules for USB product
> > 6b9/4061/0
> >
> > however this works just fine with 2.4.19-rc1 and 2.5.24 (i.e. only
> > difference is the change in kernel)...
>
> But that message is from the hotplug agent, right?

Yup, which normally (using the product id etc) works out that it needs
to run "the script for my usb modem".

> What kind of script used to get run, and how was it run (i.e. on network
> interface registration, etc.)

It was run by the hotplug system - it uploads firmware then launches the
internet connection.  The hotplug script knows to run it by looking up the
vendor/product id in a list.  Doesn't info get passed to the hotplut script via
environment variables?  Maybe they are not getting set up right...

I'm leaving now for one month so I'm afraid it will be a while until I'll
next be able to look at this...

Ciao,

Duncan.
