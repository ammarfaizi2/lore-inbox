Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbSKNS1t>; Thu, 14 Nov 2002 13:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSKNS1t>; Thu, 14 Nov 2002 13:27:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3588 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261559AbSKNS1r>;
	Thu, 14 Nov 2002 13:27:47 -0500
Date: Thu, 14 Nov 2002 18:34:41 +0000
From: Matthew Wilcox <willy@debian.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] eliminate pci_dev name
Message-ID: <20021114183441.D30392@parcelfarce.linux.theplanet.co.uk>
References: <20021114171017.B30392@parcelfarce.linux.theplanet.co.uk> <3DD3EB3D.8050606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DD3EB3D.8050606@pobox.com>; from jgarzik@pobox.com on Thu, Nov 14, 2002 at 01:28:13PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 01:28:13PM -0500, Jeff Garzik wrote:
> Patch looks pretty good to me... seems like the obvious (and useful) 
> cleanup.
> 
> You should increase DEVICE_NAME_SIZE in include/linux/device.h from 80 
> to 90, though.  I assume you don't want to take the other option, which 
> is to audit every use and all the id strings to make sure they're short 
> enough.  In fact, IIRC, device name increased in size due to some really 
> long PCI names, so I think '90' will wind up the preferred value in any 
> case.

I didn't break anything that wasn't already broken.

-		strcpy(dev->dev.name, dev->name);

Who wants a smack?

-- 
Revolutions do not require corporate support.
