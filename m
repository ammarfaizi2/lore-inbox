Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268074AbUIGPhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268074AbUIGPhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUIGPez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:34:55 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:56056 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268314AbUIGP32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:29:28 -0400
Date: Tue, 7 Sep 2004 11:33:54 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Matt Mackall <mpm@selenic.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH][8/8] Arch agnostic completely out of line locks / x86_64
In-Reply-To: <20040906175021.GA27258@wotan.suse.de>
Message-ID: <Pine.LNX.4.53.0409071132360.14053@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0409021241291.4481@montezuma.fsmlabs.com>
 <20040904111605.GA12165@wotan.suse.de> <Pine.LNX.4.58.0409041420590.11262@montezuma.fsmlabs.com>
 <20040906072859.GB31343@wotan.suse.de> <Pine.LNX.4.53.0409061211440.14053@montezuma.fsmlabs.com>
 <20040906175021.GA27258@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sep 2004, Andi Kleen wrote:

> On Mon, Sep 06, 2004 at 12:19:24PM -0400, Zwane Mwaikambo wrote:
> > Hi Andi,
> > 
> > On Mon, 6 Sep 2004, Andi Kleen wrote:
> > 
> > > That is with frame pointers enabled. Indeed with frame pointers
> > > on it is not true you still have to special case that.
> > 
> > Yes that was with frame pointers enabled, but the following was compiled 
> > without frame pointers, i'm still not sure it's safe to use *esp.
> 
> No, it's not unfortunately. gcc is aligning the stack 
> to 8 bytes for floating point. It would if you compiled the file with 
> -mpreferred-stack-boundary=4. Actually AFAIK this is only useful
> for floating point anyways, so it would be a good idea to always
> compile the kernel with this option.

We should give this a go.

> On x86-64 it should just work.

i'll send a patch for that.

Thanks Andi,
	Zwane
