Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVLKTnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVLKTnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbVLKTnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:43:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:15540 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750831AbVLKTnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:43:07 -0500
Date: Sun, 11 Dec 2005 11:42:28 -0800
From: Greg KH <greg@kroah.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ashutosh Naik <ashutosh.naik@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [BUG] Early Kernel Panic with 2.6.15-rc5
Message-ID: <20051211194228.GA11766@kroah.com>
References: <81083a450512102211r608cee8wc16cc19565a1488f@mail.gmail.com> <81083a450512102226q1443f09bof0d3ba2bd5a1be2@mail.gmail.com> <20051211063522.GA23621@kroah.com> <81083a450512102249u308ebdbcla9594f8fa57d283f@mail.gmail.com> <20051211192057.GB11450@kroah.com> <1134329818.6019.27.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134329818.6019.27.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 02:36:57PM -0500, Lee Revell wrote:
> On Sun, 2005-12-11 at 11:20 -0800, Greg KH wrote:
> > On Sun, Dec 11, 2005 at 12:19:39PM +0530, Ashutosh Naik wrote:
> > > On 12/11/05, Greg KH <greg@kroah.com> wrote:
> > > > On Sun, Dec 11, 2005 at 11:56:08AM +0530, Ashutosh Naik wrote:
> > > > > CONFIG_HOTPLUG_PCI_PCIE=y
> > > >
> > > > Change this to "m" or "n" and the oops should go away.  It's a known
> > > > problem that is being worked on, but will probably take a while to get
> > > > done.
> > > >
> > > > Do you really have a pci express hotplug controller on this machine?
> > > 
> > > Yeh, the Oops went away when I did  CONFIG_HOTPLUG_PCI_PCIE=n.
> > > 
> > > If its a known bug and will take a while to get done, maybe the
> > > feature should not be included in 2.6.15 ( if it is not fixed until
> > > then). Because a release kernel should theoretically never break. What
> > > say?
> > 
> > As no distro will build their kernel with that option=y, and it is now
> > documented in the archives that there's an error there, I don't want to
> > really rip out all of those files :)
> > 
> > Hm, wonder if we can just force the option to be either N or M.  I don't
> > see an easy way to do that in the config system, anyone else know how?
> 
> Um, isn't this what BROKEN is for?

No, the code works just fine if built as a module.  Just building into
the kernel is when problems happen at init time.

thanks,

greg k-h
