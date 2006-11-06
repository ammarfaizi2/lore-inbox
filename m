Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423290AbWKFC4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423290AbWKFC4m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 21:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423299AbWKFC4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 21:56:42 -0500
Received: from gate.crashing.org ([63.228.1.57]:11736 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1423290AbWKFC4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 21:56:41 -0500
Subject: Re: lib/iomap.c mmio_{in,out}s* vs. __raw_* accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <1162704529.28571.164.camel@localhost.localdomain>
References: <1162626761.28571.14.camel@localhost.localdomain>
	 <20061104140559.GC19760@flint.arm.linux.org.uk>
	 <1162678639.28571.63.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611041544030.25218@g5.osdl.org>
	 <1162689005.28571.118.camel@localhost.localdomain>
	 <1162697533.28571.131.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611041946020.25218@g5.osdl.org>
	 <1162699255.28571.150.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611042013400.25218@g5.osdl.org>
	 <1162701537.28571.156.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611042054210.25218@g5.osdl.org>
	 <1162703335.28571.159.camel@localhost.localdomain>
	 <1162704529.28571.164.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 13:56:03 +1100
Message-Id: <1162781764.28571.275.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok, your patch builds fine here. I can't test at the moment as I don't
> have a machine at hand that has a device whose driver uses the ops in
> iomap though, but I can't see any reason why it wouldn't work if it
> builds, so as far as I'm concerned, that's good to go in 2.6.20.
> (earlier if you wish but I won't submit the patch doing the powerpc
> changes that makes me use those change before 2.6.20 obviously :-)

In fact, you might want to push it to 2.6.19 since it fixes a bug
(current _be operations are incorrect for PIO without the patch).

Cheers,
Ben.

