Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262781AbVA1WwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbVA1WwN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 17:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbVA1WwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 17:52:13 -0500
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:58264 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S262781AbVA1WwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 17:52:08 -0500
Date: Fri, 28 Jan 2005 17:47:52 -0500
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: PNP and bus association
Message-ID: <20050128224752.GA2545@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <41F95A42.40001@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F95A42.40001@drzeus.cx>
User-Agent: Mutt/1.5.6+20040907i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

The platform bus does not show the actual physical relationship either.  For
x86, ACPI is typically needed to determine this. It would be easy to bind to
spawn pnp devices off of an ISA bridge device, attached to the pci bus, but
whether it's the actual physical parent would be very difficult to determine
without firmware assistance.

At the moment the pnp bus is only showing a logical bus relationship.  If we
were to use ACPI to aid in the generation of the physical device tree, we
could put these devices in the correct physical location.

Thanks,
Adam


On Thu, Jan 27, 2005 at 10:16:50PM +0100, Pierre Ossman wrote:
> I recently tried out adding PNP support to my driver to remove the 
> hassle of finding the correct parameters for it. This, however, causes 
> it to show up under the pnp bus, where as it previously was located 
> under the platform bus.
> 
> Is the idea that PNP devices should only reside on the PNP bus or is 
> there some magic available to get the device to appear on several buses? 
> It's a bit of a hassle to search in two different places in sysfs 
> depending on if PNP is used or not.
> 
> Also, the PNP bus doesn't really say that much about where the device is 
> physically connected. The other bus types usually give a hint about this.

It's normal for ISA devices to not tell us much about their physical
properties.

> 
> Rgds
> Pierre
> -
