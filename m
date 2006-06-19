Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWFSWcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWFSWcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWFSWcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:32:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40923 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964955AbWFSWcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:32:22 -0400
Date: Mon, 19 Jun 2006 23:57:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Salvatore Sanfilippo <antirez@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: v4l device in userspace
Message-ID: <20060619215718.GA1648@openzaurus.ucw.cz>
References: <c6114db60606160403g5e02becctbf2a67db7011ec9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6114db60606160403g5e02becctbf2a67db7011ec9a@mail.gmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've a little program running in the phone, capturing
> images from the camera and sending it to the
> linux box via bluetooth.

Nice!

> Basically I've to pass by the kernel just for
> the interface, and not to do real kernel-side work
> (like to access to the some kind of hardware).
> 
> So I've some questions ( thanks in advance
> for any reply).
> 
> 1) What's the best way to pass relatively
> high-band data between the v4l fake driver
> and userspace? A char device will do the
> work? ioctl?
> 
> 2) What about some way to handle ioctl
> directly from userspace? Given this support
> I may implement the whole code in userspace.
> And I guess there are a lot of other real world
> problems that can be handled in userspace
> given the ability to handle ioctl from there.
> 
> If you think 2) is reasonable I may actually
> implement some simple form of generic
> char driver that just allows userspace
> programs to handle read/write/ioctl
> opreations, and then use this to fix
> my real issue.

You probably want to do something v4l specigic... but generic userspace driver
 able to do read/write/ioctl would be very nice. Lots of devices these days are on usb, and that can be done from userspace, for example.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

