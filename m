Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265536AbUBBAzZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 19:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265538AbUBBAzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 19:55:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:53208 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265536AbUBBAzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 19:55:20 -0500
Date: Sun, 1 Feb 2004 16:55:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Daniel Jacobowitz <dan@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: More waitpid issues with CLONE_DETACHED/CLONE_THREAD
In-Reply-To: <200402012225.i11MPEN1009925@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0402011653230.2229@home.osdl.org>
References: <200402012225.i11MPEN1009925@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 1 Feb 2004, Roland McGrath wrote:
> 
> I haven't really looked into the problem with Dan's test case yet (didn't
> seem to reproduce, but I haven't tried a current and cruft-free kernel yet).  
> But I don't see any problem with the implementation of PTRACE_KILL.

Hmm.. For me, Dan's program (with "-DBUG -DNOTHREAD") results in a 
sleeping parent, and both children are likewise just sleeping. Despite the 
fact that the parent just did the PTRACE_KILL on child2.

I didn't trace it through the kernel, it just looked like PTRACE_KILL 
didn't do anything.

		Linus
