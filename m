Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbUEBG5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUEBG5i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 02:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbUEBG40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 02:56:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:32922 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262256AbUEBG4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 02:56:22 -0400
Date: Sat, 1 May 2004 23:55:48 -0700
From: Greg KH <greg@kroah.com>
To: Kenn Humborg <kenn@linux.ie>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Platform device matching
Message-ID: <20040502065548.GH3766@kroah.com>
References: <20040425220511.GA20808@excalibur.research.wombat.ie> <20040426000050.F13748@flint.arm.linux.org.uk> <20040425231709.GA29153@excalibur.research.wombat.ie> <20040426002733.A26138@flint.arm.linux.org.uk> <20040425233510.GA30747@excalibur.research.wombat.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040425233510.GA30747@excalibur.research.wombat.ie>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 12:35:10AM +0100, Kenn Humborg wrote:
> On Mon, Apr 26, 2004 at 12:27:33AM +0100, Russell King wrote:
> > pdev->name is the platform device name, which is just the <name> part.
> > pdev->dev.bus_id is the device model name, which is <name><instance-number>,
> > and the devices are known by this name.
> > 
> > Rather than going to the trouble of parsing <name> from the device model
> > name which would be inherently buggy, we reference it directly from the
> > platform_device structure.
> 
> OK - I see it now.
> 
> > So, this comment needs updating:
> > 
> >  *      So, extract the <name> from the device, and compare it against
> >  *      the name of the driver. Return whether they match or not.
> 
> Want a patch?

Applied, thanks.

greg k-h
