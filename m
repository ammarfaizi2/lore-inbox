Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbUCAUr2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 15:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUCAUr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 15:47:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:50638 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261429AbUCAUrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 15:47:25 -0500
Date: Mon, 1 Mar 2004 12:47:23 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: Nigel Kukard <nkukard@lbsd.net>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.3] Sysfs breakage - tun.ko
Message-ID: <20040301124723.P22989@build.pdx.osdl.net>
References: <4043938C.9090504@lbsd.net> <40439B03.4000505@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40439B03.4000505@backtobasicsmgmt.com>; from kpfleming@backtobasicsmgmt.com on Mon, Mar 01, 2004 at 01:20:19PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kevin P. Fleming (kpfleming@backtobasicsmgmt.com) wrote:
> Nigel Kukard wrote:
> 
> > --- drivers/net/tun.c.old   2004-02-27 18:18:55.000000000 +0200
> > +++ drivers/net/tun.c       2004-02-27 18:19:02.000000000 +0200
> > @@ -605,7 +605,7 @@
> > 
> >  static struct miscdevice tun_miscdev = {
> >         .minor = TUN_MINOR,
> > -       .name = "net/tun",
> > +       .name = "tun",
> >         .fops = &tun_fops
> >  };
> 
> This changed back and forth since the tun driver was added to the 
> kernel; making this change will cause the devfs path to the tun node to 
> change, and userspace applications expect it to be at /dev/misc/net/tun, 
> whether that's right or wrong.

Why don't you use:
	.devfs_name = "net/tun",

Or fix userspace apps?  Or switch to udev with devfs rules emulated and a
rule for the tun/tap driver?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
