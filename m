Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVKNWoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVKNWoe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 17:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVKNWoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 17:44:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:9879 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932196AbVKNWod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 17:44:33 -0500
Date: Mon, 14 Nov 2005 14:31:05 -0800
From: Greg KH <greg@kroah.com>
To: Doug Thompson <norsk5@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] EDAC and the sysfs
Message-ID: <20051114223105.GA5868@kroah.com>
References: <20051114221419.10324.qmail@web50101.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114221419.10324.qmail@web50101.mail.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 02:14:19PM -0800, Doug Thompson wrote:
> 
> I am trying to design the sysfs interface tree for the
> new set of EDAC modules that are waiting for this
> interface, before being put into the kernel.  
> 
> Currently the original EDAC (bluesmoke) has its own
> /proc directory (/proc/mc) with files and a directory
> (0,1,2,...)for each memory controller on the system.
> This will be removed and the new information interface
> will be placed in the sysfs.
> 
> One proposal is to place the information in
> /sys/devices/system in the following directories:

Why not use /sys/firmware/ instead?

Or do you want to use the struct device stuff?

> For EDAC general memory ECC controls and information
> files:
> 
>    /sys/devices/systems/edac/mc/

What kind of controls and files?

> 
> For PCI Parity Error detection controls and
> information files:
> 
>    /sys/devices/system/edac/pci

That kind of controls and  files?


> In addition /sys/devices/system/edac/mc/ would  have
> directories:
> 
> mc0/
> mc1/
> ...
> 
> for each memory controller's specific controls and
> information.

Again, what kind of controls and information?

> Currently the similiar error detection device
> /sys/devices/system/machinecheck resides here are
> well.
> 
> 
> The alternative layout would be to use the /sys/class
> directory when nested-classes become available:

They are in 2.6.15-rc1, but you _really_ don't want to use them, they
are a huge pain, and I will be getting rid of them, along with all
struct class_device stuff in the near future.  See the archives for
details, or it's summarized here:
	http://www.kroah.com/log/linux/driver_model_changes.html


> 
> /sys/class/edac/mc/...
> 
> and
> 
> /sys/class/edac/pci/...
> 
> But edac doesn't quite seem to fit here.

I agree.

> I have failed to date to really find a policy or set
> of rules of use for the sysfs as to what goes where
> for such items as EDAC. After searching the web,
> articles and thinking about this for some time now, I
> am requesting comments on the sysfs model for where
> EDAC would fit best.

What exactly does EDAC do (and what does it stand for anyway?)

thanks,

greg k-h
