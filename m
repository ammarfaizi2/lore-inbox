Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVGaWL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVGaWL6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbVGaWL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:11:58 -0400
Received: from web30303.mail.mud.yahoo.com ([68.142.200.96]:11944 "HELO
	web30303.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261992AbVGaWL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:11:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=x3ZNhxOTVpTQ3jJ97zAY966kxFhUyF+A06FkdzmjPQHi/Fjeu+t8Gqut2bED+wNNvp2gBMfjg7a/dwOvLYB+5ftC5ZlHpHhc1EbDWvEGYu9ekT4Gc1VEWPCbv+j2qI5SRCtMuJwnoETrpzVbq9ORkNgAym2Joup/9Tplpuvs+9c=  ;
Message-ID: <20050731221152.71074.qmail@web30303.mail.mud.yahoo.com>
Date: Sun, 31 Jul 2005 23:11:52 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [patch] ucb1x00: touchscreen cleanups
To: Russell King <rmk+lkml@arm.linux.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Arjan Van de Ven <arjanv@redhat.com>,
       Christoph Hellwig <hch@infradead.org>
Cc: Mark Underwood <basicmark@yahoo.com>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050730220340.K26592@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Sat, Jul 30, 2005 at 10:46:58PM +0200, Pavel
> Machek wrote:
> > Hi!
> > 
> > > > > Note that I'm maintaining the code and will
> be
> > > > > publishing a new set
> > > > > of patches for it based upon Pavel's fixes.
> > > > 
> > > > Thanks. I'll check them out then.
> > > 
> > > Since there appears to be some interest in
> these, I'll set about
> > > converting the audio bits to ALSA rather than
> Nico's SA11x0 audio
> > > driver.  I thought no one was using these chips
> anymore, and the
> > > driver was dead!
> > > 
> > > I've recently edited the mcp structure which may
> make things less
> > > awkward for others, and I'll continue moving in
> that direction
> > > with this driver.
> > > 
> > > You can get the updated patches at:
> > > 
> > > 	http://zeniv.linux.org.uk/pub/people/rmk/ucb/
> > 
> > Okay, what's the plan with mainstreaming those? Do
> they stay in
> > drivers/misc?
> 
> Let me put the second question a slightly different
> way: can anyone
> think of a better way to organise the files which
> makes more sense
> and doesn't end up with just a couple of files for
> the core UCB
> and MCP support in some random directory elsewhere?
> 
> Arjan?  hch?  any comments / good ideas?

As this isn't the only chip of this sort (i.e. a
multi-function chip not on the CPU bus) maybe we
should store the bus driver in a common place. If
needed we could have a very simple bus driver
subsystem (this might already be in the kernel, I
haven't looked at the bus stuff) in which you register
a bus driver and client drivers register with the bus
driver. Just an idea :-).

Mark

> 
> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   -
> http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
___________________________________________________________ 
How much free photo storage do you get? Store your holiday 
snaps for FREE with Yahoo! Photos http://uk.photos.yahoo.com
