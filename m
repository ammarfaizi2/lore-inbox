Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVANA4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVANA4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVANAy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:54:58 -0500
Received: from fsmlabs.com ([168.103.115.128]:51328 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261730AbVANAu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:50:27 -0500
Date: Thu, 13 Jan 2005 17:50:41 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Chris Wright <chrisw@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, clameter@sgi.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixes for prep_zero_page
In-Reply-To: <20050113102420.A469@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.61.0501131133230.4941@montezuma.fsmlabs.com>
References: <20050108010629.M469@build.pdx.osdl.net> <20050109014519.412688f6.akpm@osdl.org>
 <Pine.LNX.4.61.0501090812220.13639@montezuma.fsmlabs.com>
 <20050109125212.330c34c1.akpm@osdl.org> <Pine.LNX.4.61.0501091409490.13639@montezuma.fsmlabs.com>
 <20050109144840.W2357@build.pdx.osdl.net> <Pine.LNX.4.61.0501092117040.20477@montezuma.fsmlabs.com>
 <Pine.LNX.4.61.0501122203350.4941@montezuma.fsmlabs.com>
 <20050113102420.A469@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005, Chris Wright wrote:

> * Zwane Mwaikambo (zwane@arm.linux.org.uk) wrote:
> > It looks like it's still not happy with CONFIG_DEBUG_PAGEALLOC under load.
> > 
> > Unable to handle kernel paging request at virtual address ec5d97f4
> 
> Is that in vmalloc space?

Hmm it looks like.

> >  printing eip:
> > c014a882
> > *pde = 0083e067
> > Oops: 0000 [#1]
> > PREEMPT SMP DEBUG_PAGEALLOC
> > Modules linked in:
> > CPU:    0
> > EIP:    0060:[<c014a882>]    Not tainted VLI
> > EFLAGS: 00010002   (2.6.10-mm2)
> > EIP is at check_slabuse+0x52/0xf0
> 
> Hmm, isn't that from Manfred's patch to periodically scan?  Doesn't look
> to me like it's related to the page prep fixup.  What kind of load, etc?

I had an email exchange with Christopher and we came to the conclusion 
that it's breakage elsewhere with CONFIG_DEBUG_PAGEALLOC.

