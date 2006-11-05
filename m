Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965818AbWKEDrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965818AbWKEDrP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 22:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965819AbWKEDrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 22:47:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29079 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965818AbWKEDrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 22:47:14 -0500
Date: Sat, 4 Nov 2006 19:46:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: lib/iomap.c mmio_{in,out}s* vs. __raw_* accessors
In-Reply-To: <1162697533.28571.131.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0611041946020.25218@g5.osdl.org>
References: <1162626761.28571.14.camel@localhost.localdomain> 
 <20061104140559.GC19760@flint.arm.linux.org.uk>  <1162678639.28571.63.camel@localhost.localdomain>
  <Pine.LNX.4.64.0611041544030.25218@g5.osdl.org> 
 <1162689005.28571.118.camel@localhost.localdomain>
 <1162697533.28571.131.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Nov 2006, Benjamin Herrenschmidt wrote:
>
> Make the generic lib/iomap.c use arch provided MMIO accessors when
> available for big endian and repeat operations. Also while at it,
> fix the *_be version which are currently broken for PIO

Just rip the _be versions out, methinks.

Also, what does your "writesb()" actually look like? I assume it's the 
exact same thing as the generic one, with just another barrier. No? 

		Linus
