Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVCNRQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVCNRQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVCNRQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:16:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:61640 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261596AbVCNRQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:16:46 -0500
Date: Mon, 14 Mar 2005 09:18:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
cc: Pavel Machek <pavel@ucw.cz>, David Lang <david.lang@digitalinsight.com>,
       Dave Jones <davej@redhat.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
In-Reply-To: <200503140855.18446.jbarnes@engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0503140907380.6119@ppc970.osdl.org>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz> <20050314083717.GA19337@elf.ucw.cz>
 <200503140855.18446.jbarnes@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Mar 2005, Jesse Barnes wrote:
> 
> We already have the 'quiet' option, but even so, I think the kernel is *way* 
> too verbose.  Someone needs to make a personal crusade out of removing 
> unneeded and unjustified printks from the kernel before it really gets better 
> though...

The thing is, this comes up every once in a while (pretty often,
actually), but the bulk of those messages _do_ end up being useful. For
certain classes of bugs, I almost invariably ask for the bootup messages:  
the PCI interrupt routing printou stuff is absolutely invaluable.

In fact, even the ones that have no "information" end up often being a big
clue about where the hang happened.

So yes, when things work (and hey, that's happily 99.9% of the time) they
are almost all worthless. But just _one_ case where they help is a big
deal. So don't say "most people don't care", because that is a totally
irrelevant argument. It's not "most people" who matter. It's not even
kernel developers who matter - they can know how to enable the stuff if
they ever see a problem. The _only_ people who matter are the very
occasional regular users that see problems.

And those occasional people are often not going to eb very good at
reporting bugs. If they don't see anything happening, they'll just give up
rather than bother to report it. So I do think we want the fairly verbose
thing enabled by default. You can then hide it with the graphical bootup 
for "most people".

		Linus
