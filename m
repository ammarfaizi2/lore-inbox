Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262807AbSKRPKu>; Mon, 18 Nov 2002 10:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbSKRPKu>; Mon, 18 Nov 2002 10:10:50 -0500
Received: from ns.suse.de ([213.95.15.193]:56592 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262807AbSKRPKt>;
	Mon, 18 Nov 2002 10:10:49 -0500
Date: Mon, 18 Nov 2002 16:17:50 +0100
From: Andi Kleen <ak@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] early printk for x86
Message-ID: <20021118161750.A32042@wotan.suse.de>
References: <3DD3FCB3.40506@us.ibm.com> <14814.1037632523@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14814.1037632523@passion.cambridge.redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 03:15:23PM +0000, David Woodhouse wrote:
> 
> haveblue@us.ibm.com said:
> >  1.	 I copied the x86_64 early printk support for plain x86.  Is
> > anyone  opposed to me sending this on to Linus?
> 
> Why is it necessary to reimplement serial console for each arch rather than
> just registering the generic serial console as early as possible from
> arch-specific code?
> 
> There's no _reason_ to wait for console_init(), for most consoles.

The generic serial driver needs lots of infrastructure that is not present
in early boot. Also the early_printk serial driver is polled, not
interrupt driven. The whole point of early_printk is that you can debug
from line one of your code, so it is essential that it is self contained
as far as possible.

-Andi
