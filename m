Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265664AbUABU0X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 15:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbUABUYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 15:24:07 -0500
Received: from mail.kroah.org ([65.200.24.183]:39557 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265656AbUABUXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 15:23:38 -0500
Date: Fri, 2 Jan 2004 12:19:05 -0800
From: Greg KH <greg@kroah.com>
To: Andrea Barisani <lcars@gentoo.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: does udev really require hotplug?
Message-ID: <20040102201905.GB4992@kroah.com>
References: <20040102101051.GA12073@sole.infis.univ.trieste.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040102101051.GA12073@sole.infis.univ.trieste.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 11:10:51AM +0100, Andrea Barisani wrote:
> 
> Hi everybody and happy new year!
> 
> Just one simple question about a very simple matter that right now 
> I can't figure out: does udev need hotplug package presence?
> 
> >From your README:
> 
>   If for some reason you do not install the hotplug scripts, you must tell the
>   kernel to point the hotplug binary at wherever you install udev at.  This can
>   be done by:
> 	echo "/sbin/udev" > /proc/sys/kernel/hotplug
> 
> 
> ...does this work properly?

It should.  Does it not for you?

> It's not clear if some features are lost by not having hotplug script
> installed.

None of the other programs that hook off of the hotplug program will be
available to you if you do this (automatic driver loading, firmware
loading, devlabel, etc.)

> Also is this policy subject to changes in the near future?

What policy?  If you don't have the hotplug package installed, then you
can still use udev.  If you have the hotplug package installed, I've
detailed how you can still use udev.  What's the problem?  :)

thanks,

greg k-h
