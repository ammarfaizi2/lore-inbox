Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVJYWVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVJYWVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 18:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVJYWVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 18:21:47 -0400
Received: from ns2.suse.de ([195.135.220.15]:44515 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932425AbVJYWVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 18:21:46 -0400
From: Andi Kleen <ak@suse.de>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: Re: [PATCH 6/6] x86_64: enable xchg optimization for x86_64
Date: Wed, 26 Oct 2005 00:22:27 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20051025221105.21106.95194.stgit@zion.home.lan> <20051025221351.21106.57194.stgit@zion.home.lan>
In-Reply-To: <20051025221351.21106.57194.stgit@zion.home.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510260022.28095.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 October 2005 00:13, Paolo 'Blaisorblade' Giarrusso wrote:

>
> I.e. the implementation was written, is present in the tree, but due to
> this:
>
> #ifdef CONFIG_RWSEM_GENERIC_SPINLOCK
> #include <linux/rwsem-spinlock.h> /* use a generic implementation */
> #else
> #include <asm/rwsem.h> /* use an arch-specific implementation */
> #endif
>
> it was probably _NEVER_ compiled!!!

Actually it was, but we switched it back because there were some doubts
on the correctness of the xchg based implementation and the generic
one looked much cleaner. So far nobody showed a significant performance
different too.

I should probably remove asm/rwsem.h.

Don't apply please.

-Andi
