Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311710AbSEMLJD>; Mon, 13 May 2002 07:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312169AbSEMLJC>; Mon, 13 May 2002 07:09:02 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:29317 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S311710AbSEMLJB>; Mon, 13 May 2002 07:09:01 -0400
Date: Mon, 13 May 2002 13:09:18 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: george anzinger <george@mvista.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit jiffies, a better solution
In-Reply-To: <3CDC4B5C.C3DB2533@mvista.com>
Message-ID: <Pine.GSO.3.96.1020513130108.24146B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002, george anzinger wrote:

> If that were only true.  The problem is that some architectures can be
> built with either endian.  Mips, for example, seems to take the endian
> stuff in as an environment variable.  The linker seems to know this
> stuff, but does not provide the "built in" to allow it to be used.

 Huh?  You can use CONFIG_CPU_LITTLE_ENDIAN.  Gcc and the linker for
MIPS/Linux typically support both endiannesses (with a default selected at
their build time) and it's the configuration variable that selects either
of them.

> The info is available from the header files at compile time, but I could
> not find a clean way to export it to the Makefile, where we might choose
> which linker script to use.  I suppose we could run the linker script
> thru cpp if all else fails.  Any ideas?

 CONFIG_CPU_LITTLE_ENDIAN is available to Makefiles.  There used to be
separate linker scripts for different endiannesses for MIPS once. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

