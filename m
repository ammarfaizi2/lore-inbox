Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266295AbUHGHtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUHGHtx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 03:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267776AbUHGHtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 03:49:52 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:49727 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266295AbUHGHtv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 03:49:51 -0400
Subject: Re: [PATCH] Re-implemented i586 asm AES (updated)
From: Kasper Sandberg <lkml@metanurb.dk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, James Morris <jmorris@redhat.com>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408060941550.24588@ppc970.osdl.org>
References: <2qbyt-1Op-45@gated-at.bofh.it> <2qemF-3Pj-49@gated-at.bofh.it>
	 <m3wu0cgv6q.fsf@averell.firstfloor.org>
	 <Pine.LNX.4.58.0408060941550.24588@ppc970.osdl.org>
Content-Type: text/plain
Date: Sat, 07 Aug 2004 09:49:45 +0200
Message-Id: <1091864985.9992.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i dont know anything at all about this, but wouldnt it be possible to
optimize it even more, if there were a version for each cpu, like one
for athlon-xp and one for p4?

On Fri, 2004-08-06 at 09:43 -0700, Linus Torvalds wrote:
> 
> On Fri, 6 Aug 2004, Andi Kleen wrote:
> > 
> > You could use .altinstructions to patch a jump in at runtime
> > based on CPU capabilities. Assuming MMX is really faster of course.
> 
> I seriously doubt that the MMX code could be faster.
> 
> The only MMX code in the original was saving some integer contents to a 
> scratch MMX register rather than saving to memory. There's _no_ way that 
> is faster, especially since in the kernel it would require us much extra 
> work to first check that the FP context is safed. Even _without_ the extra 
> work I simply cannot imagine that a "movd reg,mmx" is faster than a plain 
> "movl reg,stackslot". 
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

