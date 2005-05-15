Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVEOMiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVEOMiF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 08:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbVEOMiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 08:38:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1297 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261622AbVEOMh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 08:37:58 -0400
Date: Sun, 15 May 2005 14:37:31 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] i386: enable REGPARM by default
Message-ID: <20050515123729.GT16549@stusta.de>
References: <20050515115712.GQ16549@stusta.de> <m1acmwadbp.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1acmwadbp.fsf@muc.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2005 at 02:22:34PM +0200, Andi Kleen wrote:
> Adrian Bunk <bunk@stusta.de> writes:
> 
> > This patch should _not_ go into Linus' tree.
> >
> > At some time in the future, we want to unconditionally enable REGPARM on 
> > i386.
> >
> > Let's give it a bit broader testing coverage among -mm users.
> 
> iirc problem is that gcc 2.95 and possibly 3.0.x have some known
> miscompilations with regparams. That is why it was only used
> with fastcall for a long time. One 3.1.x+ it should be safe.
> But you cannot express dependencies on the compiler version
> in Kconfig right now.
> 
> Of course getting rid of gcc 2.95 and 3.0.x support would be a good idea,
> that would allow many other nice things.

If you'd read either arch/i386/Makefile or the help text for 
CONFIG_REGPARM, you'd have noticed that we do never use regparm with
gcc < 3.0 .

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

