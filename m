Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264370AbTLKHLp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 02:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbTLKHLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 02:11:41 -0500
Received: from mail.kroah.org ([65.200.24.183]:14022 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264376AbTLKHJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 02:09:31 -0500
Date: Wed, 10 Dec 2003 22:47:59 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, Duncan Sands <baldrick@free.fr>,
       Vince <fuzzy77@free.fr>, "Randy.Dunlap" <rddunlap@osdl.org>,
       mfedyk@matchmail.com, zwane@holomorphy.com,
       linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Message-ID: <20031211064759.GC2529@kroah.com>
References: <20031210204621.GA8566@kroah.com> <Pine.LNX.4.44L0.0312101647480.645-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0312101647480.645-100000@ida.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 05:08:12PM -0500, Alan Stern wrote:
> > Now grasshopper, are you wise in the ways of the driver core or are you
> > wishing you never asked?  :)
> 
> Both, I think.  I still don't see where pci_unregister_driver() ends up
> waiting for the reference count to drop to 0.  In fact, I think maybe you
> agree that it _doesn't_ wait.  Which was my earlier point.

Ok, yes.  I think we are agreeing here.

Anyway, the patch seems to work for him, but kills my box (not using any
usbfs devices.)  I'll see if we have some odd reference count issues
still floating around...

thanks,

greg k-h
