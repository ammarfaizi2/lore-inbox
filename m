Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSGVAw3>; Sun, 21 Jul 2002 20:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSGVAw2>; Sun, 21 Jul 2002 20:52:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:6649 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S315431AbSGVAw2>; Sun, 21 Jul 2002 20:52:28 -0400
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A9
From: Robert Love <rml@tech9.net>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020722014018.A31813@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0207211619480.9993-100000@home.transmeta.com>
	<Pine.LNX.4.44.0207220224170.4909-100000@localhost.localdomain> 
	<20020722014018.A31813@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 21 Jul 2002 17:55:26 -0700
Message-Id: <1027299327.931.3.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 17:40, Russell King wrote:
> On Mon, Jul 22, 2002 at 02:31:16AM +0200, Ingo Molnar wrote:
> > +drivers that want to disable local interrupts (interrupts on the
> > +current CPU), can use the following four macros:
> > +
> > +  __cli(), __sti(), __save_flags(flags), __restore_flags(flags)
> 
> Last mail before zzz (hopefully) - what about
> local_irq_{enable,disable,save,restore} ?
> 
> With the exception of local_irq_save() which is actually
> local_irq_save_disable(), I find these to be more "descriptive" of
> their function.

Yes and double yes.

And for two reasons: First, the __ prefix is unnecessary now.  Second,
not all the world is an x86 (it just looks that way).

local_irq_foo is definitely preferred.

I'd make the patch and go through the effort to rename and replace if
Linus assured me it was in.

	Robert Love

