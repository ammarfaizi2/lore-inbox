Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbUBUAAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUBTX5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 18:57:32 -0500
Received: from mail.kroah.org ([65.200.24.183]:35819 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261437AbUBTX5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 18:57:08 -0500
Date: Fri, 20 Feb 2004 15:54:12 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fb_console_init fix.
Message-ID: <20040220235410.GB17771@kroah.com>
References: <Pine.LNX.4.44.0402202156340.6798-100000@phoenix.infradead.org> <1077317816.9623.20.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077317816.9623.20.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 09:56:56AM +1100, Benjamin Herrenschmidt wrote:
> 
> If we want the fb stuff to be initialized before other drivers, we
> probably want to create an init step before devices and after PCI
> probe, but is that really necessary ?
> 
> The core fbdev should just need a subsys initcall. fbcon could use
> that too and register a notifier. Then we could use the notifier
> mecanism to notify fbcon when fbdev's are added (from
> register_framebuffer) and get rid of all of the init crap

What's wrong with the current range of init call sections?  Can't that
work for fb devices today?

thanks,

greg k-h
