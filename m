Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbUEDWvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbUEDWvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 18:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUEDWvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 18:51:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:30866 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261440AbUEDWvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 18:51:03 -0400
Date: Tue, 4 May 2004 15:35:50 -0700
From: Greg KH <greg@kroah.com>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: Load hid.o module synchronously?
Message-ID: <20040504223550.GA32155@kroah.com>
References: <s5g8ygi4l3q.fsf@patl=users.sf.net> <408D65A7.7060207@nortelnetworks.com> <s5gisfm34kq.fsf@patl=users.sf.net> <c6od9g$53k$1@gatekeeper.tmr.com> <s5ghdv0i8w4.fsf@patl=users.sf.net> <20040504200147.GA26579@kroah.com> <s5ghduvdg1u.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ghduvdg1u.fsf@patl=users.sf.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 05:56:48PM -0400, Patrick J. LoPresti wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Sat, May 01, 2004 at 09:21:31AM -0400, Patrick J. LoPresti wrote:
> >
> > > So there is no way to load this hardware driver and wait until it
> > > either binds or fails to bind to its associated hardware?  That seems
> > > like a bad bug in the design...
> > 
> > Um, what is wrong with the proposals I made for how you can detect
> > this?
> 
> Your proposals were:
> 
>  - look at the device in /proc/bus/usb/devices and wait until the
>    driver is bound to that device "(hid)" will show up as the
>    driver bound to that interface
> 
>  - look at the sysfs directory for the hid driver and wait for
>    the symlink to the device shows up.  This should be at
>    /sys/bus/usb/drivers/hid
> 
> I see how these let me wait until the hid.o module successfully binds
> to the hardware.
> 
> But what if it fails to bind?  For example, what if an error occurs?
> Or what if the keyboard is on the module's blacklist?  How do I know
> when to stop waiting?

You do not, sorry.

> Ideally, what I would like is for "modprobe <driver>" to wait until
> all hardware handled by that driver is either ready for use or is
> never going to be.  That seems simple and natural to me.

Sorry, but this is not going to happen.  It does not fit into the way
the kernel handles drivers anymore.  Again, sorry.

greg k-h
