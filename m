Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316952AbSEWQhT>; Thu, 23 May 2002 12:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316954AbSEWQhT>; Thu, 23 May 2002 12:37:19 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47329 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316952AbSEWQhR>;
	Thu, 23 May 2002 12:37:17 -0400
Date: Thu, 23 May 2002 09:21:55 -0700 (PDT)
Message-Id: <20020523.092155.70675460.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, andrea@suse.de,
        torvalds@transmeta.com
Subject: Re: Q: PREFETCH_STRIDE/16
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15597.6222.724619.443491@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Thu, 23 May 2002 09:26:54 -0700
   
   That code certainly wasn't optimized for ia64.  Furthermore, I also do
   not like the prefetch distance it's using.  In fact, in my ia64-patch,
   I use the following code instead:
   
   		prefetchw(pmd + j + PREFETCH_STRIDE/sizeof(*pmd));
   
   This is more sensible (because it really does prefetch by the
   PREFETCH_STRIDE distance) and it also happens to run (slightly) faster
   on Itanium.

All of these particular prefetches are amusing, with or without your
fix, considering there are other more powerful ways to optimize this
stuff. :-)

