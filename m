Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTJ0QRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 11:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbTJ0QRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 11:17:11 -0500
Received: from mail.kroah.org ([65.200.24.183]:59039 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263178AbTJ0QRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 11:17:09 -0500
Date: Sat, 25 Oct 2003 10:11:23 -0700
From: Greg KH <greg@kroah.com>
To: David Jez <dave.jez@seznam.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: diethotplug-0.4 utility patch
Message-ID: <20031025171123.GA4167@kroah.com>
References: <20031023184603.GA81234@stud.fit.vutbr.cz> <20031024054145.GA3233@kroah.com> <20031025120422.GB93355@stud.fit.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031025120422.GB93355@stud.fit.vutbr.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 25, 2003 at 02:04:25PM +0200, David Jez wrote:
> On Thu, Oct 23, 2003 at 10:41:46PM -0700, Greg KH wrote:
> > Hm, remove action will not work.  See the linux-hotplug-devel mailing
> > list archives for why we can not do this.
>   OK, i'll see. But this realy helps me.

But it's wrong.  You can't get this correct, and you will end up
removing modules for devices that are currently in use.  The moment you
have 2 devices that use the same module this will happen.  You will end
up with some very unhappy users.

> > > - adds pci.rc & usb.rc
> > 
> > Why do you need this?  What's wrong with a small shell script to do
> > this?  Are you using this for a system?  I guess it could be useful for
> > a system that has no shell.
>   Nothing wrong on shell script, but i use this on system without perl,
> awk, if, ...etc... binaries.

Ok, care to send these as a separate patch then too?

thanks,

greg k-h
