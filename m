Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261190AbREQGIX>; Thu, 17 May 2001 02:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261212AbREQGIO>; Thu, 17 May 2001 02:08:14 -0400
Received: from snowbird.megapath.net ([216.200.176.7]:51723 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S261190AbREQGH6>;
	Thu, 17 May 2001 02:07:58 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
From: Miles Lane <miles@megapathdsl.net>
To: Tim Jansen <tim@tjansen.de>
Cc: David Brownell <david-b@pacbell.net>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <01051601562302.01000@cookie>
In-Reply-To: <047801c0dd95$231331e0$6800000a@brownell.org> 
	<01051601562302.01000@cookie>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 16 May 2001 23:12:41 -0700
Message-Id: <990079966.25105.1.camel@agate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 May 2001 01:56:23 +0200, Tim Jansen wrote:
> On Wednesday 16 May 2001 01:16, David Brownell wrote:
> >Only if it's augmented by additional device IDs, such as the
> >"what 's the physical connection for this interface" sort of
> >primitive that's been mentioned.
> >[...]
> > I suppose that for network interface names, some convention for
> > interface ioctls would suffice to solve that "identify" step.  PCI
> > devices would return the slot_name, USB devices need something
> > like a patch I posted to linux-usb-devel a few months back.
> 
> At this point of the discussion I would like to point to the Device Registry 
> patch (http://www.tjansen.de/devreg) that already solves these problems and 
> offers stable device ids for the identification of devices and finding their 
> /dev nodes.
> 
> The devreg device id has four components: the bus identifier, the location of 
> the device (for pci bus number and slot number, for usb the bus number and a 
> list of port numbers), a model (product and device id) and, if available, a 
> serial number. 
> With the matching algorithm from the libdevreg library you can correctly 
> identifiy after a hotplug action or reboot
> - each device that has a serial numberas most of the better USB devices do, 
> even if it location has changed
> - a device without a serial number whose location has not changed
> 
> If you have a device without serial number and you changed its location the 
> device id can be used for a guess that is correct as long as you dont have 
> two devices of the same kind (same product and vendor ids). 

Hmm.  It's interesting to me that there have been no replies discussing
Tim's code.  Are any of you looking at it or do you simply think it is
inconsequential and deserves to be ignored?
Or, perhaps folks feel that it is off-topic?

Since, as Alan mentioned, the lack of device serial numbers for USB mice
and keyboards means that the only way to implement a relatively stable
assignment of USB input devices to a quasi-multiuser system with 
multi-headed displays is by paying attention to USB topology, I would
like us to explore any implementation that includes this support.  As
Linus mentioned, this approach is unreliable, but it's all we have for
these devices -- Topology can be disturbed by a variety of events
(plugging a hub into a different host-controller port, etc).  

	Miles

