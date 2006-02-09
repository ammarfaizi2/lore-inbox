Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422748AbWBIQjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422748AbWBIQjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 11:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422764AbWBIQjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 11:39:18 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:38080 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1422748AbWBIQjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 11:39:17 -0500
Date: Thu, 09 Feb 2006 11:31:12 -0500
From: Jon Ringle <jringle@vertical.com>
Subject: Re: Linux running on a PCI Option device?
In-reply-to: <43EAE4AC.6070807@snapgear.com>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <200602091131.12535.jringle@vertical.com>
Organization: Vertical
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <43EAE4AC.6070807@snapgear.com>
User-Agent: KMail/1.8.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 February 2006 01:43 am, Greg Ungerer wrote:
> Hi Jon,
>
> Jon Ringle wrote:
> > I am working on a new board that will have Linux running on an xscale
> > processor. This board will be a PCI Option device. I currently have a
> > IXDP465 eval board which has a PCI Option connector that I will use for
> > prototyping. From what I can tell so far, Linux wants to scan the PCI bus
> > for devices as if it is the PCI host. Is there any provision in Linux so
> > that it can take on the role of a PCI option rather than a PCI host?
>
> Have a look at the code in arch/arm/mach-ixp4xx/common-pci.c, in
> the function ixp4xx_pci_preinit().
>
> It does a check on whether the PCI bus is configured as HOST or not.
> I don't know if that code support is enough for it all to work right
> though (I certainly haven't tried it on either the 425 or 465...)

Something that I don't quite understand is how I'm supposed to make vendor Id 
information available to the PCI host. Any ideas there?

TIA,

Jon
