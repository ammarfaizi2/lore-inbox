Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267016AbSLDSoz>; Wed, 4 Dec 2002 13:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267019AbSLDSoz>; Wed, 4 Dec 2002 13:44:55 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:9997 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267016AbSLDSoy>;
	Wed, 4 Dec 2002 13:44:54 -0500
Date: Wed, 4 Dec 2002 10:52:25 -0800
From: Greg KH <greg@kroah.com>
To: James Bottomley <James.Bottomley@SteelEye.com>, mochel@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BKPATCH] bus notifiers for the generic device model
Message-ID: <20021204185225.GB28062@kroah.com>
References: <200212041709.gB4H9LA02808@localhost.localdomain> <20021204175602.GC27780@kroah.com> <20021204181016.GB1584@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021204181016.GB1584@beaverton.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 10:10:16AM -0800, Mike Anderson wrote:
> Greg KH [greg@kroah.com] wrote:
> > On Wed, Dec 04, 2002 at 11:09:21AM -0600, James Bottomley wrote:
> > > There are certain bus types (notably MCA and parisc internal ones) that like 
> > > to do generic houskeeping operations (claim slots, claim uniform resources 
> > > etc.) when drivers are attached to devices.
> > 
> > But doesn't the bus specific core know when drivers are attached, as it
> > was told to register or unregister a specific driver?  So I don't see
> > why this is really needed.
> 
> The change is when a device is bound to a driver (i.e. when attach /
> detach is called bus.c ).

Whis is called after probe / remove is called for the driver, which can
point to the bus specific functions, like PCI and USB cores do.

thanks,

greg k-h
