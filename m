Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265652AbUBCBEc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 20:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265631AbUBCBCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 20:02:36 -0500
Received: from dp.samba.org ([66.70.73.150]:45222 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265647AbUBCBCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 20:02:10 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Greg KH <greg@kroah.com>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: module-init-tools/udev and module auto-loading 
In-reply-to: Your message of "Mon, 02 Feb 2004 21:02:30 +0200."
             <1075748550.6931.10.camel@nosferatu.lan> 
Date: Tue, 03 Feb 2004 11:55:33 +1100
Message-Id: <20040203010224.4CF742C261@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1075748550.6931.10.camel@nosferatu.lan> you write:
> > This does not cover the class of things which are entirely created by
> > the driver (eg. dummy devices, socket families), so cannot be
> > "detected".  Many of these (eg. socket families) can be handled by
> > explicit request_module() in the core and MODULE_ALIAS in the driver.
> > Some of them cannot at the moment: the first the kernel knows of them
> > is an attempt to open the device.  Some variant of devfs would solve
> > this.
> > 
> 
> I guess there will be cries of murder if 'somebody' suggested that if
> a node in /dev is opened, but not there, the kernel can call
> 'modprobe -q /dev/foo' to load whatever alias there might have been?

I think it's an excellent idea, although ideally we would have this
mechanism in userspace as much as possible.  Anything from some
special hack to block -ENOENT on directory lookups and notify an fd,
to some exotic overlay filesystem.

I'm sure Al Viro has an opinion on this...

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
