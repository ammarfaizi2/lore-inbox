Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268140AbUHKR64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268140AbUHKR64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 13:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268142AbUHKR64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 13:58:56 -0400
Received: from mail.kroah.org ([69.55.234.183]:29348 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268140AbUHKR54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 13:57:56 -0400
Date: Wed, 11 Aug 2004 10:28:00 -0700
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Martin Mares <mj@ucw.cz>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040811172800.GB14979@kroah.com>
References: <20040806211413.77833.qmail@web14926.mail.yahoo.com> <200408111004.02995.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408111004.02995.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 10:04:02AM -0700, Jesse Barnes wrote:
> On Friday, August 6, 2004 2:14 pm, Jon Smirl wrote:
> > Please check the code out and give it some testing. It will probably
> > needs some adjustment for other platforms.
> 
> Jon, this works on my machine too.  Greg, if it looks ok can you pull it in?  
> And can you add:
> 
>  * (C) Copyright 2004 Silicon Graphics, Inc.
>  *       Jesse Barnes <jbarnes@sgi.com>
> 
> to pci-sysfs.c if you do?

Care to send me a new patch?  Oh, and that copyright line needs to look
like:
* Copyright (c) 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>

to make it legal, or so my lawyers say :)

> Greg was a little worried that your comment
> 	/* .size is set individually for each device, sysfs copies it into dentry */
> might not be correct.

I looked at the code, and he's right.  But it's pretty scary that it
works correctly so I'd prefer to do it the way your patch did it (create
a new attribute for every entry.)

thnaks,

greg k-h
