Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154212AbPEaHLH>; Mon, 31 May 1999 03:11:07 -0400
Received: by vger.rutgers.edu id <S153897AbPEaFJi>; Mon, 31 May 1999 01:09:38 -0400
Received: from mailhost.uni-koblenz.de ([141.26.64.1]:38176 "EHLO mailhost.uni-koblenz.de") by vger.rutgers.edu with ESMTP id <S154439AbPEaBLr>; Sun, 30 May 1999 21:11:47 -0400
Date: Mon, 31 May 1999 04:14:37 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "Vilain, Sam" <sam.vilain@nz.unisys.com>
Cc: "'Jim Mostek'" <mostek@sgi.com>, linux-kernel@vger.rutgers.edu
Subject: Re: XFS and journalling filesystems
Message-ID: <19990531041437.C672@uni-koblenz.de>
References: <76D8782817C5D211A37400104B0C84B029C52F@nz-wlg-exch-1.nz.unisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <76D8782817C5D211A37400104B0C84B029C52F@nz-wlg-exch-1.nz.unisys.com>; from Vilain, Sam on Sat, May 29, 1999 at 06:48:19AM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-kernel@vger.rutgers.edu

On Sat, May 29, 1999 at 06:48:19AM -0400, Vilain, Sam wrote:

> As a dangerous rule of thumb, LOC ~ code size.  More code size = bigger
> kernel = less (buffercache|user memory).  <flamesuit>This is a fear of Linux
> kernel developers - Linux ending up as slow as say, Solaris on low end
> machines (even if it kicks butt on 6144-way SMP).</flamesuit>

Nobody builds 6144-way SMPs, not Sun nor somebody else.  The SMP paradigm
just doesn't scale that far.

> Numbers are often good in arguments like this.  ie, how big is the ext2fs
> module under Linux/MIPS, compared to the xfs module under Irix?  [Comparing
> with Linux/i386 should probably be avoided, because i386 code is (generally)
> more instructions/word, even if you need a few extra million transistors to
> decode it :)].

[ralf@lappi linux-sgi]$ mips-linux-size fs/ext2/ext2.o
   text	   data	    bss	    dec	    hex	filename
  60080	    496	   1024	  61600	   f0a0	fs/ext2/ext2.o
[ralf@lappi linux-sgi]$ 

The archive /usr/cpu/sysgen/IP22boot/xfs.a of IRIX 6.2 has in total a
.text size of 274864.  That's 32 bit code btw.

  Ralf

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
