Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWDMKt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWDMKt6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 06:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWDMKt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 06:49:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:7320 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751238AbWDMKt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 06:49:57 -0400
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to
	1GB, V2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Olof Johansson <olof@lixom.net>, paulus@samba.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060413064027.GH10412@granada.merseine.nu>
References: <20060413020559.GC24769@pb15.lixom.net>
	 <20060413022809.GD24769@pb15.lixom.net>
	 <20060413025233.GE24769@pb15.lixom.net>
	 <20060413064027.GH10412@granada.merseine.nu>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 20:45:49 +1000
Message-Id: <1144925149.4935.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 09:40 +0300, Muli Ben-Yehuda wrote:
> On Wed, Apr 12, 2006 at 09:52:33PM -0500, Olof Johansson wrote:
> 
> > iommu=off can still be used for those who don't want to deal with the
> > overhead (and don't need it for any devices).
> 
> I've been pondering walking the PCI bus before deciding to enable an
> IOMMU and checking each device's DMA mask. Is this something that you
> considered and rejected, or just something no one got around to doing?

It would do the trick for airport cards in G5s.. a little bit of OF
walking to find the card.

It won't help with cardbus broadcom's but then, there is currently no G5
with a cardbus adaptor that I know of :) It's possible I suppose to get
a pci<->cardbus adapter but I suppose in that case, we can ignore it ...

Ben.


