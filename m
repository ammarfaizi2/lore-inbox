Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbTLDAoC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 19:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTLDAoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 19:44:02 -0500
Received: from mail.kroah.org ([65.200.24.183]:41101 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262767AbTLDAn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 19:43:57 -0500
Date: Wed, 3 Dec 2003 16:24:14 -0800
From: Greg KH <greg@kroah.com>
To: "Collins, Bernard F. (Skip)" <Bernard.Collins@jhuapl.edu>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Visor USB hang
Message-ID: <20031204002414.GI21541@kroah.com>
References: <E37E01957949D611A4C30008C7E691E20915BBFC@aples3.dom1.jhuapl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E37E01957949D611A4C30008C7E691E20915BBFC@aples3.dom1.jhuapl.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 05:36:01PM -0500, Collins, Bernard F. (Skip) wrote:
> > > I am running 2.4.23 on a RedHat 9 system. Whenever I try to sync my
> > > Visor Deluxe, the system hangs/freezes soon after I press the sync 
> > > button on my cradle. Trying to find the cause of the problem, I 
> > > preloaded the usbserial and visor modules with "debug=1". Nothing 
> > > obviously wrong appears in the logs. The last message before the 
> > > system freezes is a usb-uhci.c interrupt message.
> > 
> > Can you show the log with that enabled?
> 
> If you mean debug=1 enabled, the log excerpt I posted was generated with
> both the usbserial and visor modules modprobed with debug=1. Perhaps I am
> mistaken in assuming that my approach actually enables debugging. I
> modprobed both modules and hit the hotsync button. I am assuming that
> hotplug does not override the manually loaded module parameters. 

but then no user program tried to talk to the device.  I don't see any
accesses to the device in your logs.  Any oops messages?

> > What happens if you use the uhci.o module instead of usb-uhci.o?
> 
> That is not terribly convenient to test right now. Can you suggest a simple
> way to unload usb-uhci and load uhci without disabling my usb keyboard and
> mouse?

	rmmod usb-uhci && modprobe uhci

thanks,

greg k-h
