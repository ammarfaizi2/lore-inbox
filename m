Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbTFQUGi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbTFQUGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:06:36 -0400
Received: from ida.rowland.org ([192.131.102.52]:13828 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264918AbTFQUGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:06:33 -0400
Date: Tue, 17 Jun 2003 16:20:29 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>
cc: Patrick Mochel <mochel@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
In-Reply-To: <20030617173343.GB3841@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0306171602260.5972-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jun 2003, Greg KH wrote:

> > How about creating a /sys/class/usb/usb-storage/ directory, under which
> > there could be a directory for each USB mass-storage device?  Or would it 
> > be better to create a usb-storage.# directory under the interface's 
> > directory in /sys/devices/ ?
> 
> class/usb-storage/ would be fine with me.
> 
> > It's worth pointing out that both the OHCI and EHCI drivers also do the
> > same wrong thing.  They create their attribute files in a directory
> > owned by the PCI driver.
> 
> Yup, you are correct, time to add class/usb-host/ :)

By the time we're done, there will be /sys/class/drivertype for every
driver in the system!

Seriously, do you think /sys/class/usb-storage is really appropriate?  It 
would be like creating /sys/class/ide-devices.  Wouldn't something under 
/sys/class/usb/ be better, say /sys/class/usb/mass-storage/ ?

Or would it be still better simply to create something like 
/sys/devices/pci0/0000:00:07.2/usb1/1-1/1-1:0/storage/ ?  A little 
confusing perhaps, because it would refer to the same physical device as 
its parent, but not inappropriate.

Alan Stern

