Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbTIEVfS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 17:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbTIEVfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 17:35:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:32643 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262780AbTIEVfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 17:35:10 -0400
Date: Fri, 5 Sep 2003 14:35:28 -0700
From: Greg KH <greg@kroah.com>
To: Momes <momes@mundo-r.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB hang
Message-ID: <20030905213528.GA13018@kroah.com>
References: <200309041951.37523.momes@mundo-r.com> <20030905160815.GA1946@kroah.com> <200309052332.10022.momes@mundo-r.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309052332.10022.momes@mundo-r.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 11:32:09PM +0200, Momes wrote:
> On Friday 05 September 2003 18:08, Greg KH wrote:
> > On Thu, Sep 04, 2003 at 07:51:37PM +0200, Momes wrote:
> > > Hello:
> > > I'm trying to compile new kernel 2.4.22 (with XFS patch) in my machine.
> > > The problem is that it always hangs when I plug in my USB keyboard.
> > > My system needs "noapic" option in lilo.conf but it has always worked
> > > fined up to kernel 2.4.21. I've searched the archives and also used
> > > Google without found any answer, so decided to post my problem in the
> > > list with the hope that someone can give some clue.
> > >
> > > The system always stops at this point:
> > >
> > > "input: USB HID v1.00 Keyboard [BTC USB Keyboard] on usb2:3.0"
> >
> > If you boot without any USB devices plugged in, and then plug them in
> > after boot, do you still have this problem?
> >
> > And does this happen without the XFS patch?
> >
> > thanks,
> >
> > greg k-h
> > -
> 
> 
> When system boots with no  USB device plugged in everything works OK until
> the moment I plug a USB device. In that very moment the system freezes with 
> message
> 
> "input: USB HID v1.00 Keyboard [BTC USB Keyboard] on usb2:3.0"
> 
> as reported before.
> As you suggested I've also tried the vanila kernel without the XFS patch 
> without any difference. System remains hanging.
> 
> Any idea?

Can you enable CONFIG_USB_DEBUG and see if anything interesting happens
in your logs?  Also if you could see where the machine hangs by possibly
using the nmi watchdog that would be really helpful.

What about if you boot without the noapic option?

thanks,

greg k-h
