Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262574AbTCISzb>; Sun, 9 Mar 2003 13:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262575AbTCISzb>; Sun, 9 Mar 2003 13:55:31 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2820 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262574AbTCISy3>;
	Sun, 9 Mar 2003 13:54:29 -0500
Date: Fri, 7 Mar 2003 00:37:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: sys32_ioctl -> compat_ioctl -- generic
Message-ID: <20030306233721.GA8565@elf.ucw.cz>
References: <20030303232122.GA24018@elf.ucw.cz> <20030305103619.52ccdfe2.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030305103619.52ccdfe2.sfr@canb.auug.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +asmlinkage long compat_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
> 
> For consistancy, this should be called compat_sys_ioctl.

Done. (And moved whole stuff to fs/compat.c).

> > +{
> > +	struct file * filp;
> 
> > +	filp = fget(fd);
> 
> > +			/* find the name of the device. */
> > +			if (path) {
> > +				struct file *f = fget(fd); 
> 
> Is it really necessary to do another fget(fd) ?

This is andi's code, but it seems unneeded, fixed.

> Also, if you are adding this much code, you should add a copyright notice
> to the top of the file ...

I actually need to copy copyrights from ia32_ioctl, where I took
this. Done.
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
