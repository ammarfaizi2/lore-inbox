Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbUCAU1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 15:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUCAU0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 15:26:53 -0500
Received: from [196.25.168.8] ([196.25.168.8]:30620 "EHLO lbsd.net")
	by vger.kernel.org with ESMTP id S261428AbUCAUYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 15:24:52 -0500
Date: Mon, 1 Mar 2004 22:24:13 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.3] Sysfs breakage - tun.ko
Message-ID: <20040301202413.GB21950@lbsd.net>
References: <4043938C.9090504@lbsd.net> <40439B03.4000505@backtobasicsmgmt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40439B03.4000505@backtobasicsmgmt.com>
User-Agent: Mutt/1.4.1i
X-PHP-Key: http://www.lbsd.net/~nkukard/keys/gpg_public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nevermind if its right or wrong, it does not work in sysfs

-Nigel

On Mon, Mar 01, 2004 at 01:20:19PM -0700, Kevin P. Fleming wrote:
> Nigel Kukard wrote:
> 
> >--- drivers/net/tun.c.old   2004-02-27 18:18:55.000000000 +0200
> >+++ drivers/net/tun.c       2004-02-27 18:19:02.000000000 +0200
> >@@ -605,7 +605,7 @@
> >
> > static struct miscdevice tun_miscdev = {
> >        .minor = TUN_MINOR,
> >-       .name = "net/tun",
> >+       .name = "tun",
> >        .fops = &tun_fops
> > };
> 
> This changed back and forth since the tun driver was added to the 
> kernel; making this change will cause the devfs path to the tun node to 
> change, and userspace applications expect it to be at /dev/misc/net/tun, 
> whether that's right or wrong.
