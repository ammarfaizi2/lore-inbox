Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbSADVnw>; Fri, 4 Jan 2002 16:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281797AbSADVnm>; Fri, 4 Jan 2002 16:43:42 -0500
Received: from mout02.kundenserver.de ([195.20.224.133]:61541 "EHLO
	mout02.kundenserver.de") by vger.kernel.org with ESMTP
	id <S280588AbSADVne>; Fri, 4 Jan 2002 16:43:34 -0500
Date: Fri, 4 Jan 2002 22:45:20 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler, 2.4.17-A1, 2.5.2-pre7-A1.
Message-ID: <20020104214520.GA5972@elfie.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.43.0201042111580.19208-100000@mimas.fachschaften.tu-muenchen.de> <Pine.LNX.4.33.0201042324210.14208-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201042324210.14208-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25-current-20020102i (Linux 2.4.17-spc i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jan 04 2002, Ingo Molnar wrote:

> thanks for the detective work - i've reverted this part of the 2.4.17
> patch and have uploaded the -A2 patch.

The -A2 patch applies well to 2.4.17, however compilation fails:

[....]
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6    -DEXPORT_SYMTAB -c filemap.c
In file included from filemap.c:26:
/usr/src/linux/include/linux/compiler.h:13: warning: likely' redefined
/usr/src/linux/include/linux/sched.h:445: warning: this is the location of
the previous definition
/usr/src/linux/include/linux/compiler.h:14: warning: unlikely' redefined
/usr/src/linux/include/linux/sched.h:444: warning: this is the location of
the previous definition
filemap.c: In function page_cache_read':
filemap.c:696: SCHED_YIELD' undeclared (first use in this function)
filemap.c:696: (Each undeclared identifier is reported only once
filemap.c:696: for each function it appears in.)
make[2]: *** [filemap.o] Error 1
make[2]: Leaving directory /usr/src/linux/mm'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory /usr/src/linux/mm'
make: *** [_dir_mm] Error 2
elfie:/usr/src/linux #

-- 
# Heinz Diehl, 68259 Mannheim, Germany
