Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269538AbUICBcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269538AbUICBcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269220AbUICB3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 21:29:52 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:28156 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S269511AbUICB2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 21:28:09 -0400
Date: Thu, 2 Sep 2004 21:32:31 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH][1/8] Arch agnostic completely out of line locks / generic
In-Reply-To: <Pine.LNX.4.58.0409021806430.2295@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0409022118250.4481@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0409021208310.4481@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409021703440.2295@ppc970.osdl.org>
 <Pine.LNX.4.58.0409022021100.4481@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409021745530.2295@ppc970.osdl.org>
 <Pine.LNX.4.58.0409022056450.4481@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409021806430.2295@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Sep 2004, Linus Torvalds wrote:

> On Thu, 2 Sep 2004, Zwane Mwaikambo wrote:
> >
> > No real reason, i have a habit of never specifying the section in the
> > definition. The following simply moves __lockfunc into spinlock.h and
> > uses it everywhere.
>
> Ok, I'm happy with this. I'll even apply it if you make a version relative
> to my -BK tree ;).

Great, i'll merge.

> Btw, there must be something wrong in your size comparison for x86:
>
> 	i386 = 524115 bytes
> 	   text    data     bss     dec     hex filename
> 	5695619  870906  328112 6894637  69342d vmlinux-after
> 	6221254  870634  326864 7418752  713380 vmlinux-before
>
> The "bss" number shouldn't change as far as I can tell, and indeed, on all
> the other architectures you cite, it doesn't change. So I think your
> before/after numbers on x86 are something else.

i386 = 416075 bytes
   text    data     bss     dec     hex filename
5808371  867442  326864 7002677  6ada35 vmlinux-after
6221254  870634  326864 7418752  713380 vmlinux-before

Those seem to make a lot more sense.

Thanks,
	Zwane
