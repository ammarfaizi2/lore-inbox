Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSKNEUq>; Wed, 13 Nov 2002 23:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261529AbSKNEUq>; Wed, 13 Nov 2002 23:20:46 -0500
Received: from dp.samba.org ([66.70.73.150]:56292 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261446AbSKNEUp>;
	Wed, 13 Nov 2002 23:20:45 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: kaos@ocs.com.au, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Modules in 2.5.47-bk... 
In-reply-to: Your message of "Wed, 13 Nov 2002 23:06:42 CDT."
             <3DD32152.3020909@pobox.com> 
Date: Thu, 14 Nov 2002 16:22:10 +1100
Message-Id: <20021114042738.2091E2C080@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DD32152.3020909@pobox.com> you write:
> Rusty Russell wrote:
> The backward compat thing is really a hack, and not system software done 
> right :(  modutils should not need to rename all its binaries *.old -- 
> and have that be the default that users see when installing the rpm.  No 
> company worth its shareholders would release a package full of "*.old" 
> binaries.  Come on...

OK, would calling it "*-2.4" or something help?

> foo.old is not a solution we want with us long-term... and booting into 
> older kernels will be with us long-term.

Execing the older binary is a good way to make a clean break in the
source.  It means we can keep separate maintainers and not worry about
syncing issues, too (Keith has said he doesn't want to maintain
modules in 2.5, fair enough)

There are other ways to do the same thing, bu this seemed simplest.

> Well, that more than satisfies my objection here, then.  Thanks.

Sorry if I was a bit sharp.  I've been surprised by the "I'm going to
have to abandon 2.5 kernel development now" reaction.  Some people
seem upset that I didn't respond to mail for 12 hours 8( I also
haven't spoken to my wife for over 48 hours because I've been on the
modem in my hotel room every time she's been awake.

> I only saw ia32 modifications go into the kernel... I'm glad others
> have been tested, or at least played with, on multiple
> architectures.  I'm sure if rth doesn't tackle alpha module loading,
> Ivan or I will have it done :)

Unfortunately the Alpha ELF spec is in RTH's head.  I have a userspace
framework I can send you (faster than debugging linking inside the
kernel) which you can hack for Alpha.

To see what's coming, look for the "Modules" section:

	http://www.kernel.org/pub/linux/kernel/people/rusty

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
