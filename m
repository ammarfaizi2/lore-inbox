Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbULVFJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbULVFJC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 00:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbULVFJC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 00:09:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:27072 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261316AbULVFGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 00:06:51 -0500
Date: Tue, 21 Dec 2004 21:04:24 -0800
From: Greg KH <greg@kroah.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       linux-usb-devel@lists.sourcefoge.net.kroah.org,
       linux-kernel@vger.kernel.org, laforge@gnumonks.org
Subject: Re: My vision of usbmon
Message-ID: <20041222050424.GB31076@kroah.com>
References: <20041219230454.5b7f83e3@lembas.zaitcev.lan> <20041222005726.GA13317@kroah.com> <1103679534.5055.2.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103679534.5055.2.camel@npiggin-nld.site>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 12:38:54PM +1100, Nick Piggin wrote:
> On Tue, 2004-12-21 at 16:57 -0800, Greg KH wrote:
> > On Sun, Dec 19, 2004 at 11:04:54PM -0800, Pete Zaitcev wrote:
> > > Hi, Guys:
> > > 
> > > This is usbmon which I cooked up because I got tired from adding dbg()'s
> > > and polluting my dmesg. I use it to hunt bugs in USB storage devices so
> > > far, and it's useful, although limited at this stage.
> > > 
> > > I looked at the Harding's USBmon patch, and I think he got a few things right.
> > > The main of them is that I underestimated the benefits of placing the special
> > > files into the filesystem namespace. When we discussed it with Greg in the
> > > airport, we decided that having some sort of Netlink-style socket would be
> > > the best option. I decided to make a u-turn and attach those sockets into
> > > the namespace (currently under /dbg, but it can change). What this buys us is:
> > > 
> 
> Is there any reason why these debug filesystems are going under the
> root directory? Why not /sys/debug or /sys/kernel/debug or something?

See the previous thread as to where to mount debugfs.  In short, I don't
really care :)

thanks,

greg k-h
