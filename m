Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUDZXM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUDZXM3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 19:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbUDZXM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 19:12:29 -0400
Received: from mail.kroah.org ([65.200.24.183]:39041 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262906AbUDZXJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 19:09:45 -0400
Date: Mon, 26 Apr 2004 15:31:05 -0700
From: Greg KH <greg@kroah.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Bill Davidsen <davidsen@tmr.com>, "E. Oltmanns" <oltmanns@uni-bonn.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops during usb usage (2.6.5)
Message-ID: <20040426223101.GA9258@kroah.com>
References: <20040423205617.GA1798@local> <408D4187.2040104@tmr.com> <20040426195359.GA29062@kroah.com> <200404270017.34478.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404270017.34478.oliver@neukum.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 12:17:34AM +0200, Oliver Neukum wrote:
> Am Montag, 26. April 2004 21:53 schrieb Greg KH:
> > On Mon, Apr 26, 2004 at 01:06:15PM -0400, Bill Davidsen wrote:
> > > Just in general, if there is anything a non-root user can do to crash
> > > the system, it's probably a kernel bug by definition. It doesn't matter
> > > that's it a stupid thing to do, it might be malicious. And in this case
> > > it might just be user error.
> >
> > But you either have to be root in order to talk to usbfs, or you were
> > root when you gave a user access to the usbfs node.  So either way, a
> > "normal" user can't even do this.
> 
> Greg,
> 
> that's not an answer. It in effect means that usbfs is useless.

Heh.  So the correct answer is:
	- don't do that.  Talking to the same device through usbfs at
	  the same time by multiple programs is cause for lots of bad
	  things to happen to your device, and might possibly cause it
	  to hang.  If you want to allow a user to access a device
	  through usbfs, make sure you trust them.

Better?  :)

thanks,

greg k-h
