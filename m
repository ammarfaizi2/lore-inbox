Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbVKOQoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVKOQoK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbVKOQoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:44:10 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:12523 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S964902AbVKOQoI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:44:08 -0500
Date: Tue, 15 Nov 2005 17:43:21 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Patrick Boettcher <patrick.boettcher@desy.de>
Cc: Chris Rankin <rankincj@yahoo.com>, linux-dvb-maintainer@linuxtv.org,
       David Brigada <brigad@rpi.edu>, linux-kernel@vger.kernel.org,
       Deti Fliegl <deti@fliegl.de>
Message-ID: <20051115164321.GA4331@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Patrick Boettcher <patrick.boettcher@desy.de>,
	Chris Rankin <rankincj@yahoo.com>, linux-dvb-maintainer@linuxtv.org,
	David Brigada <brigad@rpi.edu>, linux-kernel@vger.kernel.org,
	Deti Fliegl <deti@fliegl.de>
References: <20051114235102.64514.qmail@web52912.mail.yahoo.com> <Pine.LNX.4.64.0511150939010.18517@pub3.ifh.de> <20051115152823.GA4079@linuxtv.org> <Pine.LNX.4.64.0511151633490.29360@pub3.ifh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511151633490.29360@pub3.ifh.de>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.189.250.252
Subject: Re: [linux-dvb-maintainer] Re: [OOPS] Linux 2.6.14.2 and DVB USB
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Boettcher wrote:
> On Tue, 15 Nov 2005, Johannes Stezenbach wrote:
> > Patrick Boettcher wrote:
> >>Unfortunately the dvb-core is currently not able to handle hotplugging
> >>while a dvb application is accessing a dvb-dev-node. This applies
> >>for every dvb-device, not only for dvb-usb devices, but no one ever tried
> >>to unplug a DVB PCI card while using it, yet.
> >>
> >>Before unplugging a device, you can check if the module is removable to
> >>make sure that really no application is currently using it. (You will get
> >>"module in use" then).
> >>
> >>We already thought about that problem and we think that dvbdev.c is the
> >>correct place to start implementing that, but I don't have enough
> >>knowledge (and time) to do that now, sorry.
> >
> >I thought someone sent a patch which fixes it for the cinergyT2
> >recently? Wouldn't the same approach work for dvb-usb?
> >(But I haven't had a chance to test the cinergyT2 patch yet.)
> 
> Once Deti Fliegl created that patch I had a look at it to figure out if it 
> can easily be adapted to dvb-usb. This is was my answer:
> 
> http://www.linuxtv.org/pipermail/linux-dvb/2005-October/005333.html
> 
> After that mail I had some private mails with Deti, but he is currently 
> too busy to adapt his mechanism to dvbdev.c and I'm too stupid.

The advantage of keeping development stuff on the lists is that
someone else might actually write a patch to address the issue...

> The cinergy-driver handles the frontend in a different way and that's 
> why it is possible to fix it like Deti does it.
> 
> If I could fix it in in dvb-usb, then it would be again only fixed for a 
> small amount of devices. For DVB-PCMCIA-cards using the default 
> fe-architecture will also cause Oopses like that, when unplugging while 
> having the device in use. That's why, IMHO, the dvb-core should be made 
> hotplug-safe, not a single driver. Even worse: it's not just the 
> frontend-device-nodes, but also the demux-nodes (and I think the other 
> onces too).

I agree. Could you post a summary of your conversation with Deti to
linux-dvb so someone else could start working on it?

Thanks,
Johannes
