Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282800AbRK0GU7>; Tue, 27 Nov 2001 01:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282814AbRK0GUt>; Tue, 27 Nov 2001 01:20:49 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64133 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282800AbRK0GUr>;
	Tue, 27 Nov 2001 01:20:47 -0500
Date: Mon, 26 Nov 2001 22:18:55 -0800 (PST)
Message-Id: <20011126.221855.102041585.davem@redhat.com>
To: kaos@ocs.com.au
Cc: trini@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/802/Makefile 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <12077.1006841524@kao2.melbourne.sgi.com>
In-Reply-To: <20011126.212658.82514202.davem@redhat.com>
	<12077.1006841524@kao2.melbourne.sgi.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Keith Owens <kaos@ocs.com.au>
   Date: Tue, 27 Nov 2001 17:12:04 +1100
   
   The source repository (whether BK or any other system) is not the
   problem.  You can get the timestamps right in the source but the moment
   you generate and ship a diff then you lose control of timestamps.  See
   the long screed below about the problems with shipping generated files,
   from kbuild-2.5.txt.

Even after reading this I don't understand why defkeymap.c gets
special treatment just because it requires external tools to generate.

If the timestamps get messed up, it's going to try to regerenerate the
file with loadkeys whether you have it or not.

At best, I'd be happy to take a patch which commented out the rule
which tries to generate net/802/cl2llc.c but not one which will chmod
it.  Because the latter only makes sense if we are now deciding to do
this for _every_ such case in the tree.
