Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSIIITE>; Mon, 9 Sep 2002 04:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSIIITE>; Mon, 9 Sep 2002 04:19:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7069 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315267AbSIIITD>;
	Mon, 9 Sep 2002 04:19:03 -0400
Date: Mon, 09 Sep 2002 01:15:39 -0700 (PDT)
Message-Id: <20020909.011539.122194350.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: pavel@suse.cz, torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       akpm@zip.com.au
Subject: Re: [PATCH] Important per-cpu fix. 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020909081754.EC8382C09D@lists.samba.org>
References: <20020908.231304.30400540.davem@redhat.com>
	<20020909081754.EC8382C09D@lists.samba.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Mon, 09 Sep 2002 18:17:22 +1000

   In message <20020908.231304.30400540.davem@redhat.com> you write:
   I'm not making an interface harder to use because of one of 17
   architectures refuses to fix a bug in their toolchain.

It's not a sparc64 specific problem, as has been noted.
We are extended the life of an older toolchain on more than
one platform.
   
Note that Andrew Morton found the problem on one of his older
x86 EGCS's about the same time I found it on sparc64.

   I want *you* to feel the pain, not spread it around by leaving turds
   throughout the code long after the bug is forgotten:
   
Aha, but it is you putting the turd comments all over.  I'm
suggesting to put the turd in one place, the header file.

And how difficult is it to discern which initializers were
needed?  Hmmm let me see, if it was all zero --> removing it
is harmless.

Wow, that was hard. :-)

Both of us are advocating adding shit to the tree, the only argument
is which stinks less from a maintainence perspective.
