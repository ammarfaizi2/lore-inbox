Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVB0VEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVB0VEO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 16:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVB0VEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 16:04:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:31439 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261290AbVB0VEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 16:04:08 -0500
Date: Sun, 27 Feb 2005 13:03:33 -0800
From: Greg KH <greg@kroah.com>
To: Michal Januszewski <spock@gentoo.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Bootsplash for 2.6.11-rc4
Message-ID: <20050227210333.GA18820@kroah.com>
References: <20050218165254.GA1359@elf.ucw.cz> <20050219011433.GA5954@spock.one.pl> <20050219230326.GB13135@kroah.com> <20050219232519.GC1372@elf.ucw.cz> <20050220132600.GA19700@spock.one.pl> <20050227165420.GD1441@elf.ucw.cz> <1109532700.15362.42.camel@laptopd505.fenrus.org> <20050227195206.GA2202@spock.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050227195206.GA2202@spock.one.pl>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 08:52:06PM +0100, Michal Januszewski wrote:
> On Sun, Feb 27, 2005 at 08:31:39PM +0100, Arjan van de Ven wrote:
> 
> > well.. how much does it really need in kernel space? I mean, with all
> > drivers as modules, and the "quiet" option, initramfs runs *really*
> > fast. And that can just bang a bitmap to the framebuffer as first
> > thing... (rhgb does it a bit later but that's a design choice in a
> > feature vs early-boot tradeoff).
> 
> Most of the code in fbsplash handles the so-called 'verbose' mode,
> ie. displaying a pretty picture in the background of the consoles. 
> The 'silent' mode (progress bar and stuff) can be brought down to 
> a single call to a userspace helper which can paint the initial bitmap
> or do whatever else it wants to do. In fact, this is how it works now.
> However, fbsplash currently not only calls the helper, but also tracks
> whether we're running in the 'silent' mode or in the 'verbose' mode. 
> I plan to remove that functionality, so we'll be left with the
> following: 
> - silent is handled 100% by userspace

Care to create a patch for the silent mode now?  That should be simple
enough to get into the kernel, and will be a good place to build off of
for the rest of the things people want (verbose mode, etc.)

thanks,

greg k-h
