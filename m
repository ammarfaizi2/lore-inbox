Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274534AbRIYW25>; Tue, 25 Sep 2001 18:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274487AbRIYW2u>; Tue, 25 Sep 2001 18:28:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55956 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274349AbRIYW2p>;
	Tue, 25 Sep 2001 18:28:45 -0400
Date: Tue, 25 Sep 2001 15:28:58 -0700 (PDT)
Message-Id: <20010925.152858.00453513.davem@redhat.com>
To: bcrl@redhat.com
Cc: marcelo@conectiva.com.br, andrea@suse.de, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010925181643.D19494@redhat.com>
In-Reply-To: <20010925170055.B19494@redhat.com>
	<20010925.145547.90825509.davem@redhat.com>
	<20010925181643.D19494@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Tue, 25 Sep 2001 18:16:43 -0400

   > Please note that the problem is lock cachelines in dirty exclusive
   > state, not a "lock held for long time" issue.
   
   Ahh, that's a cpu bug -- one my athlons don't suffer from.
   
Your Athlons may handle exclusive cache line acquisition more
efficiently (due to memory subsystem performance) but it still
does cost something.

   True, and that is why I would like to see more of the research that 
   justifies these changes, as well as comparisons with alternate techniques 
   before any of these patches make it into the base tree.  Even before that, 
   we need to clean up the code first.
   
As an aside, I actually think the per-hashchain version of the
pagecache locking is cleaner conceptually.  The reason is that
it makes it more clear that we are locking the "identity of page X"
instead of "the page cache".

Franks a lot,
David S. Miller
davem@redhat.com

   
