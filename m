Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131407AbREFCT6>; Sat, 5 May 2001 22:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131244AbREFCTt>; Sat, 5 May 2001 22:19:49 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:46344 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S130820AbREFCTl>;
	Sat, 5 May 2001 22:19:41 -0400
Date: Sat, 5 May 2001 23:19:09 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Chris Wedgwood <cw@f00f.org>
Cc: Peter Rival <frival@zk3.dec.com>, Anton Blanchard <anton@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CPU hot swap for 2.4.3 + s390 support
In-Reply-To: <20010506033746.A30690@metastasis.f00f.org>
Message-ID: <Pine.LNX.4.21.0105052317080.582-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 May 2001, Chris Wedgwood wrote:
> On Sat, May 05, 2001 at 10:43:27AM -0400, Peter Rival wrote:
> 
>     Has anyone looked into memory hot swap/hot add support? 
> 
> Adding memory probably isn't going to be too hard... but taking
> existing memory off line is tricky. You have to find some way of
> finding all the pages that are in use and then dealing with them
> appropriately, and when some are locked or contain kernel data this
> would be extremely difficult I should think.

Actually:

1. the kernel uses virtual memory itself and accesses its
   data structures through page tables
2. reverse mapping stuff is easy (though it costs 8 bytes
   of overhead per mapped pte, probably doubling page table
   overhead)

This only leaves two issues, the first is device drivers and
the second is the question whether we'd want the overhead
needed to implement the (fairly easy) memory relocation.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

