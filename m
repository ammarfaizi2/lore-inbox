Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVEZWGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVEZWGL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 18:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVEZWGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 18:06:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:8919 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261826AbVEZWGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 18:06:02 -0400
Date: Thu, 26 May 2005 15:06:21 -0700
From: Greg KH <greg@kroah.com>
To: Marty Leisner <leisner@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_HOTPLUG, 2.4.x and ppc
Message-ID: <20050526220621.GD19628@kroah.com>
References: <20050525042621.GB17299@kroah.com> <200505250523.j4P5N5Xo012122@hp.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505250523.j4P5N5Xo012122@hp.home>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2005 at 01:23:04AM -0400, Marty Leisner wrote:
> Its a custom chip with bridge functionality...(its not hotplug,
> but the thought was "if hotplug can add a bridge at a later time,
> so can an arbitrary module".  There's a number of minor problems
> in how BRIDGE_OTHER is handled (i.e. the first two bars should
> be filled in like any other bridge, but everything else ignored).
> 
> The goal is to add a PCI bus behind the bridge (the bios
> and the kernel doesn't know about it).   
> 
> So I'm executing the sequence to add a new bus -- which 
> needs CONFIG_HOTPLUG to export the symbols -- which causes the
> problem with PPC in the arch dependent part (it works fine
> on intel platforms).
> 
> Looking at the hotplug drivers, it looks like its tied to
> intel architectures in places...but adding a PCI bus should be
> a PCI thing...

Yes it should be a pci thing, but for 2.4, a lot of the codepaths have
not been checked to see that they are all proper for a non-intel based
system.  Your finding is one such proof :)

thanks,

greg k-h
