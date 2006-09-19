Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751716AbWISJIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbWISJIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 05:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbWISJIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 05:08:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56024 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751666AbWISJIX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 05:08:23 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060919003031.166d08a4.akpm@osdl.org> 
References: <20060919003031.166d08a4.akpm@osdl.org>  <20060913183522.22109.10565.stgit@warthog.cambridge.redhat.com> <20060913183531.22109.85723.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 5/7] Alter get_order() so that it can make use of ilog2() on a constant [try #3] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 19 Sep 2006 10:08:17 +0100
Message-ID: <23843.1158656897@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> This breaks ia64:

Okay, drop it for now.

> But for some reason putting ARCH_HAS_GET_ORDER into
> include/asm-ia64/bitops.h and including linux/log2.h in
> include/asm-ia64/page.h doesn't fix it.

Seems I need to get an IA64 cross-compiler.

> I didn't pursue it further, because sprinkling ARCH_HAS_FOO things into
> bitops.h(!) is all rather hacky.  Better to use CONFIG_* so they're always
> visible and one knows where to go to find things.

But (1) they're not config options, and (2) there's plenty of precedent for
this sort of thing (ARCH_HAS_PREFETCH for example).

David
