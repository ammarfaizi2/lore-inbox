Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVH2OkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVH2OkC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 10:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVH2OkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 10:40:02 -0400
Received: from xenotime.net ([66.160.160.81]:15232 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750779AbVH2OkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 10:40:01 -0400
Date: Mon, 29 Aug 2005 07:39:58 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jan De Luyck <lkml@kcore.org>
cc: linux-kernel@vger.kernel.org,
       James Courtier-Dutton <James@superbug.demon.co.uk>,
       Dominik Wezel <dio@qwasartech.com>
Subject: Re: USB EHCI Problem with Low Speed Devices on kernel 2.6.11+
In-Reply-To: <200508290728.07102.lkml@kcore.org>
Message-ID: <Pine.LNX.4.50.0508290739180.11117-100000@shark.he.net>
References: <43106DEF.3040206@qwasartech.com> <431245E2.5010308@superbug.demon.co.uk>
 <200508290728.07102.lkml@kcore.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2005, Jan De Luyck wrote:

> On Monday 29 August 2005 01:16, James Courtier-Dutton wrote:
> > Dominik Wezel wrote:
> > > Problem
> > > =======
> > > When turning on the laptop and during POST and GrUB loading, all ports
> > > on the hub are enabled.  During the USB initialization phase, when the
> > > hub is detected, shortly all ports become disabled, then turn on again
> > > (uhci_hcd detects the lo-speed ports).  Upon initialization of ehci_hcd
> > > however, the ports are disconnected again (for good):
> >
> > Use uhci_hcd or ehci_hcd, but never both at the same time.
> > ehci_hcd will work with all lo-speed ports, so uhci_hcd is then no needed.
>
> This seems to be in contrast with what hotplug does automatically: it loads
> both ehci_hcd and uhci_hcd here. If I don't load uhci_hcd, lo-speed devices
> do not work.

Right.  EHCI is high-speed only.  It needs a companion controller
and driver for low- and full-speed devices.

-- 
~Randy
