Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262856AbUJ1Jm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbUJ1Jm6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbUJ1Jin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:38:43 -0400
Received: from cantor.suse.de ([195.135.220.2]:32682 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262863AbUJ1Jgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:36:52 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: [patch] cputime: introduce cputime.
References: <20041027224805.31f5747b.akpm@osdl.org.suse.lists.linux.kernel>
	<OF35D2677F.494347CD-ON42256F3B.002DDBE5-42256F3B.002F22AE@de.ibm.com.suse.lists.linux.kernel>
	<20041028021317.48a6d0c2.akpm@osdl.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Oct 2004 11:36:51 +0200
In-Reply-To: <20041028021317.48a6d0c2.akpm@osdl.org.suse.lists.linux.kernel>
Message-ID: <p738y9r18wc.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> >
> > > - kernel threads may have null p->signal
> >  > - remove some deoptimising inlines
> > 
> >  Does it work with these two changes ?
> 
> Well it doesn't crash ;)
> 
> It compiles OK on a bunch of architectures, bloats the kernel by 2k and
> various system monitoring tools emit sensible-looking numbers.  What should
> I be looking for?

2K sounds definitely wrong. Martin's patch should be ideally a nop
for architectures that use asm-generic/cputime.h 

-Andi
