Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUDWTqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUDWTqb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 15:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUDWTqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 15:46:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:4286 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261179AbUDWTqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 15:46:30 -0400
Date: Fri, 23 Apr 2004 12:46:05 -0700
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Simon Kelley <simon@thekelleys.org.uk>
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Message-ID: <20040423194605.GA7824@kroah.com>
References: <200404230142.46792.dtor_core@ameritech.net> <200404230802.42293.dtor_core@ameritech.net> <1082730412.23959.118.camel@pegasus> <200404231156.03106.dtor_core@ameritech.net> <20040423171614.GA13835@kroah.com> <1082746253.23959.126.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082746253.23959.126.camel@pegasus>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 08:50:54PM +0200, Marcel Holtmann wrote:
> Hi Greg,
> 
> > Much nicer (well, in a wierd way at least.)  It seems that the pcmcia
> > system is intregrated into the driver model.  Why not push it down into
> > the individual pcmcia drivers so you don't have to do this GetSysDevice
> > kind of hack still?
> 
> let's split the patch into a PCMCIA subsystem part and atmel_cs part and
> even if it looks like a hack we need it, because otherwise the atmel_cs
> and bt3c_cs drivers are broken now.

Well, they have always been broken, it's just that now you get an
obvious oops message :)

thanks,

greg k-h
