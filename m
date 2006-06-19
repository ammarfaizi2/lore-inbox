Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWFSAyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWFSAyx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 20:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWFSAyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 20:54:53 -0400
Received: from terminus.zytor.com ([192.83.249.54]:57800 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750729AbWFSAyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 20:54:52 -0400
Message-ID: <4495F5C3.1030203@zytor.com>
Date: Sun, 18 Jun 2006 17:54:27 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Greg KH <gregkh@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [GIT PATCH] Remove devfs from 2.6.17
References: <20060618221343.GA20277@kroah.com> <20060618230041.GG4744@bouh.residence.ens-lyon.fr>
In-Reply-To: <20060618230041.GG4744@bouh.residence.ens-lyon.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault wrote:
> 
> There has been at least my complaint about udev not being able to
> auto-load modules on /dev entry lookup (28th March 2006):
> 
> « Given a freshly booted linux box, hence uinput is not loaded (why
> would it be, it doesn't drive any real hardware) ; what is the right
> way(tm) for an application to have the uinput module loaded, so that it
> can open /dev/input/uinput for emulating keypresses?
> 
> - With good-old static /dev, we could just open /dev/input/uinput
>   (installed by the distribution), and thanks to a
>   alias char-major-10-223 uinput
>   line somewhere in /etc/modprobe.d, uinput gets auto-loaded.
> 
> - With devfs, it doesn't look like it works (/dev/misc/uinput is not
>   present and opening it just like if it existed doesn't work). But I
>   read in archives that it could be feasible.
> 
> - With udev, this just cannot work. As explained in an earlier thread,
>   even using a special filesystem that would report the opening attempt
>   to udevd wouldn't work fine since udevd takes time for creating the
>   device, and hence the original program needs to be notified ; this
>   becomes racy.
> 

It would be nice if udev could be fed not just from the kernel, but from 
the repository of modules that are available for loading.  That may 
require additional module information.

	-hpa
