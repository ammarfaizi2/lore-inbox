Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbVKWIr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbVKWIr5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 03:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbVKWIr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 03:47:56 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:10207 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1030370AbVKWIrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 03:47:55 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Christmas list for the kernel
Date: Wed, 23 Nov 2005 10:47:20 +0200
User-Agent: KMail/1.8.2
Cc: Kasper Sandberg <lkml@metanurb.dk>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com> <1132694935.10574.2.camel@localhost> <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com>
In-Reply-To: <9e4733910511221341u695f6765k985ecf0c54daba49@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511231047.20250.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 November 2005 23:41, Jon Smirl wrote:
> On 11/22/05, Kasper Sandberg <lkml@metanurb.dk> wrote:
> > > Currently you have to compile most of this stuff into the kernel.
> > forgive my ignorance, but whats stopping you from doing this now?
> 
> It would be better if all of the legacy drivers could exist on
> initramfs and only be loaded if the actual hardware is present. With
> the current code someone like Redhat has to compile all of the legacy
> support into their distribution kernel. That code will be present even
> on new systems that don't have the hardware.
> 
> An example of this is that the serial driver is hard coded to report
> four legacy serial ports when my system physically only has two. I
> have to change a #define and recompile the kernel to change this.

> The goal should be able to build something like Knoppix without
> Knoppix needing any device probing scripts. Linux is 90% of the way
> there but not 100% yet.
 
It's not such a pressing need IMO. This stuff works, doesn't
need a lot of maintenance, is not too big code size wise, so why
should it be converted ASAP?

As discussed on "PCI core patch" thread, getting specs from
hardware vendors for new stuff is getting harder. When one suddenly
discovers than [s]he cannot run X on shiny new notebook -
_this_ is a serious problem.

> X is also part of the problem. Even if the kernel nicely identifies
> all of the video hardware and input devices, X ignores this info and
> looks for everything again anyway. In a more friendly system X would
> use the info the kernel provides and automatically configure itself
> for the devices present or hotplugged. You could get rid of your
> xorg.cong file in this model.
--
vda
