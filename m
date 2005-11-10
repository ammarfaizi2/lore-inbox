Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVKJXsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVKJXsj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 18:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVKJXsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 18:48:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:17844 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932118AbVKJXsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 18:48:38 -0500
Date: Thu, 10 Nov 2005 15:46:44 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>, stern@rowland.harvard.edu,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, mdharm-usb@one-eyed-alien.net,
       Reuben Farrelly <reuben-lkml@reub.net>
Subject: Re: [-mm patch] USB_LIBUSUAL shouldn't be user-visible
Message-ID: <20051110234644.GA6430@kroah.com>
References: <20051107215226.GA25104@kroah.com> <Pine.LNX.4.44L0.0511071725220.5165-100000@iolanthe.rowland.org> <20051107222840.GB26417@kroah.com> <20051108004716.GJ3847@stusta.de> <20051109222808.GG9182@kroah.com> <20051109224117.337690bf.zaitcev@redhat.com> <20051110105648.GC5376@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110105648.GC5376@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 11:56:48AM +0100, Adrian Bunk wrote:
> On Wed, Nov 09, 2005 at 10:41:17PM -0800, Pete Zaitcev wrote:
> > On Wed, 9 Nov 2005 14:28:08 -0800, Greg KH <greg@kroah.com> wrote:
> > 
> > > > What about letting the two drivers always use libusual?
> > > 
> > > Pete?  What do you think about this patch?
> > 
> > It does nothing to explain how exactly the current configuration managed
> > not to work, which leaves me unsatisfied. I did test the kernel to build
> > correctly with libusub on and off. All we have is this:
> 
> The problem is not that it wouldn't work.
> The question is whether users compiling their kernel should know 
> anything about USB_LIBUSUAL.
> IMHO, USB_LIBUSUAL is an internal implementation detail and there's no 
> reason why a user should ever see this option.
> This is what my patch does.

No, it's not an implementation detail, it explicitly changes the way
things work, and lets users change they way they work, by giving them
run-time options.

So it should not be hidden, at least not yet until everyone gets used to
using it.

thanks,

greg k-h
