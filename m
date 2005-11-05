Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbVKETlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVKETlM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 14:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVKETlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 14:41:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:49298 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932303AbVKETlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 14:41:11 -0500
Date: Sat, 5 Nov 2005 11:40:44 -0800
From: Greg KH <greg@kroah.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [DRIVER MODEL] Improved dynamically allocated platform_device interface
Message-ID: <20051105194044.GA23882@kroah.com>
References: <20051105105628.GE28438@flint.arm.linux.org.uk> <20051105154210.GA20598@kroah.com> <20051105171955.GA12228@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105171955.GA12228@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 05:19:55PM +0000, Russell King wrote:
> On Sat, Nov 05, 2005 at 07:42:10AM -0800, Greg KH wrote:
> > On Sat, Nov 05, 2005 at 10:56:28AM +0000, Russell King wrote:
> > > Re-jig the simple platform device support to allow private data
> > > to be attached to a platform device, as well as allowing the
> > > parent device to be set.
> > > 
> > > Example usage:
> > > 
> > > 	pdev = platform_device_alloc("mydev", id);
> > > 	if (pdev) {
> > > 		err = platform_device_add_resources(pdev, &resources,
> > > 						    ARRAY_SIZE(resources));
> > > 		if (err == 0)
> > > 			err = platform_device_add_data(pdev, &platform_data,
> > > 						       sizeof(platform_data));
> > > 		if (err == 0)
> > > 			err = platform_device_add(pdev);
> > > 	} else {
> > > 		err = -ENOMEM;
> > > 	}
> > > 	if (err)
> > > 		platform_device_put(pdev);
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > These look great, want me to add them to my tree and get them to Linus
> > before 2.6.15?
> 
> I'm also happy to add them to my tree.  Are you okay with that?

I am fine with that, you can add:
	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
if you want to to these patches.

thanks,

greg k-h
