Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbUCDS15 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 13:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbUCDS15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 13:27:57 -0500
Received: from mail.kroah.org ([65.200.24.183]:53394 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262064AbUCDS1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 13:27:54 -0500
Date: Thu, 4 Mar 2004 10:26:45 -0800
From: Greg KH <greg@kroah.com>
To: Michael Weiser <michael@weiser.dinsnail.net>, Ed Tomlinson <edt@aei.ca>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040304182643.GD13907@kroah.com>
References: <20040303225305.GB30608@weiser.dinsnail.net> <20040304012531.GC2207@kroah.com> <20040304035856.GA31986@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040304035856.GA31986@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 10:58:56PM -0500, Bill Nottingham wrote:
> Greg KH (greg@kroah.com) said: 
> > Sorry, but you're a bit late.  We've been moving this way since before
> > 2.4.0.
> > 
> > The fact that module unload even works today is a blessing due to all of
> > the well-documented issues involved.  I doubt any distro will enable
> > module unloading because of it.
> 
> So, then, answer this question. In previous kernels, 2.4 and otherwise,
> a driver or piece of hardware may get into a 'confused' state. You unload
> the driver, reload it, it resets, everything is peachy.
> 
> How do I reinitialize a driver or hardware in your 'no-unload'
> scenario?

Disconnect the hardware device.  Oh, you don't have a PCI hotplug
system, well get one :)

Seriously, sure, try to unload the module.  But please refer to all of
the different threads on lkml during the 2.5 development cycle about
module unloading.  Also note the way that module unloading might be done
in 2.7 (by keeping the old memory around, and never freeing it...)

Also realize that it's better to fix the driver in a situation like you
mention.  Unloading the driver is often times not a viable solution for
a lot of people (like if your scsi driver is also the one holding your
root disk...)

thanks,

greg k-h
