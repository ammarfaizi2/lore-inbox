Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271845AbRICWZ7>; Mon, 3 Sep 2001 18:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271842AbRICWZt>; Mon, 3 Sep 2001 18:25:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40325 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271837AbRICWZh>;
	Mon, 3 Sep 2001 18:25:37 -0400
Date: Mon, 03 Sep 2001 15:24:43 -0700 (PDT)
Message-Id: <20010903.152443.59467554.davem@redhat.com>
To: Ulrich.Weigand@de.ibm.com
Cc: Richard.Zidlicky@stud.informatik.uni-erlangen.de, thunder7@xs4all.nl,
        parisc-linux@lists.parisc-linux.org, linux-kernel@vger.kernel.org
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs
 on parisc architecture
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OF9A995335.07A81CF5-ONC1256ABC.00422A7B@de.ibm.com>
In-Reply-To: <OF9A995335.07A81CF5-ONC1256ABC.00422A7B@de.ibm.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
   Date: Mon, 3 Sep 2001 14:08:43 +0200
   
   >From what I recall when we were looking into reiserfs on S/390,
   the core problem was that reiserfs tried to do *atomic* operations
   on non-aligned words.  This isn't supported by the hardware on
   S/390 (normal non-aligned accesses just work).
   
   I don't really see how this can be fixed in a trap handler; how
   would the handler guarantee atomicity?

Oh thats different!  That won't even work %100 correctly on x86.  On
x86 it will "execute", but it won't be atomic.

Why the F*CK does it need to do this?  It sounds like sloppy
programming to me.

Later,
David S. Miller
davem@redhat.com
