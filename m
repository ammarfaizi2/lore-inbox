Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbUKSMbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbUKSMbS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 07:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbUKSM3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 07:29:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45581 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261372AbUKSM2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 07:28:35 -0500
Date: Fri, 19 Nov 2004 13:28:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Paul Menage <menage@google.com>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] RFC: let x86_64 no longer define X86
Message-ID: <20041119122827.GB22981@stusta.de>
References: <20041119005117.GM4943@stusta.de> <6599ad8304111817317880dfe5@mail.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6599ad8304111817317880dfe5@mail.google.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 05:31:14PM -0800, Paul Menage wrote:
> On Fri, 19 Nov 2004 01:51:17 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> > I'd like to send a patch after 2.6.10 that removes the following from
> > arch/x86_64/Kconfig:
> > 
> >   config X86
> >         bool
> >         default y
> > 
> > Additionally, I'll also check all current X86 uses to prevent breakages.
> 
> Or, you could define an X86_32 config symbol in i386. This seems a
> little more backward compatible, and means that you can continue to
> just test X86 for the rather large set of code that works fine on both
> 32-bit and 64-bit.
> 
> I guess it depends on whether you think there are more places in the
> generic code that the two architectures share code, vs places that are
> 32-bit only.

We are not talking about thousands of places.

We are talking about less than hundred places.

And many people do currently get it wrong like with CONFIG_LBD.

The most important improvement would be to prevent such bugs and to have 
the X86_64 dependency explicitely stated.

The #ifdef CONFIG_X86 in init/main.c is an example where it currently 
takes some time to understand whether it's correct or a bug.

X86_32 would be a solution, but it would IMHO also create confusion 
since i386 and ia64 also have some things in common (e.g. ACPI support).
The cleanest thing is simply, to state X86_64 dependencies explicitely.

> Paul

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

