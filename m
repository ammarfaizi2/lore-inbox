Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVIJV4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVIJV4S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 17:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVIJV4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 17:56:18 -0400
Received: from mail.kroah.org ([69.55.234.183]:16263 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932232AbVIJV4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 17:56:18 -0400
Date: Sat, 10 Sep 2005 14:52:54 -0700
From: Greg KH <gregkh@suse.de>
To: Mike Bell <mike@mikebell.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.13
Message-ID: <20050910215254.GA15645@suse.de>
References: <20050909214542.GA29200@kroah.com> <20050910082732.GR13742@mikebell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910082732.GR13742@mikebell.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 01:27:34AM -0700, Mike Bell wrote:
> On Fri, Sep 09, 2005 at 02:45:42PM -0700, Greg KH wrote:
> > Also, if people _really_ are in love with the idea of an in-kernel
> > devfs, I have posted a patch that does this in about 300 lines of code,
> > called ndevfs.
> 
> Except that as I mentioned, it's broken by design. It creates yet
> another incompatible naming scheme for devices, and what's worse the
> devices it breaks are the ones like ALSA and the input subsystem, whose
> locations are hard-coded into libraries. Unless sysfs is going to get
> attributes from which the proper names could be derived, it won't ever
> work.

I didn't say it was a "nice" solution, fully LSB compliant and all.  All
it is is a solution that can work for some people, if they just want a
small, in-kernel devfs-like solution.

And it works just fine for alsa and input devices for me, just no
subdirs :)

Anyway, I'm not offering it up for inclusion in the kernel tree at all,
but for a proof-of-concept for those who were insisting that it was
impossible to keep a devfs-like patchset out of the main kernel tree
easily.

thanks,

greg k-h
