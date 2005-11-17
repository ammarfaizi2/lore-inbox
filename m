Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbVKQRTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVKQRTo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVKQRTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:19:44 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:16258 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932421AbVKQRTo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:19:44 -0500
Date: Thu, 17 Nov 2005 12:19:43 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <gregkh@suse.de>
cc: linux-usb-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [PATCH 02/02] USB: add dynamic id functionality
 to USB core
In-Reply-To: <20051117162533.GB26824@suse.de>
Message-ID: <Pine.LNX.4.44L0.0511171219040.5089-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2005, Greg KH wrote:

> > > +	fields = sscanf(buf, "%x %x", &idVendor, &idProduct);
> > > +	if (fields < 0)
> > > +		return -EINVAL;
> > 
> > Don't you want to test (fields < 2)?
> 
> No, it's ok to just specify the vendor, if you want a product of 0 :)
> 
> PCI does it this way too.

Well, in that case shouldn't you test (fields < 1)?

Alan Stern

