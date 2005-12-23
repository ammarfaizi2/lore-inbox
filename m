Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbVLWWoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbVLWWoq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 17:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbVLWWop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 17:44:45 -0500
Received: from mail.kroah.org ([69.55.234.183]:4046 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161087AbVLWWop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 17:44:45 -0500
Date: Fri, 23 Dec 2005 14:44:03 -0800
From: Greg KH <greg@kroah.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14.3 - sysfs duplicated dentry bug
Message-ID: <20051223224403.GA18793@kroah.com>
References: <200512091848.42297.blaisorblade@yahoo.it> <20051209175555.GA9761@kroah.com> <200512232325.12849.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512232325.12849.blaisorblade@yahoo.it>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 11:25:11PM +0100, Blaisorblade wrote:
> On Friday 09 December 2005 18:55, Greg KH wrote:
> > On Fri, Dec 09, 2005 at 06:48:41PM +0100, Blaisorblade wrote:
> > > Q: Since when is a directory entry allowed to be duplicate?
> > > A: Since Linux 2.6.14!
> > >
> > > $ uname -r
> > > 2.6.14.3-bs2-mroute
> > >
> > > The only sysfs-related change is the use of a custom DSDT, which is new
> > > to this kernel.
> 
> > Known bug, fixed in the 2.6.15-rc kernel tree.  It was a timer
> > registering with the same name in two places :(
> 
> Sorry for answering so late (my latency in checking "spam" false positives is 
> big) but shouldn't this have been backported to -stable?

It should, if someone sends the patch to do so to the stable@ email
address :)

> Also is this known to cause hangs at unmount time (I experience them
> at times and they're not network FSs-related) ?

Not that I have heard about, but you never know...

thanks,

greg k-h
