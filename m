Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVGZByS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVGZByS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 21:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVGZByS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 21:54:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:28554 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261522AbVGZByQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 21:54:16 -0400
Date: Mon, 25 Jul 2005 18:54:01 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Message-ID: <20050726015401.GA25015@kroah.com>
References: <9e47339105072421095af5d37a@mail.gmail.com> <200507242358.12597.dtor_core@ameritech.net> <9e4733910507250728a7882d4@mail.gmail.com> <d120d5000507250748136a1e71@mail.gmail.com> <9e47339105072509307386818b@mail.gmail.com> <20050726000024.GA23858@kroah.com> <9e473391050725172833617aca@mail.gmail.com> <20050726003018.GA24089@kroah.com> <9e47339105072517561f53b2f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105072517561f53b2f9@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2005 at 08:56:17PM -0400, Jon Smirl wrote:
> On 7/25/05, Greg KH <greg@kroah.com> wrote:
> > On Mon, Jul 25, 2005 at 08:28:10PM -0400, Jon Smirl wrote:
> > > I didn't realize that echo was adding the CR, I thought that it always
> > > appeared on the end of a sysfs attribute set. So now I have to go add
> > > white space stripping to a dozen fbdev/drm sysfs attribute
> > > implementations. Given that the param is const I may have to allocate
> > > new buffers and copy. I also wonder how many other people have made
> > > the same mistake.
> > 
> > Nah, just zero out that \n character :)
> 
> The input buffer is "const char * buf". I will have to override the
> const to zero it out.

Yeah, hence the ":)" above.

> > > Are you sure it would break other things? These are supposed to be
> > > text attributes, not binary ones.
> > 
> > I agree, I don't know what would break.  Care to make a patch so we
> > could find out?
> 
> I'll put one together to trim leading/trailing white space from the
> buffer before it is passed into the attribute functions. Now that I
> think about this I believe the attributes should have always had the
> leading/trailing white space removed. If we don't do it in the sysfs
> code then every driver has to do it.

Ok, sounds good.

thanks,

greg k-h
