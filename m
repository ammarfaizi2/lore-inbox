Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUBZOcx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 09:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUBZOcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 09:32:53 -0500
Received: from server1.mpc.com.br ([200.246.0.242]:33298 "EHLO
	server1.mpc.com.br") by vger.kernel.org with ESMTP id S261351AbUBZOck
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 09:32:40 -0500
From: glauber@mpcnet.com.br
Date: Thu, 26 Feb 2004 11:02:55 -0300
To: Ryan Reich <ryanr@uchicago.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: help in sysfs
Message-ID: <20040226140255.GB1361@zion.matrix>
References: <1tltA-427-3@gated-at.bofh.it> <403D8643.6000909@uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403D8643.6000909@uchicago.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was mounted, as told me by mount(1)

but, I think it was a problem in the order of the mounts
maybe it was mounted over the old /dev
I mounted it again, and it worked fine. (at least, the pts
others things remais)
But, this brings me another doubt (an extension to the first
one):
Why there is not any information about the pts in /sys ?
There is only a directory entry called
/sys/cdev/tty/pts
May I conclude that there is no info avaiable about chardevs?

One more to go:
I use PPPoE to connect to the net. When I loaded the modules,
some entries apeared somewhere in /sys/udev, but the /dev
entry was not created, and I had to mknod it
Does anyone knows why ?

I may be (very) wrong, but it seems to be a behaviour common
to chardevs


On Wed, Feb 25, 2004 at 11:38:11PM -0600, Ryan Reich wrote:
> glauber@mpcnet.com.br wrote:
> >Sorry if I'm being redundant
> >
> >I spent a lot of time looking for it, and did 
> >not find, so I came here for help
> >Perhaps anyone can help me, or point me to the 
> >right place to ask
> >
> >I did not yet fully understand how sysfs works, 
> >and so, any docs would be welcome
> >
> >My main problem is: 
> >I'm trying to use udev, but some devices for
> >drivers that are compiled in the kernel does
> >not appear in. I searched for entries 
> >representing then in /sys, and found no one
> >Specifically, no pts is found there
> >in my .config, I have CONFIG_UNIX98_PTYS=y
> >What can I do in order to solve this problem?
> 
> Have you mounted /dev/pts?
> 
> $ mount -t devpts devpts /dev/pts
> 
> (Of course, /dev/pts needs to exist first).  They should appear when you 
> connect to a terminal.
> 
> Also, not all the supported devices have yet been ported to sysfs.
> 
> -- 
> Ryan Reich
> ryanr@uchicago.edu
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Fortune:

"What's the use of a good quotation if you can't change it?"
		-- The Doctor
---
Software Livre 
Tecnologia para um mundo melhor
==============================
Glauber de Oliveira Costa
e-mail: glauber@mpcnet.com.br
jabber: glommer@jabber.org
ICQ # : 18419549
Phone: +55 19 32892120
==============================

