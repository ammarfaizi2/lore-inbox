Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265629AbUBBFVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 00:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265630AbUBBFVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 00:21:55 -0500
Received: from mail.kroah.org ([65.200.24.183]:21728 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265629AbUBBFVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 00:21:51 -0500
Date: Sun, 1 Feb 2004 21:21:00 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: module-init-tools/udev and module auto-loading
Message-ID: <20040202052100.GA21753@kroah.com>
References: <1075674718.27454.17.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075674718.27454.17.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 12:31:58AM +0200, Martin Schlemmer wrote:
> Hi
> 
> A quick question on module-init-tools/udev and module auto-loading ...
> lets say I have a module called 'foo', that I want the kernel to
> auto-load.

Wait, stop right there.  When do you want the module autoloaded?

If you want it loaded when the device is plugged in, then great, the
hotplug scripts will do that.

If you want the module loaded when you try to access the /dev node, then
see the FAQ about udev for that :)

> Then a distant related issue - anybody thought about dynamic major
> numbers of 2.7/2.8 (?) and the 'alias char-major-<whatever>-* whatever'
> type modprobe rules (as the whole fact of them being dynamic, will make
> that alias type worthless ...)?

Yes, it will make the char-major-* stuff worthless, however the distro
I use has not used that style of alias for years, why would yours?  :)

Rusty had it correct in that you need to try to load for the type of
module:
	alias eth1 tulip
	alias usb-controller usb-ohci
and so on.  That's the much better way.

thanks,

greg (I hate kmod) k-h
