Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVF1I1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVF1I1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 04:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVF1IPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 04:15:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:54980 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261875AbVF1IJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 04:09:57 -0400
Date: Tue, 28 Jun 2005 00:40:15 -0700
From: Greg KH <greg@kroah.com>
To: Mike Bell <kernel@mikebell.org>, Dmitry Torokhov <dtor_core@ameritech.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050628074015.GA3577@kroah.com>
References: <20050624081808.GA26174@kroah.com> <20050625234305.GA11282@kroah.com> <20050627071907.GA5433@mikebell.org> <200506271735.50565.dtor_core@ameritech.net> <20050627232559.GA7690@mikebell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627232559.GA7690@mikebell.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 04:26:00PM -0700, Mike Bell wrote:
> On Mon, Jun 27, 2005 at 05:35:50PM -0500, Dmitry Torokhov wrote:
> > AFAIK there is no requirement in input subsystem that devices should be
> > created under /dev/input. When devfs is activated they are created there
> > by default, but that's it.
> 
> Things which accept a path to an event file as an argument will work
> just fine. But anything which tries autodiscovery HAS to be able to find
> the device nodes. Think directfb, most (but not all) of the X patches,
> any user-space driver that wants to find the hardware it owns, etc.
> 
> This illustrates nicely my reasons for preferring devfs.
> 
> 1) Predictable, canonical device names are a Good Thing.

And impossible for the kernel to generate given hotpluggable devices.

> 2) If you accept that, exporting the device names from the kernel is the
> most sensible way to do it.

I don't accept it, and neither does anyone else.  See my previous posts
about devfs and udev for more details, I'm not going to go into this
again...

Good luck,

greg k-h
