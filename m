Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbWI0Ekf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWI0Ekf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 00:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbWI0Ekf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 00:40:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:63877 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964966AbWI0Eke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 00:40:34 -0400
Date: Tue, 26 Sep 2006 21:33:43 -0700
From: Greg KH <gregkh@suse.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 41/47] drivers/base: check errors
Message-ID: <20060927043343.GA32396@suse.de>
References: <11592491901464-git-send-email-greg@kroah.com> <11592491924093-git-send-email-greg@kroah.com> <1159249196427-git-send-email-greg@kroah.com> <1159249200793-git-send-email-greg@kroah.com> <11592492023883-git-send-email-greg@kroah.com> <11592492061208-git-send-email-greg@kroah.com> <1159249209773-git-send-email-greg@kroah.com> <11592492123695-git-send-email-greg@kroah.com> <11592492153066-git-send-email-greg@kroah.com> <d120d5000609261023o20c29171kcba4903c9a35fffb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000609261023o20c29171kcba4903c9a35fffb@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 01:23:34PM -0400, Dmitry Torokhov wrote:
> On 9/26/06, Greg KH <greg@kroah.com> wrote:
> >From: Andrew Morton <akpm@osdl.org>
> >
> >Add lots of return-value checking.
> >
> >+               if (error)
> >+                       goto out;
> >+               error = sysfs_create_link(&bus->devices.kobj,
> >+                                               &dev->kobj, dev->bus_id);
> >+               if (error)
> >+                       goto out;
> >+               error = sysfs_create_link(&dev->kobj,
> >+                               &dev->bus->subsys.kset.kobj, "subsystem");
> >+               if (error)
> >+                       goto out;
> >+               error = sysfs_create_link(&dev->kobj,
> >+                               &dev->bus->subsys.kset.kobj, "bus");
> >       }
> >+out:
> >       return error;
> 
> What about removing the links that were created if one of these calls fails?

Yes, that would be good, I think I have a patch in my queue that handles
that properly...

thanks,

greg k-h
