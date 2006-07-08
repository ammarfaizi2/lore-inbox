Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964884AbWGHQNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbWGHQNN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 12:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWGHQNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 12:13:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:14814 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964884AbWGHQNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 12:13:12 -0400
Date: Sat, 8 Jul 2006 09:12:11 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Mike Galbraith <efault@gmx.de>, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Opinions on removing /proc/tty?
Message-ID: <20060708161211.GA5555@kroah.com>
References: <9e4733910607071956q284a2173rfcdb2cfe4efb62b4@mail.gmail.com> <1152344452.7922.11.camel@Homer.TheSimpsons.net> <9e4733910607080712y248f61b9q7444b754516c4d6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910607080712y248f61b9q7444b754516c4d6a@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 10:12:36AM -0400, Jon Smirl wrote:
> On 7/8/06, Mike Galbraith <efault@gmx.de> wrote:
> >On Fri, 2006-07-07 at 22:56 -0400, Jon Smirl wrote:
> >> Does anyone use the info in /proc/tty? The hard coded device names
> >> aren't compatible with udev's ability to rename things.
> >>
> >> There also doesn't appear to be any useful info in the drivers portion
> >> that isn't already available in sysfs. I can add some code to make a
> >> list of registered line disciplines appear in sysfs.
> >>
> >> Does anyone have a problem with deleting /proc/tty if ldisc enum
> >> support is added to sysfs?
> >
> >ps uses /proc/tty/drivers, so some coordination would be needed.
> 
> Greg, I just looked at the source for ps and it has a bunch of fixed
> code for turning major/minor into /dev/name.  Isn't that something
> udevinfo should be doing? But looking at the help for udevinfo I don't
> see any way to turn a major/minor into /dev/name. The altermative
> seems to be search /dev looking for the right device node.

So far no one has needed that kind of functionality from udevinfo.  It
should be easy to add if you need it, patches are always welcome :)

thanks,

greg k-h
