Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131562AbRDBX5V>; Mon, 2 Apr 2001 19:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131573AbRDBX5L>; Mon, 2 Apr 2001 19:57:11 -0400
Received: from ns.suse.de ([213.95.15.193]:41734 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131562AbRDBX47>;
	Mon, 2 Apr 2001 19:56:59 -0400
Date: Tue, 3 Apr 2001 01:53:30 +0200
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andi Kleen <ak@suse.de>, "J . A . Magallon" <jamagallon@able.es>,
   linux-kernel@vger.kernel.org
Subject: Re: [PATCH] multiline string cleanup
Message-ID: <20010403015330.A31118@gruyere.muc.suse.de>
In-Reply-To: <20010330234804.A27780@werewolf.able.es> <oupd7avyng5.fsf@pigdrop.muc.suse.de> <3AC9102C.D053506F@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AC9102C.D053506F@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Apr 02, 2001 at 07:50:04PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2001 at 07:50:04PM -0400, Jeff Garzik wrote:
> Andi Kleen wrote:
> > "J . A . Magallon" <jamagallon@able.es> writes:
> > > This is one other try to make kernel sources gcc-3.0 friendly. This cleans
> > > some muti-line asm strings in checksum.h and floppy.h (this were the only
> > > ones reported in my kernel build, perhaps there are more in drivers I do
> > > not use).
> 
> > I surely hope the gcc guys will just remove that silly warning again, because
> > it makes it impossible to write readable inline assembly now.
> 
> If it's a silly warning, then we should turn it off in linux/Makefile. 
> I dunno that the kernel can dictate to gcc here what to do...

It unfortunately cannot be turned off ATM (it is "deprecation warning" where
someone is trying to warn you that the next release of gcc may not support
multi line strings anymore). 

> Also some multiline string cleanups have already made it into the kernel
> -- though that is not conclusive, as it may just be maintainer
> preference.

Longer inline assembly without multi strings is hard to read and very nasty
to edit, so I don't see that as a "cleanup", but as a pessimization towards
less maintainable code.


-Andi

