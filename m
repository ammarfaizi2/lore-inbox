Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263154AbUEWQ1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUEWQ1i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 12:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbUEWQ1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 12:27:38 -0400
Received: from mail.kroah.org ([65.200.24.183]:19948 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263154AbUEWQ1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 12:27:36 -0400
Date: Sun, 23 May 2004 09:25:46 -0700
From: Greg KH <greg@kroah.com>
To: Erik Steffl <steffl@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev and /dev/sda1 not found during boot (it's there right after boot)
Message-ID: <20040523162546.GA6500@kroah.com>
References: <408A1945.1030506@bigfoot.com> <20040424155507.GA11273@kroah.com> <40B0C9BB.4020304@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B0C9BB.4020304@bigfoot.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 08:56:43AM -0700, Erik Steffl wrote:
> Greg KH wrote:
> >On Sat, Apr 24, 2004 at 12:37:41AM -0700, Erik Steffl wrote:
> >
> >> just moved to udev and everything seems to be working OK except of 
> >>SATA drive (visible as /dev/sda1) when fsck checks it during boot (it 
> >>works fine right after that).
> >
> >
> >This is a Debian specific bug/issue.  I suggest you file it against the
> >Debian udev package, as it is not a kernel issue.
> 
>   why would you think it's debian specific issue?

Because it doesn't happen on my Gentoo or Red Hat based systems? :)

>   btw if I add sleep at the beginning of /etc/init.d/checkfs.sh (runs 
> fsck for all filesystems) everythings works. Which I guess confirms that 
> there is some delay between when the module is loaded and when the 
> device is available in userspace. Is that how udev works? How can this 
> issue be solved?

As you point out, this is all in how udev is handled by the boot
scripts, if they wait long enough for the device node to show up before
continuing on or not.  Thereby showing that this is a distro specific
issue.

Now the Debian maintainer of udev has said that you should also read the
README file for udev for more information about this type of issue.  I
suggest you go through the Debian bug reporting process for further
help.

Good luck,

greg k-h
