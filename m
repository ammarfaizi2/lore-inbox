Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261844AbSKCMGG>; Sun, 3 Nov 2002 07:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261845AbSKCMGG>; Sun, 3 Nov 2002 07:06:06 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:18572 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261844AbSKCMGF>; Sun, 3 Nov 2002 07:06:05 -0500
Subject: Re: Patch: linux-2.5.45/drivers/base/bus.c - new field to
	consolidate memory allocation in many drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: Greg KH <greg@kroah.com>, mochel@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021102234537.A335@baldur.yggdrasil.com>
References: <20021102112951.A6910@adam.yggdrasil.com>
	<20021102204258.GA22607@kroah.com> 
	<20021102234537.A335@baldur.yggdrasil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 12:33:44 +0000
Message-Id: <1036326824.29646.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 07:45, Adam J. Richter wrote:
> 	Note that because struct net_device may need to persist after
> ->remove() returns, I had to make a net_device.destructor function
> (sharable with all similar network device drivers) rather than allow
> drivers/base/bus.c to do the kfree.  If the same turns out to be true
> for Scsi_Host, gendisk, etc., then I will scrap the kfree part of my
> proposal.

It is certainly true for scsi devices, it will be true (once I get
around to it) for IDE devices

