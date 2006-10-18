Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWJRXXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWJRXXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 19:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWJRXXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 19:23:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:28341 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751137AbWJRXXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 19:23:13 -0400
Date: Wed, 18 Oct 2006 16:09:39 -0700
From: Greg KH <greg@kroah.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: Greg.Chandler@wellsfargo.com, linux-kernel@vger.kernel.org
Subject: Re: kernel oops with extended serial stuff turned on...
Message-ID: <20061018230939.GA7713@kroah.com>
References: <335DD0B75189FB428E5C32680089FB9F803FE8@mtk-sms-mail01.digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <335DD0B75189FB428E5C32680089FB9F803FE8@mtk-sms-mail01.digi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 05:35:17PM -0500, Kilau, Scott wrote:
> Hi Greg,
> 
> > 
> > I don't understand, what problem is occuring here?  Who is trying to
> > register with sysfs twice?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> The original warning/error he gets is:
> 
> > kobject_add failed for ttyM0 with -EEXIST, don't try to register
> things
> > with the same name in the same directory.
> 
> Presumably this means that "ttyM0" was already registered with
> sysfs/udev already...

Yes (sysfs, not udev, there is no kernel portion of udev, sorry).

> In my out-of-tree driver's case, I used to use "TTY_DRIVER_NO_DEVFS" as
> a flag.
> 
> When that flag went away, I did not put in "TTY_DRIVER_DYNAMIC_DEV" by
> mistake,
> and I got the same error as Greg C.
> I had to push in "TTY_DRIVER_DYNAMIC_DEV" to fix my problem...

What other driver is using the ttyM0 name?

> I don't know much (anything) about the isicom.c driver, so maybe I am
> reading
> something into that error that shouldn't be read into it...

Any pointer to your driver's code so I can see if you are doing
something odd here?  Any reason it's just not in the main kernel tree so
I would have fixed it up at the time I did the other fixes?

thanks,

greg k-h
