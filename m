Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVBSWlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVBSWlK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 17:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVBSWlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 17:41:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:4760 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262294AbVBSWlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 17:41:00 -0500
Date: Sat, 19 Feb 2005 14:40:36 -0800
From: Greg KH <greg@kroah.com>
To: Telemaque Ndizihiwe <telendiz@eircom.net>
Cc: rddunlap@osdl.org, bhards@bigpond.net.au, torvalds@osdl.org, akpm@osdl.org,
       trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove unnecessary addition operations from usb/core/hub.c
Message-ID: <20050219224036.GC12713@kroah.com>
References: <1108839807.7748.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108839807.7748.24.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 07:03:27PM +0000, Telemaque Ndizihiwe wrote:
> This Patch removes unnecessary addition operations from
> usb/core/hub.c in kernel 2.6.10.
> 
> 	usb_disable_endpoint(udev, 0 + USB_DIR_IN);   //replaced by
> 	usb_disable_endpoint(udev, USB_DIR_IN);
> 
> 	usb_disable_endpoint(udev, 0 + USB_DIR_OUT);  //replaced by	
> 	usb_disable_endpoint(udev, USB_DIR_OUT);
> 
> 
> Signed-off-by: Telemaque Ndizihiwe <telendiz@eircom.net>

No, I'll say to leave these "0 +" in the code.  It doesn't hurt anything
(the compiler takes care of it in preprocessing) and it instantly tells
you exactly what the code is really doing (disabling endpoint 0).
Without the 0 in there, you would have to take a bit to think about
which endpoint is actually being disabled.

So, sorry, I'm not going to apply this.

Oh, and next time, please CC: the linux usb maintainer, and the
linux-usb-devel mailing list when you post USB patches.

thanks,

greg k-h
