Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbUCIIVN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 03:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbUCIIVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 03:21:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:27853 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261670AbUCIIVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 03:21:11 -0500
Date: Tue, 9 Mar 2004 00:19:48 -0800
From: Greg KH <greg@kroah.com>
To: rihad <rihad@mail.ru>
Cc: linux-kernel-digest@lists.us.dell.com, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040309081948.GI22057@kroah.com>
References: <20040303153403.21649.81059.Mailman@linux.us.dell.com> <4048D503.10808@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4048D503.10808@mail.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 11:29:07PM +0400, rihad wrote:
> Date: 	Wed, 3 Mar 2004 07:14:33 -0800
> From: Greg KH <greg@kroah.com>
> 
> >Users need to learn that the kernel is changing models from one which
> >automatically loaded modules when userspace tried to access the device,
> >to one where the proper modules are loaded when the hardware is found.
> 
> Does this mean that I will have modules for all my hardware hanging 
> around even if I'm not, say, using cdrom at the moment?

Yup, why not?

> And does it mean that if I rmmod -a the unused cdrom module and later
> try to mount /cdrom, the correct module won't be magically insmod'ed?

If you don't have the /dev entry there, how would anything know to load
the module?

> I like the idea of lazy module loading, and it seems that your model 
> doesn't fit in nicely, I could be wrong.

How about "loading the modules for the hardware present"?  What's wrong
with that?

thanks,

greg k-h
