Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264399AbTIITxC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 15:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTIITxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 15:53:02 -0400
Received: from trained-monkey.org ([209.217.122.11]:62481 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S264399AbTIITvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 15:51:15 -0400
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: "Christoph Hellwig" <hch@infradead.org>, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [Patch] asm workarounds in generic header files
References: <A609E6D693908E4697BF8BB87E76A07A022114C0@fmsmsx408.fm.intel.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 09 Sep 2003 15:51:05 -0400
In-Reply-To: <A609E6D693908E4697BF8BB87E76A07A022114C0@fmsmsx408.fm.intel.com>
Message-ID: <m3llsxivva.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Suresh" == Siddha, Suresh B <suresh.b.siddha@intel.com> writes:

Suresh> We believe that we are trying to improve the code by
Suresh> localizing the compiler issues (including the ones for gcc3
Suresh> and Intel complier) and by introducing use of compiler
Suresh> intrinsics (e.g. for barrier()).

Hi Suresh,

I actually think this is degrading the code rather then improving
it. Right now the various macros are located in the include/asm-<foo>
directory next to the items where they are used. Moving it all into
one big catch-all assembly file makes it a lot harder to read things
and debug the code. I already took a look at the changes that went
into the ia64 part of the tree and I really think that was a step
backwards.

In terms of compiling the Linux kernel, I will argue that the Intel
compiler is broken if it cannot handle inline assembly. Inline
assembly is just too fundamental a feature for the kernel. This is
totally ignoring the question of whether one should be compiling the
kernel with non-GCC in the first place.

Regards,
Jes
