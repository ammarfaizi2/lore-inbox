Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbTJNAjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 20:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTJNAjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 20:39:15 -0400
Received: from mail.kroah.org ([65.200.24.183]:31134 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262117AbTJNAjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 20:39:12 -0400
Date: Mon, 13 Oct 2003 16:56:23 -0700
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input hotplug support
Message-ID: <20031013235623.GA12898@kroah.com>
References: <200308020139.37446.arvidjaar@mail.ru> <20030801235748.GC321@kroah.com> <200308021253.03005.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308021253.03005.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 12:53:02PM +0400, Andrey Borzenkov wrote:
> On Saturday 02 August 2003 03:57, Greg KH wrote:
> > On Sat, Aug 02, 2003 at 01:39:37AM +0400, Andrey Borzenkov wrote:
> > > this adds input agent and coldplug rc script. It relies on patch for
> > > module-init-tools that gnerates input handlers map table being posted to
> > > lkml as well.
> > >
> > > input agent loads input handler in respond to input subsystem request. It
> > > is currently purely table-driven, no attempt to provide for any static
> > > list or like was done, it needs some operational experience.
> > >
> > > static coldplug rc script is intended to load input handlers for any
> > > built-in input drivers, like e.g. psmouse (if you built it in). Currently
> > > it does it by parsing /proc/bus/input/devices, I'd like to use sysfs but
> > > apparently support for it in input susbsystem is incomplete at best.
> > >
> > > It also modifies usb.agent to not consult usb.handmap on 2.6, as it is
> > > not needed anymore.
> > >
> > > Patch is against 2003_05_01 version of hotplug. Comments appreciated.
> >
> > Can you send it not compressed so we have a chance to read it?
> 
> sorry.
> 
> plain text attached.

Thanks, I've applied this patch.  Did your module-init-tools patch make
it into that package too?

thanks,

greg k-h
