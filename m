Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268907AbUJPV7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268907AbUJPV7o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 17:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268916AbUJPV7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 17:59:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:64679 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268907AbUJPV7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 17:59:43 -0400
Date: Sat, 16 Oct 2004 14:59:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: roland@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] JVM crashes with 2.6.9-rc2
In-Reply-To: <1097928466.13431.8.camel@localhost>
Message-ID: <Pine.LNX.4.58.0410161454360.3897@ppc970.osdl.org>
References: <1097928466.13431.8.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Oct 2004, Pekka Enberg wrote:
> 
> Sun JVM 1.4.2_06 crashes with Linux 2.6.9-rc2 and later on i386 when I
> start Eclipse. The JVM dies a horrible death claiming internal error.  

Hmm.. The strace is pretty nondescript, because the abort happens in some 
other thread than the initial one. That said:

> I noticed similar problem with Blackdown JDK 1.4.2_rc1 as well.  I have
> put a full strace of the run here [1].
> 
> I also tested 2.6.7, 2.6.8.1, and 2.6.9-rc1 and they all work fine.
> Reverting Roland's i386 syscall tracing patch [2] from 2.6.9-rc2 makes
> the problem go away for me.

That's just _weird_. For one, Roland's patch should only matter when 
tracing or auditing. For another, it shouldn't matter then either ;)

Can you double-check your test setup (and the kernel you tested) just 
because I don't see how that patch can matter.

		Linus
