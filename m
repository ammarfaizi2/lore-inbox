Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261294AbTCJLRa>; Mon, 10 Mar 2003 06:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbTCJLRa>; Mon, 10 Mar 2003 06:17:30 -0500
Received: from ns.suse.de ([213.95.15.193]:63496 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261294AbTCJLRa>;
	Mon, 10 Mar 2003 06:17:30 -0500
Date: Mon, 10 Mar 2003 12:28:10 +0100
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: sys32_ioctl -> compat_ioctl -- generic
Message-ID: <20030310112810.GC9581@wotan.suse.de>
References: <20030303232122.GA24018@elf.ucw.cz> <20030305103619.52ccdfe2.sfr@canb.auug.org.au> <20030306233721.GA8565@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030306233721.GA8565@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +{
> > > +	struct file * filp;
> > 
> > > +	filp = fget(fd);
> > 
> > > +			/* find the name of the device. */
> > > +			if (path) {
> > > +				struct file *f = fget(fd); 
> > 
> > Is it really necessary to do another fget(fd) ?
> 
> This is andi's code, but it seems unneeded, fixed.

Yes, it's redundant.

-Andi

