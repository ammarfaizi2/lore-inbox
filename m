Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbULQBX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbULQBX1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 20:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbULQBX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 20:23:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:1430 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262709AbULQBXW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 20:23:22 -0500
Date: Thu, 16 Dec 2004 16:58:06 -0800
From: Greg KH <greg@kroah.com>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs for 2.6.10-rc3
Message-ID: <20041217005806.GA12339@kroah.com>
References: <20041216213645.GA9710@kroah.com> <1103244459.1197.15.camel@boxen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103244459.1197.15.camel@boxen>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 01:47:39AM +0100, Alexander Nyberg wrote:
> On Thu, 2004-12-16 at 13:36 -0800, Greg KH wrote:
> > I've added debugfs to my bk driver tree (located at
> > bk://kernel.bkbits.net/gregkh/linux/driver-2.6) so it will show up in
> > the next -mm release.  For those who want to see the patch version, or
> > want to put it in any other kernel tree (Fedora perhaps?) I've included
> > it below.  I haven't added the kobject interface yet, I'll try to get to
> > that next week.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ----------------------------
> > 
> > debugfs: add debugfs
> > 
> > debugfs is a filesystem that is just for debug data.
> > Start moving stuff out of proc and sysfs now :)
> 
> Hi Greg
> 
> Is there any reason why this shouldn't be buildable as module? I saw no
> apparent reason and added "|| defined(MODULE)" to debugfs.h and made the
> Kconfig option tristate. This allowed it to be built as a working module
> (yay, i didn't have to restart to try it out!).

If debugfs calls are used by any code that is built into the kernel,
then the build would fail if debugfs is a module.  As that would soon
get _real_ messy from a Kbuild standpoint, I took the easy way out and
just made it a Y/N type option :)

> Also I saw there was no debugfs_create_u64() for us on 64bit machines ;)

If you have a need for it, I'll be glad to add it :)

thanks,

greg k-h
