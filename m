Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVLKTYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVLKTYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVLKTYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:24:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:12974 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750815AbVLKTYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:24:24 -0500
Date: Sun, 11 Dec 2005 11:20:57 -0800
From: Greg KH <greg@kroah.com>
To: Ashutosh Naik <ashutosh.naik@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BUG] Early Kernel Panic with 2.6.15-rc5
Message-ID: <20051211192057.GB11450@kroah.com>
References: <81083a450512102211r608cee8wc16cc19565a1488f@mail.gmail.com> <81083a450512102226q1443f09bof0d3ba2bd5a1be2@mail.gmail.com> <20051211063522.GA23621@kroah.com> <81083a450512102249u308ebdbcla9594f8fa57d283f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81083a450512102249u308ebdbcla9594f8fa57d283f@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 12:19:39PM +0530, Ashutosh Naik wrote:
> On 12/11/05, Greg KH <greg@kroah.com> wrote:
> > On Sun, Dec 11, 2005 at 11:56:08AM +0530, Ashutosh Naik wrote:
> > > CONFIG_HOTPLUG_PCI_PCIE=y
> >
> > Change this to "m" or "n" and the oops should go away.  It's a known
> > problem that is being worked on, but will probably take a while to get
> > done.
> >
> > Do you really have a pci express hotplug controller on this machine?
> 
> Yeh, the Oops went away when I did  CONFIG_HOTPLUG_PCI_PCIE=n.
> 
> If its a known bug and will take a while to get done, maybe the
> feature should not be included in 2.6.15 ( if it is not fixed until
> then). Because a release kernel should theoretically never break. What
> say?

As no distro will build their kernel with that option=y, and it is now
documented in the archives that there's an error there, I don't want to
really rip out all of those files :)

Hm, wonder if we can just force the option to be either N or M.  I don't
see an easy way to do that in the config system, anyone else know how?

thanks,

greg k-h
