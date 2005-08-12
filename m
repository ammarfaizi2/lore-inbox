Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVHLRdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVHLRdU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbVHLRdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:33:20 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:10375 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750747AbVHLRdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:33:19 -0400
Date: Fri, 12 Aug 2005 13:32:38 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Arjan van de Ven <arjan@infradead.org>
cc: Dave Jones <davej@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference
 between /dev/kmem and /dev/mem)
In-Reply-To: <1123866984.3218.32.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0508121324350.27593@localhost.localdomain>
References: <1123796188.17269.127.camel@localhost.localdomain> 
 <1123809302.17269.139.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>  <20050812165657.GC13749@redhat.com>
  <Pine.LNX.4.58.0508121302590.26736@localhost.localdomain>
 <1123866984.3218.32.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2005, Arjan van de Ven wrote:
> > Again, I'm asking to have it turned into a config option. Even default to
> > off. I understand that /dev/kmem shouldn't be in a production machine.
> > There's no reason for it.  But it is nice to have when debugging the
> > kernel.  I'll make the changes if need be, to make this into a config
> > option (placed in the kernel debug section).  I'll even maintain it to
> > keep it working.  But I don't want yet another thing I need to write
> > myself for debugging the kernel.
>
> and /proc/kcore doesn't cut it for you?

I don't know.  Can I mmap kcore, set up a function that I want to try out
before putting in the kernel, have it modify the variables that are
mmapped, and see if all works?

Also, I've only used /proc/kcore with gdb, I never wrote my own core
parsing programs.

I like to do some strange things when adding stuff to the kernel, and
mapping /dev/mem to get to kernel globals from user space was one of
them.  I didn't just monitor, I did modify things as well.  But this was
all for R&D and testing. Never for the final product, so that's why I
don't mind a config option, even under kernel debug.

-- Steve

