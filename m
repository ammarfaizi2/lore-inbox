Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311652AbSCNQcr>; Thu, 14 Mar 2002 11:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311659AbSCNQch>; Thu, 14 Mar 2002 11:32:37 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:43106 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311652AbSCNQcZ>; Thu, 14 Mar 2002 11:32:25 -0500
Date: Thu, 14 Mar 2002 17:32:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Jones <davej@suse.de>, Bill Davidsen <davidsen@tmr.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre3aa2
Message-ID: <20020314173212.K22054@dualathlon.random>
In-Reply-To: <20020314133223.B19636@suse.de> <Pine.LNX.3.96.1020314104230.9248A-100000@gatekeeper.tmr.com> <20020314171259.I22054@dualathlon.random> <20020314171620.I19636@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020314171620.I19636@suse.de>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 05:16:20PM +0100, Dave Jones wrote:
> On Thu, Mar 14, 2002 at 05:12:59PM +0100, Andrea Arcangeli wrote:
>  > Correct. I think the CONFIG option isn't worthwhile in the first place
>  > and this is why I only left the CONFIG_M686 knowing most smp kernels are
>  > compiled that way.  4096bytes of virtual vmallc space and some houndred
>  > bytes of bytecode doesn't worth the config option. If something the
>  > CONFIG_F00F would be more a documentation effort 8).
>  
>  nononono! CONFIG_FOOF is a derived symbol from whatever CONFIG_Mx8x
>  is set. Much in the way we derive CONFIG_X86_WP_WORKS_OK, CONFIG_X86_PPRO_FENCE
>  and freinds.. 

Of course I perfectly understood what you meant. I designed the current
way of doing the CONFIG_X86 some years back so I know what you mean.

Just re-read the previous email with that in mind. What I meant is that
4096bytes of virtual vmalloc space doesn't worth a CONFIG_F00F IMHO.
While CONFIG_F00F isn't wasted user time because the user won't see it,
it still clobbers the source code, but nevertheless it is better than
the current halfway broken #ifdef CONFIG_M686 and that's why I said if
somebody bothers to verymicrooptimize I'm ok, I just won't microoptimize
myself and I'd drop CONFIG_M686 instead.

Andrea
