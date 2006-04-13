Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWDMQIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWDMQIJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWDMQII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:08:08 -0400
Received: from lixom.net ([66.141.50.11]:5283 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1751046AbWDMQIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:08:07 -0400
Date: Thu, 13 Apr 2006 11:07:12 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Olof Johansson <olof@lixom.net>,
       paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB, V2
Message-ID: <20060413160712.GG24769@pb15.lixom.net>
References: <20060413020559.GC24769@pb15.lixom.net> <20060413022809.GD24769@pb15.lixom.net> <20060413025233.GE24769@pb15.lixom.net> <20060413064027.GH10412@granada.merseine.nu> <1144925149.4935.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144925149.4935.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 08:45:49PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2006-04-13 at 09:40 +0300, Muli Ben-Yehuda wrote:
> > On Wed, Apr 12, 2006 at 09:52:33PM -0500, Olof Johansson wrote:
> > 
> > > iommu=off can still be used for those who don't want to deal with the
> > > overhead (and don't need it for any devices).
> > 
> > I've been pondering walking the PCI bus before deciding to enable an
> > IOMMU and checking each device's DMA mask. Is this something that you
> > considered and rejected, or just something no one got around to doing?
> 
> It would do the trick for airport cards in G5s.. a little bit of OF
> walking to find the card.

Walking the DT means we need to hardcode it on PCI IDs, since the Apple
OF doesn't give the Airport device a logical name. It's probably easier
to implement than walking PCI, but we'd need to maintain a table. My
vote is for PCI walking, I'll give that a shot over the weekend.

> It won't help with cardbus broadcom's but then, there is currently no G5
> with a cardbus adaptor that I know of :) It's possible I suppose to get
> a pci<->cardbus adapter but I suppose in that case, we can ignore it ...

Yep, that should be rare enough.

-Olof
