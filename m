Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965159AbVKBSME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbVKBSME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbVKBSME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:12:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8722 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965159AbVKBSMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:12:03 -0500
Date: Wed, 2 Nov 2005 19:12:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Roland Dreier <rolandd@cisco.com>, Andrew Morton <akpm@osdl.org>,
       zippel@linux-m68k.org, ak@suse.de, rmk+lkml@arm.linux.org.uk,
       tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
Message-ID: <20051102181201.GB4272@stusta.de>
References: <20051031160557.7540cd6a.akpm@osdl.org> <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org> <20051031163408.41a266f3.akpm@osdl.org> <52y847abjm.fsf@cisco.com> <Pine.LNX.4.64.0511012142200.27915@g5.osdl.org> <52u0eva8yu.fsf@cisco.com> <Pine.LNX.4.64.0511012203370.27915@g5.osdl.org> <52ll07a844.fsf@cisco.com> <Pine.LNX.4.64.0511020746330.27915@g5.osdl.org> <20051102174852.GB1899@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102174852.GB1899@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 12:48:52PM -0500, Dave Jones wrote:
> On Wed, Nov 02, 2005 at 07:54:04AM -0800, Linus Torvalds wrote:
> 
>  > > For your last suggestion, maybe someone can automate running Andi's
>  > > bloat-o-meter?  I think the hard part is maintaining comparable configs.
>  > 
>  > Yes. And we should probably make -Os the default. Apparently Fedora 
>  > already does that by just forcibly hacking the Kconfig files.
> 
> (excuse any typos, this wireless connection is god-awful)
> We do. We rip out the dependancyon CONFIG_EMBEDDED, and build
> with OPTIMISE_FOR_SIZE set. At least we usually do.
> Once every so often, we hit something which throws a spanner
> in the works, like the "x86-64 doesn't boot any more" problem
> that was fixed by the patch that Alexandre posted earlier
> this week.
> 
> Most of the time now, when we hit bugs with -Os, it seems to be due
> to broken asm constraints in the kernel rather than actual
> gcc bugs, but of course, they also occur from time to time,
> whereas the same code works just fine with -O2.
> I think part of th reason for this is exactly because it
> doesn't get a great deal of testing.

Is the usage of -Os in Fedora based on actual measurements?

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

