Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTFJGiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 02:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbTFJGiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 02:38:09 -0400
Received: from granite.he.net ([216.218.226.66]:19211 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261651AbTFJGiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 02:38:08 -0400
Date: Mon, 9 Jun 2003 23:54:14 -0700
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>
Subject: Re: Oops during boot when init USB mouse, 2.5.70-bk14
Message-ID: <20030610065414.GA4373@kroah.com>
References: <1055224690.5281.224.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055224690.5281.224.camel@workshop.saharacpt.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 07:58:10AM +0200, Martin Schlemmer wrote:
> Hi
> 
> I am getting the following during mouse/keyboard is initialized,
> but it seems to be more specific to the mouse.  Both are USB.
> It was fine with last 2.5.69 kernel, but started when i switched
> to 2.5.70-bk12 (have not tried vanilla, or earlier 2.5.70 bk's,
> as swamped at work).  NB: there are no oops 'header'.
> 
> -------------
> Trace; c01a9466 <kobject_get+4c/4e>
> Trace; c0201830 <get_device+18/21>
> Trace; c0203001 <class_device_add+132/137>
> Trace; c0202ec2 <class_device_initialize+16/23>

You are hitting the WARN_ON() call in kobject_get(), this isn't a oops.

But what is wierd is the calls to class_* for a USB mouse, as I don't
think there are any mouse class code in the current kernel.  Does your
mouse show up under /sys/class anywhere?

thanks,

greg k-h
