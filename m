Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267168AbSKUXct>; Thu, 21 Nov 2002 18:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267184AbSKUXct>; Thu, 21 Nov 2002 18:32:49 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:18423 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S267168AbSKUXcs>;
	Thu, 21 Nov 2002 18:32:48 -0500
Date: Thu, 21 Nov 2002 18:39:50 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Neil Cafferkey <caffer@cs.ucc.ie>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Setting MAC address in ewrk3 driver
Message-ID: <20021121233950.GB4654@www.kroptech.com>
References: <20021121195417.A18859@cuc.ucc.ie> <1037914095.9122.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037914095.9122.0.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 09:28:15PM +0000, Alan Cox wrote:
> On Thu, 2002-11-21 at 19:54, Neil Cafferkey wrote:
> > Hi,
> > 
> > I think I may have found a bug in the ewrk3 network driver. When I try to
> > change the MAC address of a Digital DE205 NIC using "ifconfig eth0 hw
> > ether XX:XX:XX:XX:XX:XX", it appears to work ("ifconfig eth0" reports the
> > new address), but in fact it isn't sending or receiving packets any more.
> > I'm using kernel version 2.4.10.
> 
> The default handler assumes the card mac address is set by the "up"
> method. That driver is old enough it may not do so.

Alan, could you clarify for me? I'm the last guy to diddle with ewrk3 so
I'll track this down if there is indeed something to track down. ewrk3
has a private ioctl for setting the mac address. By the "up" method do
you mean the etherdev open method? Should there be a standard ioctl
implemented for setting the mac address?

--Adam

