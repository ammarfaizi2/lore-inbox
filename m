Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbWETBP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbWETBP1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 21:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWETBP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 21:15:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932407AbWETBP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 21:15:26 -0400
Date: Fri, 19 May 2006 18:15:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       kraxel@suse.de, zach@vmware.com
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range
 patch
In-Reply-To: <20060519181125.5c8e109e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0605191813050.10823@g5.osdl.org>
References: <1147759423.5492.102.camel@localhost.localdomain>
 <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain>
 <20060519174303.5fd17d12.akpm@osdl.org> <20060520010303.GA17858@elte.hu>
 <20060519181125.5c8e109e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 May 2006, Andrew Morton wrote:
> > 
> > FC1 is like really ancient. I think there was a glibc bug that caused 
> > vsyscall related init hangs like that. To nevertheless let people run 
> > their old stuff there's a vdso=0 boot option in exec-shield.
>
> 
> Well that patch took a machine from working to non-working.  Pretty serious
> stuff.  We should get to the bottom of the problem so we can assess the
> risk and impact, no?

Yes. And it would be good to have a way to turn it off - either globally 
of by some per-process setup (eg off by default, but turn on when doing 
some magic).

The per-process one would be the harder one, because it would require the 
fixmap entry, but not globally. So I suspect the only practical thing 
would be to have it be a kernel boot-time option.

		Linus
