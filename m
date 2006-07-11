Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWGKWHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWGKWHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWGKWHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:07:52 -0400
Received: from ns2.suse.de ([195.135.220.15]:41451 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932185AbWGKWHv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:07:51 -0400
Date: Tue, 11 Jul 2006 15:03:32 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Mike Galbraith <efault@gmx.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Opinions on removing /proc/tty?
Message-ID: <20060711220332.GE663@kroah.com>
References: <9e4733910607071956q284a2173rfcdb2cfe4efb62b4@mail.gmail.com> <1152344452.7922.11.camel@Homer.TheSimpsons.net> <9e4733910607080712y248f61b9q7444b754516c4d6a@mail.gmail.com> <1152370102.27368.5.camel@localhost.localdomain> <9e4733910607080920t51957e28sa131f86876219891@mail.gmail.com> <20060708172047.GA23882@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060708172047.GA23882@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 06:20:47PM +0100, Russell King wrote:
> On Sat, Jul 08, 2006 at 12:20:06PM -0400, Jon Smirl wrote:
> > I'll put together a patch making it mountable. Is there any specific
> > info that needs to be added to sysfs?
> 
> Adding info to the sysfs side of tty devices is rather fraught (or was
> last time I looked - I'd like to do exactly that with serial_core.)
> 
> Unfortunately, until it becomes easier (and maybe it recently has now
> that tty_register_device returns the class device struct), /proc/tty
> needs to stay.  But... I heard that Greg wants to remove struct
> class_device...

Yes I do want to remove it, but anything that you add to the
class_device will still work just fine, I'm not wanting to break
userspace tools anymore :)

And it should be pretty easy to do, now that we do return the
class_device that you need to have to add files to.

thanks,

greg k-h
