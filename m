Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWIGK3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWIGK3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 06:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWIGK3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 06:29:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:50625 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751393AbWIGK3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 06:29:11 -0400
Date: Thu, 7 Sep 2006 12:25:54 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Adrian Bunk <bunk@stusta.de>
cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] re-add -ffreestanding
In-Reply-To: <20060907022303.GG25473@stusta.de>
Message-ID: <Pine.LNX.4.64.0609071214421.6761@scrub.home>
References: <200608302013.58122.ak@suse.de> <20060830183905.GB31594@flint.arm.linux.org.uk>
 <20060906223748.GC12157@stusta.de> <Pine.LNX.4.64.0609070115270.6761@scrub.home>
 <20060906235029.GC25473@stusta.de> <Pine.LNX.4.64.0609070202040.6761@scrub.home>
 <20060907003758.GD25473@stusta.de> <Pine.LNX.4.64.0609070245100.6761@scrub.home>
 <20060907010235.GE25473@stusta.de> <Pine.LNX.4.64.0609070313420.6761@scrub.home>
 <20060907022303.GG25473@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 7 Sep 2006, Adrian Bunk wrote:

> > > > Define "full libc".
> > > 
> > > Everything described in clause 7 of ISO/IEC 9899:1999.
> > 
> > Its behaviour is also defined by the environment, so what gcc can assume 
> > is rather limited and you have not shown a single example, that any such 
> > assumption would be invalid for the kernel.
> 
> ISO/IEC 9899:1999 clause 7 defines the libc part of a hosted environment.

Which is a problem for the kernel exactly how?
BTW the standard specifies the minimum requirements for a libc, so talking 
about "full libc" is ambiguous at best.

> > The kernel uses standard C, so your point is?
> 
> A standard C freestanding environment or a standard C hosted environment?

As far as gcc is concerned it's a hosted environment, where we provide 
only what we actually use, but anything we do provide is compliant.

> > You already got two NACKs from arch maintainers, why the hell are you 
> > still pushing this patch? The builtin functions are useful and you want to 
> 
> The same people who justified removing -ffreestanding with the "it was 
> only added for x86-64, so dropping it should be safe" that has proven 
> wrong now put their arch maintainers hats on for NACKing reverting this 
> patch...

And you keep ignoring there might be better solutions...

> > force arch maintainers to have to enable every single one manually and 
> > to maintain a list of these functions over multiple versions of gcc?
> 
> It could be done per architecture or globally for some functions.
> 
> And it doesn't sound like a bad idea to check the current code and think 
> of what it does and what it should do -  many architecture specific 
> things (like much of include/asm-i386/string.h) seem to be more 
> historically than architecture specific.

We're happy to hear about it, once you've done this.

bye, Roman
