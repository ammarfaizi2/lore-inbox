Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268202AbRG2Wlw>; Sun, 29 Jul 2001 18:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268205AbRG2Wlm>; Sun, 29 Jul 2001 18:41:42 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:33037 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S268202AbRG2Wl0>; Sun, 29 Jul 2001 18:41:26 -0400
From: Andrzej Krzysztofowicz <kufel!ankry@green.mif.pg.gda.pl>
Message-Id: <200107292207.AAA31683@kufel.dom>
Subject: Re: Kernel version 2.4.7 compile errors
To: kufel!bish.net!mark@green.mif.pg.gda.pl
Date: Mon, 30 Jul 2001 00:07:27 +0200 (CEST)
Cc: kufel!vger.kernel.org!linux-kernel@green.mif.pg.gda.pl
In-Reply-To: <Pine.LNX.3.96.1010729170618.6078B-100000@bish.net> from "Mark" at lip 29, 2001 05:10:40 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> 
> Note: I'm not subscribed, please Cc: mark@bish.net
> 
> I'm trying to compile 2.4.7 with resiser support and I get this:
> 
> make[3]: Entering directory `/usr/src/linux/fs/reiserfs'
> gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
> -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o inode.o inode.c
> inode.c: In function `reiserfs_get_block':
> inode.c:803: warning: implicit declaration of function
> `journal_transactioo_should_end'
> inode.c:812: `retvcl' undeclared (first use in this function)

Check your hardware. In my tree it is 'retval' as it should.
'a' and 'c' differ by a single bit ...

> inode.c:812: (Each undeclared identifier is reported only once
> inode.c:812: for each function it appears in.)
> inode.c:812: parse error before `)'
> inode.c: In function `init_inode':
> inode.c:870: warning: implicit declaration of function `INIT_NIST_HEAD'

As above. INIT_LIST_HEAD

> inode.c:876: warning: implicit declaration of function
> `knode_items_version'

As above. inode_items_version

> inode.c:876: invalid lvalue in assignment
> inode.c:878: parse error before `>'

Guessing: "->" <-----> "/>" ? 

> inode.c:882: structure has no member named `sd_atkme'

As above. sd_atime

> inode.c:889: `inofe' undeclared (first use in this function)

As above. inode

You probably have a memory chip with broken bit 1 on some address(es)

Andrzej
