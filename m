Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265009AbTGHD2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 23:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266443AbTGHD2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 23:28:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47255 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265009AbTGHD2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 23:28:51 -0400
Date: Mon, 07 Jul 2003 20:35:16 -0700 (PDT)
Message-Id: <20030707.203516.23026768.davem@redhat.com>
To: roland@topspin.com
Cc: hch@infradead.org, jmorris@intercode.com.au, TSPAT@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: crypto API and IBM z990 hardware support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <52adbp1yfu.fsf@topspin.com>
References: <20030707080929.A1848@infradead.org>
	<20030707.195350.39170946.davem@redhat.com>
	<52adbp1yfu.fsf@topspin.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Roland Dreier <roland@topspin.com>
   Date: 07 Jul 2003 20:37:09 -0700
   
   Still, I think there is a lot to be said for keeping arch code in
   arch/xxx and include/asm-xxx.  It means that someone working on a
   new port (I don't necessarily mean a totally new arch, but also
   adding support for some new CPU model or platform) has a
   well-defined set of directories to look at.
   
I again disagree.  We're talking about things here where
the default you get is _working_.

Only if you want to enhance or _optimize_ your port do you
need to modify any of this crap.

In this way it's fundamentally different from things that
one normally finds under arch/foo and include/asm-foo

   It's also nice that the xxx-arch maintainers can say "we are the rulers
   of arch/xxx and include/asm-xxx" and know that any changes outside of
   those directories have to go through lkml.
   
This isn't nice, it's rather bad for this case.

I think it'd be great that the "crypto maintainer" can be the one
by which "crypto changes" need to go through.  So again, I totally
disagree with your assesment.

   Still, I don't think I would like it if we had
   
           alpha/ arm/ arm26/ cris/ h8300/ i386/ ia64/ m68k/ m68knommu/
           mips/ mips64/ parisc ppc/ ppc64/ s390/ sh/ sparc/ sparc64/ um/
           v850/ x86_64/ generic/
   
   directories scattered all over the source tree.
   
I see no problem with this at all.  In fact, I wish we had a much
higher directory to file ratio in the kernel tree.

And hey, if I went "find crypto -type d -name sparc" I'd know if there
are sparc optimizations for the crypto library.  How might you do this
with the current "everything and it's mother under arch/" scheme?
Answer: you can't.
