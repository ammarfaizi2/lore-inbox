Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTJ2Wnx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 17:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTJ2Wnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 17:43:53 -0500
Received: from mail.kroah.org ([65.200.24.183]:64653 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261743AbTJ2Wnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 17:43:46 -0500
Date: Wed, 29 Oct 2003 14:43:13 -0800
From: Greg KH <greg@kroah.com>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: User-space System Device Enumation (uSDE)
Message-ID: <20031029224313.GA1407@kroah.com>
References: <3F9D82F0.4000307@mvista.com> <20031027210054.GR24286@marowsky-bree.de> <3F9D8AAA.7010308@mvista.com> <20031028110034.GG30725@marowsky-bree.de> <1067364727.4612.359.camel@persist.az.mvista.com> <20031028224416.GA8671@kroah.com> <pan.2003.10.29.14.30.29.628488@dungeon.inka.de> <20031029191858.GA4298@kroah.com> <1067465573.28173.33.camel@simulacron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067465573.28173.33.camel@simulacron>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 29, 2003 at 11:12:53PM +0100, Andreas Jellinghaus wrote:
> Hi Greg!
> 
> On Wed, 2003-10-29 at 20:18, Greg KH wrote:
> > Sweet shell script, nice job.
> > 
> > > So udev is 99% overhead?
> > To you, sure, it might be.  Don't use it then, I'm not forcing anyone.
> 
> Thats right! So I don't understand all those discussions why some people
> created an alternative to udev, as everyone is free to. All
> implementations seem to be quit young, and I enjoy many different
> approaches to solve these related problems. a bit of diversity or
> evolution and natural selection doesn't hurt.

I agree, evolution is good in this case.  I'm just really curious as to
why Monta Vista and Intel decided that udev wasn't an approiate project
to work with, and decided to spend time and resources to develop an
alternative one.  Just a bit frustrated, as udev really could have used
a few people working on it full time as SDE had.

But hey, that's all past, if those companies like to live with the NIH
symptom, I can't change that.  And udev development will go on
regardless.

> But, all these different user space tools share one thing: the same
> kernel. the linux kernel has to work for all of us, and I even think
> it is very important to have many different user space tools at the
> current time, so everyone can voice their opinions and suggest how the
> kernel should be changed, so it will work for him, and preferable for
> all of us.

Agreed.

> I'd like to see a different namespace.

Different namespace where?  In /sys?  Or somewhere else?

> I need some info on block devices. currently there is no way to see if
> hdc is a cdrom or a disc in sysfs, so that should be added.

Not true at all.  Just look at the device symlink, and the type file in
that directory.  Shows it quite well for all of my scsi devices.  Now it
looks like IDE needs to add that same type of file, but that's an IDE
issue.  Actually IDE's sysfs code probably could use some good cleanups,
now that I look at it some more.  Want to work on that?

thanks,

greg k-h
