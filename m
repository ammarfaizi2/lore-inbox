Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbUDWXSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbUDWXSu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 19:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUDWXSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 19:18:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:9903 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261684AbUDWXSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 19:18:49 -0400
Date: Fri, 23 Apr 2004 16:18:12 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@free.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
Subject: Re: [PATCH 1/9] USB usbfs: take a reference to the usb device
Message-ID: <20040423231811.GA10398@kroah.com>
References: <200404141229.26677.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404141229.26677.baldrick@free.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 12:29:26PM +0200, Duncan Sands wrote:
> Hi Greg, this is the first of a series of patches that replace the
> per-file semaphore ps->devsem with the per-device semaphore
> ps->dev->serialize.  The role of devsem was to protect against
> device disconnection.  This can be done equally well using
> ps->dev->serialize.  On the other hand, ps->dev->serialize
> protects against configuration and other changes, and has
> already been introduced into usbfs in several places.  Using
> just one semaphore simplifies the code and removes some
> remaining race conditions.  It should also fix the oopses some
> people have been seeing.  In this first patch, a reference is
> taken to the usb device as long as the usbfs file is open.  That
> way we can use ps->dev->serialize for as long as ps exists.

Nice, I've applied all 9 patches here (with the updated patch 8
version).  Feel free to send me an update for the warning issue you and
Oliver talked about if you want to.

thanks,

greg k-h
