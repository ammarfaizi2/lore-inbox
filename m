Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267976AbTBXFqH>; Mon, 24 Feb 2003 00:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267989AbTBXFqH>; Mon, 24 Feb 2003 00:46:07 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:53517 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267976AbTBXFqH>;
	Mon, 24 Feb 2003 00:46:07 -0500
Date: Sun, 23 Feb 2003 21:48:31 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Make hot unplugging of PCI buses work
Message-ID: <20030224054830.GA31528@kroah.com>
References: <20030223173441.D20405@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030223173441.D20405@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 05:34:41PM +0000, Russell King wrote:
> 
> Currently, we do not have a way to tell the PCI subsystem "this device
> has gone, as have all its children" without manually walking the device
> tree.  I suspect real docking stations will require this same
> functionality.

Yeah, the pci hotplug driver all implemented their own code to do this,
it's much smarter to put this in the core like you just did.

> Furthermore, I propose that pci_remove_device() shall disappear -
> and this devices makes it so (thereby breaking existing hotplug
> drivers.)

I like the patch, nice job.  If you don't mind, I'll add it to my tree,
fix up all of the pci hotplug drivers, and then send all of that off to
Linus.  Is that ok?

thanks,

greg k-h
