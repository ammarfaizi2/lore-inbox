Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030772AbWI0Uat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030772AbWI0Uat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030769AbWI0Uat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:30:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29932 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030772AbWI0Uat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:30:49 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       "Luck, Tony" <tony.luck@intel.com>, Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/5] Message signaled irq handling cleanups
References: <m164f9m6dy.fsf@ebiederm.dsl.xmission.com>
Date: Wed, 27 Sep 2006 14:29:33 -0600
In-Reply-To: <m164f9m6dy.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Wed, 27 Sep 2006 13:55:21 -0600")
Message-ID: <m11wpxm4sy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> The following patch set should be enough to clear up the
> outstanding issues with genirq on i386 and x86_64.  This actually
> takes things a step farther and moves all of architecture
> dependencies I could find into the appropriate architecture.
>
> So hopefully we are finally close enough that other architectures
> will be able implement msi support, without too much trouble.
>
> msi: Simplify msi sanity checks by adding with generic irq code.
> msi: Only use a single irq_chip for msi interrupts
> msi: Refactor and move the msi irq_chip into the arch code.
> msi: Move the ia64 code into arch/ia64
> htirq: Tidy up the htirq code
>
> Eric

Grr.. My ia64 compiler is way too slow.  It just told me I had some
trivial bugs in the altix portion of what I posted.   Sorry I forgot
to mention all I can do is compile test ia64.

So here comes a second time with code that actually compiles :)

Darn this code that is so ugly that you have to test the cleanup on
multiple architectures!

Eric
