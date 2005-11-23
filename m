Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVKWWQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVKWWQB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVKWWQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:16:01 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20489 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932277AbVKWWP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:15:59 -0500
Date: Wed, 23 Nov 2005 22:15:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@stusta.de>, saw@saw.sw.com.sg,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
Message-ID: <20051123221547.GM15449@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Adrian Bunk <bunk@stusta.de>, saw@saw.sw.com.sg,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
References: <20051118033302.GO11494@stusta.de> <20051118090158.GA11621@flint.arm.linux.org.uk> <437DFD6C.1020106@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437DFD6C.1020106@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 11:12:28AM -0500, Jeff Garzik wrote:
> Russell King wrote:
> >On Fri, Nov 18, 2005 at 04:33:02AM +0100, Adrian Bunk wrote:
> >
> >>This patch removes the obsolete drivers/net/eepro100.c driver.
> >>
> >>Is there any reason why it should be kept?
> >
> >
> >Tt's the only driver which works correctly on ARM CPUs.  e100 is
> >basically buggy.  This has been discussed here on lkml and more
> >recently on linux-netdev.  If anyone has any further questions
> >please read the archives of those two lists.
> 
> After reading the archives, one discovers the current status is:
> 
> 	waiting on ARM folks to test e100
> 
> Latest reference is public message-id <4371A373.6000308@pobox.com>, 
> which was CC'd to you.
> 
> There is a patch in netdev-2.6.git#e100-sbit and in Andrew's -mm tree 
> that should solve the ARM problems, and finally allow us to kill 
> eepro100.  But it's waiting for feedback...

Well, I've run 2.6.15-rc2 on what I think was the ARM platform which
exhibited the problem, but it doesn't show up.  However, that's
meaningless as it has been literally _years_ (4 or more) since the
problem was reported.  It's rather unsurprising that I can't reproduce
it - I don't even know if I'm using the right processor module!

It's far too late to try swapping modules and rebuilding everything
(if I can find the code for the boot loader still.)  Also since this
platform is being returned to whence it came tomorrow, I lose the
ability to test this.

I've been struggling all day trying to get the kernel back up and
running on this hardware due to various issues with sizes of kernels
and mtd/jffs2 incompatibilities with the jffs2 filesystem in flash.

So, all in all, resolving this issue has taken far too long and it is
now far too late to do any kind of positive testing.

I leave it up to you how to proceed.  Effectively I'm now completely
out of the loop on this with no hardware to worry about.  Sorry.

Finally, please don't assign any blame for this in my direction; I
reported it and I kept bugging people about it, and in spite of my
best efforts there was very little which was forthcoming.  Obviously
that wasn't enough.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
