Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312188AbSCRDXt>; Sun, 17 Mar 2002 22:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312186AbSCRDXk>; Sun, 17 Mar 2002 22:23:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24250 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312188AbSCRDX2>;
	Sun, 17 Mar 2002 22:23:28 -0500
Date: Sun, 17 Mar 2002 19:20:01 -0800 (PST)
Message-Id: <20020317.192001.103236436.davem@redhat.com>
To: torvalds@transmeta.com
Cc: alan@lxorguk.ukuu.org.uk, viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.7-pre2 -- kernel.o(.data+0x300): undefined
 reference
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0203161011150.31850-100000@penguin.transmeta.com>
In-Reply-To: <E16mI91-0006mI-00@the-village.bc.nu>
	<Pine.LNX.4.33.0203161011150.31850-100000@penguin.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Sat, 16 Mar 2002 10:15:33 -0800 (PST)
   
   On Sat, 16 Mar 2002, Alan Cox wrote:
   > This is what Linus threw out before - when David wanted to use it
   > to remove all the intermodule crap.
   > 
   > It doesn't work with some architecture binutils
   
   How true is that these days, though?

It is still true, you will break the sparc64 link if you put that
stuff in again.  It isn't COFF or a.out, it is elf but there are
bugs in the tools.  And these are the only tools I happen to trust
for getting reliable kernels built.

