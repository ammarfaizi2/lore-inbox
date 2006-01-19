Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbWASDta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbWASDta (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 22:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030511AbWASDta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 22:49:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41646 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030486AbWASDt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 22:49:29 -0500
Date: Wed, 18 Jan 2006 19:49:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: bos@pathscale.com, rdreier@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: RFC: ipath ioctls and their replacements
Message-Id: <20060118194911.4da86c22.akpm@osdl.org>
In-Reply-To: <20060119025741.GC15706@kroah.com>
References: <1137631411.4757.218.camel@serpentine.pathscale.com>
	<20060119025741.GC15706@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>

Sorry for sticking my head in a beehive, but.  Stand back and look at it:

> Shouldn't you just open the proper chip device and port device itself?
> Why not just use mmap?  What's the special needs?
> sysfs file.
> Use poll.
> Use netlink for subnet stuff.
> Use debugfs.
> Use the pci sysfs config files, don't duplicate existing functionality.
> netlink or debugfs.

For a driver-bodging interface design, this is simply nutty.

And it makes the driver developer learn a pile of extra stuff and it
introduces lots of linkages everywhere and heaven knows what the driver's
userspace interface description ends up looking like.

ioctl() would have to be pretty darn bad to be worse than all this random
stuff.

Just saying...
