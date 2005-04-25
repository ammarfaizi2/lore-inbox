Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262790AbVDYUPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbVDYUPh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbVDYUPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:15:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:43713 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262773AbVDYUNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:13:17 -0400
Date: Mon, 25 Apr 2005 13:12:50 -0700
From: Greg KH <greg@kroah.com>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: Amit Gud <gud@eth.net>, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, jgarzik@pobox.com, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050425201250.GB24433@kroah.com>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org> <20050425182951.GA23209@kroah.com> <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com> <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com> <1114458325.983.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114458325.983.17.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 09:45:25PM +0200, Alexander Nyberg wrote:
> > Well it seems that people are starting to want to hook the reboot
> > notifier, or the device shutdown facility in order to properly shutdown
> > pci drivers to make kexec work nicer.
> > 
> > So here's a patch for the PCI core that allows pci drivers to now just
> > add a "shutdown" notifier function that will be called when the system
> > is being shutdown.  It happens just after the reboot notifier happens,
> > and it should happen in the proper device tree order, so everyone should
> > be happy.
> > 
> > Any objections to this patch?
> 
> Not sure what you mean by "make kexec work nicer" but if it is because
> some devices don't work after a kexec I have some objections.
> What about the kexec-on-panic?

People are starting to submit patches for pci drivers that add "reboot
notifier" hooks, under the guise of fixing up kexec issues with those
drivers.

That is why I proposed this patch, to make it easier for such drivers to
shutdown properly, without needing a reboot notifier hook (which takes
up more code and memory.

thanks,

greg k-h
