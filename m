Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVBFMg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVBFMg7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 07:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVBFMg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 07:36:59 -0500
Received: from cantor.suse.de ([195.135.220.2]:22403 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261181AbVBFMgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 07:36:52 -0500
Date: Sun, 6 Feb 2005 13:36:51 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
Message-ID: <20050206123651.GC30109@wotan.suse.de>
References: <20050206113635.GA30109@wotan.suse.de> <20050206114758.GA8437@infradead.org> <20050206120244.GA28061@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206120244.GA28061@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> (I'd like to stress that this problem only affects packages _recompiled_
> with new gcc, running on NX capable CPUs - legacy apps or CPUs are in no

Yeah, but who did the auditing of all user land packages if they
don't need changes? And who told user land developers that they need
to do this all if they only want to recompile software.

That hasn't been done as far as I can figure out, and I'm not really
willing to serve as the frontend/coordinator for this process on the x86-64 
side.

I would request that this stuff is only turned on by default
until there is a reasonable process found for this.

> way affected. Also, even with a recompile, apps/kernels/distros have a
> number of other options as well even without this kernel fix, of varying
> granularity: to use the setarch utility, to set the READ_IMPLIES_EXEC
> personality bit within the code, or to pass in the noexec=off kernel
> commandline option, or to add a oneliner patch to their heap of 1500+
> kernel patches, or to fix the application. Also, with Arjan's patch
> applied, the execstack utility can be used to remark the binary
> permanently, if needed.)

That would still leave the mainline users who just update their
kernels from a kernel.org tarball out in the rain.

And guess who they will complain to if their favourite program doesn't
work anymore in x86-64 32bit emulation?

-Andi
