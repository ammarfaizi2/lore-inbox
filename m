Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVDYVeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVDYVeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVDYVa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:30:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:465 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261201AbVDYVSv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:18:51 -0400
Date: Mon, 25 Apr 2005 23:13:53 +0200
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: Amit Gud <gud@eth.net>, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, jgarzik@pobox.com, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
Message-ID: <20050425211353.GF3906@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org> <20050425182951.GA23209@kroah.com> <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com> <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com> <20050425204207.GA23724@elf.ucw.cz> <20050425210014.GA25247@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425210014.GA25247@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Well it seems that people are starting to want to hook the reboot
> > > notifier, or the device shutdown facility in order to properly shutdown
> > > pci drivers to make kexec work nicer.
> > > 
> > > So here's a patch for the PCI core that allows pci drivers to now just
> > > add a "shutdown" notifier function that will be called when the system
> > > is being shutdown.  It happens just after the reboot notifier happens,
> > > and it should happen in the proper device tree order, so everyone should
> > > be happy.
> > > 
> > > Any objections to this patch?
> > 
> > Yes.
> > 
> > I believe it should just do suspend(PMSG_SUSPEND) before system
> > shutdown. If you think distintion between shutdown and suspend is
> > important (I am not 100% convinced it is), we can just add flag
> > saying "this is system shutdown".
> 
> Then why even have the device_shutdown() call and notifier in the struct
> device_driver?

Yes, I guess it is redundant. Perhaps it should be removed...

									Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
