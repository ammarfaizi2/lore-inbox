Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbVKWWYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbVKWWYW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbVKWWYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:24:21 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4624 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030424AbVKWWYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:24:18 -0500
Date: Wed, 23 Nov 2005 22:24:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       saw@saw.sw.com.sg, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC: 2.6 patch] remove drivers/net/eepro100.c
Message-ID: <20051123222410.GN15449@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Adrian Bunk <bunk@stusta.de>, saw@saw.sw.com.sg,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
References: <20051118033302.GO11494@stusta.de> <20051118090158.GA11621@flint.arm.linux.org.uk> <437DFD6C.1020106@pobox.com> <20051123221547.GM15449@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123221547.GM15449@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 10:15:48PM +0000, Russell King wrote:
> On Fri, Nov 18, 2005 at 11:12:28AM -0500, Jeff Garzik wrote:
> > Russell King wrote:
> > >On Fri, Nov 18, 2005 at 04:33:02AM +0100, Adrian Bunk wrote:
> > >
> > >>This patch removes the obsolete drivers/net/eepro100.c driver.
> > >>
> > >>Is there any reason why it should be kept?
> > >
> > >
> > >Tt's the only driver which works correctly on ARM CPUs.  e100 is
> > >basically buggy.  This has been discussed here on lkml and more
> > >recently on linux-netdev.  If anyone has any further questions
> > >please read the archives of those two lists.
> > 
> > After reading the archives, one discovers the current status is:
> > 
> > 	waiting on ARM folks to test e100
> > 
> > Latest reference is public message-id <4371A373.6000308@pobox.com>, 
> > which was CC'd to you.
> > 
> > There is a patch in netdev-2.6.git#e100-sbit and in Andrew's -mm tree 
> > that should solve the ARM problems, and finally allow us to kill 
> > eepro100.  But it's waiting for feedback...
> 
> Well, I've run 2.6.15-rc2 on what I think was the ARM platform which
> exhibited the problem, but it doesn't show up.  However, that's
> meaningless as it has been literally _years_ (4 or more) since the
> problem was reported.  It's rather unsurprising that I can't reproduce
> it - I don't even know if I'm using the right processor module!

Additionally, looking back at my 30th June 2004 message, I don't
think I've even managed sufficient testing to make any claim of
working-ness or non-working-ness against either driver.

The test was merely a "did it successfully BOOTP" because I can't
get it to mount and run /sbin/init from the jffs2 rootfs which
2.5.70 was perfectly happy to earlier today.  However, the
failure point seemed to be when NFS tried to use the card.

Whether that means I was or was not using BOOTP back in 2004...
your guess is as good as mine.

Anyway, that's the end of the issue as far as I'm concerned.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
