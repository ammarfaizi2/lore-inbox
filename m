Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbTCJQQx>; Mon, 10 Mar 2003 11:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbTCJQQx>; Mon, 10 Mar 2003 11:16:53 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:43792 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261347AbTCJQP1>; Mon, 10 Mar 2003 11:15:27 -0500
Date: Mon, 10 Mar 2003 17:25:49 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries Brouwer <aebr@win.tue.nl>
cc: Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: struct inode size reduction.
In-Reply-To: <20030310120534.GA4125@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0303101620020.5042-100000@serv>
References: <20030309135402.GB32107@suse.de> <20030309171314.GA3783@win.tue.nl>
 <20030309203359.GA7276@suse.de> <20030309195555.A22226@infradead.org>
 <20030309203144.GA3814@win.tue.nl> <Pine.LNX.4.44.0303092310470.32518-100000@serv>
 <20030309230824.GA3842@win.tue.nl> <Pine.LNX.4.44.0303101100250.5042-100000@serv>
 <20030310120534.GA4125@win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Mar 2003, Andries Brouwer wrote:

> > > -       error = register_chrdev(driver->major, driver->name, &tty_fops);
> > > +       error = register_chrdev_region(driver->major, driver->minor_start,
> > > +                                      driver->num, driver->name, &tty_fops);
> > 
> > Are that much parameters really needed?
> 
> Yes.

Why? Problems are hardly solved by adding more parameters.
If going to a larger number space means, that we have to add crappy 
interfaces, we should rather keep it as it is.
Why do you need to partition the number space like this? I looked at the 
users in the last mail for a reason. If we're going to change the 
interface, it should reflect what we will need in the future.

bye, Roman

