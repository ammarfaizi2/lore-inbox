Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264583AbTLKJjr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 04:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264591AbTLKJjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 04:39:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:61824 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264583AbTLKJjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 04:39:46 -0500
Date: Thu, 11 Dec 2003 01:29:15 -0800
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: file2alias - incorrect? aliases for USB
Message-ID: <20031211092915.GC5510@kroah.com>
References: <20031110093703.GA5449@kroah.com> <20031117060542.489442C266@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031117060542.489442C266@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 02:09:32PM +1100, Rusty Russell wrote:
> In message <20031110093703.GA5449@kroah.com> you write:
> > Hm, but that's no good either, because the visor driver trips over that
> > with its entry:
> > 	MODULE_ALIAS("usb:v*p*dl*dh*dc*dsc*dp*ic*isc*ip*");
> > and the improper module is loaded.  That needs to be fixed up...
> > 
> > Rusty, any reason why the module alias code is turning an empty
> > MODULE_PARAM structure, as is declared in drivers/usb/serial/visor.c
> > with the line:
> >         { },                                    /* optional parameter entry */ 
> > 
> > Into the above MODULE_ALIAS?  I don't think that's correct.
> 
> Sorry for the delay, was away and am catching up on mail.
> 
> Thanks to Andrey for the fix.  Greg, did you want to add something
> else?  Either way, please forward to Linus.

Just finally did that, thanks.

greg k-h
