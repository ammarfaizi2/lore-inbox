Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265920AbTIER4R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 13:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265921AbTIER4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 13:56:17 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:44685 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265920AbTIER4Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 13:56:16 -0400
Date: Fri, 5 Sep 2003 18:55:52 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
Message-ID: <20030905175552.GB4588@mail.jlokier.co.uk>
References: <20030904171609.GA30394@mail.jlokier.co.uk> <20030905052006.72B952C135@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905052006.72B952C135@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <20030904171609.GA30394@mail.jlokier.co.uk> you write:
> > What does PROT_SEM mean for Linux, btw?
> 
> It's a relic: some archs might need a special flag to ensure
> inter-process atomic ops worked as expected.  It was never fully
                                                       ~~~~~~~~~~~
> implemented, with the assumption that such archs just won't be able to
  ~~~~~~~~~~~
> use futexes, and if someone really wants to fix it, they will.

Looking at the kernel I can confidently say it was never implemented
at all.  sys_mprotect mentioned PROT_SEM but it was a misleading logic
error that did nothing useful :)

-- Jamie

