Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWB1Uiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWB1Uiq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 15:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbWB1Uiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 15:38:46 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:16506 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S932487AbWB1Uip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 15:38:45 -0500
Date: Tue, 28 Feb 2006 15:35:21 -0500
From: Jon Ringle <jringle@vertical.com>
Subject: Re: Linux running on a PCI Option device?
In-reply-to: <43EAE4AC.6070807@snapgear.com>
To: Greg Ungerer <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <200602281535.21974.jringle@vertical.com>
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

When I have the IXDP465 in PCI Option mode, Linux still writes to pci 
configuration space which confuses the heck out of the PCI Host (Windows 
2003). What do I need to do in order to have Linux work as a PCI option but 
still not mess with the pci configuration, and leave that task to the PCI 
Host?

Jon
