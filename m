Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266610AbUBESP4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUBESP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:15:56 -0500
Received: from mail.kroah.org ([65.200.24.183]:15324 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266610AbUBESPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:15:53 -0500
Date: Thu, 5 Feb 2004 10:15:50 -0800
From: Greg KH <greg@kroah.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] Take 2: cdev_unmap()
Message-ID: <20040205181550.GF13075@kroah.com>
References: <20040205180103.32517.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205180103.32517.qmail@lwn.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 11:01:03AM -0700, Jonathan Corbet wrote:
> I didn't get any responses to my last posting on cdev_unmap(); I take it
> that means nobody objects :)
> 
> To recap my argument: the current cdev implementation keeps an uncounted
> reference to every cdev in cdev_map.  Creators of cdevs must know to call
> cdev_unmap() with the same arguments they passed to cdev_add() before
> releasing the device, or that reference will remain and will oops the
> kernel should user space attempt to open the (missing) device.  It's an
> easy mistake to make, and, IMO, entirely unnecessary; the cdev code should
> be able to do its own bookkeeping.
> 
> So, does anybody have a reason why this shouldn't go in?  Al, have I missed
> something?

I sure like it, it starts to make the cdev interface easier to use.  

Al, unless you object, I'll add this to my driver bk tree which will get
sucked into -mm and then send it off to Linus after a bit of testing.

thanks,

greg k-h
