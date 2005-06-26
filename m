Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVFZGvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVFZGvi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 02:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVFZGvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 02:51:38 -0400
Received: from tornado.reub.net ([60.234.136.108]:59115 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S261394AbVFZGvG (ORCPT
	<rfc822;<linux-kernel@vger.kernel.org>>);
	Sun, 26 Jun 2005 02:51:06 -0400
Message-ID: <42BE5058.4070307@reub.net>
Date: Sun, 26 Jun 2005 18:51:04 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050624)
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: "Theodore Ts'o" <tytso@mit.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <fa.d8odcmh.1u56sbb@ifi.uio.no> <fa.cg8nk4u.jj8tqg@ifi.uio.no>
In-Reply-To: <fa.cg8nk4u.jj8tqg@ifi.uio.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 25/06/2005 12:38 a.m., Hans Reiser wrote:
> fsck is better in V4 than it is in V3. Users should move from V3 to V4,
> as V3 is obsolete. I agree on that Ted.

Perhaps before moving to V4, reiser4progs-1.04 (the most recent I think) could 
be made to compile with gcc4/fedora core 4 system, and some of the warnings 
cleaned up.  There are a fair lot of them - all the same warnings as below but 
in a heap of different files.

Then of course the other slightly annoying issue that it actually aborts the 
compilation:

[from rpmbuild -ta reiser4progs-1.0.4.tar.gz]

  gcc -DHAVE_CONFIG_H -I. -I. -I../../.. -I../../../include -D_REENTRANT
-D_FILE_OFFSET_BITS=64 -DENABLE_SYMLINKS -DENABLE_SPECIAL -DENABLE_R5_HASH
-DENABLE_FNV1_HASH -DENABLE_RUPASOV_HASH -DENABLE_TEA_HASH -DENABLE_DEG_HASH
-DENABLE_LARGE_KEYS -DENABLE_SHORT_KEYS -DENABLE_DOT_O_FIBRE
-DENABLE_EXT_1_FIBRE -DENABLE_EXT_3_FIBRE -DENABLE_LEXIC_FIBRE -O1 -g -O2 -g
-pipe -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -m32 -march=i386 -mtune=pentium4
-fasynchronous-unwind-tables -W -Wall -Wno-unused-parameter -Wredundant-decls
-MT liboid40_static_la-oid40.lo -MD -MP -MF .deps/liboid40_static_la-oid40.Tpo
-c oid40.c  -fPIC -DPIC -o .libs/liboid40_static_la-oid40.o
oid40.c: In function 'oid40_get_state':
oid40.c:12: warning: passing argument 6 of '__actual_assert' discards 
qualifiers from pointer target type
oid40.c: In function 'oid40_get_next_oid':
oid40.c:19: warning: passing argument 6 of '__actual_assert' discards
qualifiers from pointer target type
oid40.c: In function 'oid40_get_used_oid':
oid40.c:25: warning: passing argument 6 of '__actual_assert' discards
qualifiers from pointer target type
oid40.c: In function 'oid40_set_state':
oid40.c:32: warning: passing argument 6 of '__actual_assert' discards
qualifiers from pointer target type
oid40.c: In function 'oid40_set_next_oid':
oid40.c:39: warning: passing argument 6 of '__actual_assert' discards
qualifiers from pointer target type
oid40.c: In function 'oid40_set_used_oid':
oid40.c:46: warning: passing argument 6 of '__actual_assert' discards
qualifiers from pointer target type
oid40.c: In function 'oid40_open':
oid40.c:56: warning: passing argument 6 of '__actual_assert' discards
qualifiers from pointer target type
oid40.c:66: warning: passing argument 6 of '__actual_assert' discards
qualifiers from pointer target type
oid40.c: In function 'oid40_close':
oid40.c:76: warning: passing argument 6 of '__actual_assert' discards
qualifiers from pointer target type
oid40.c: In function 'oid40_create':
oid40.c:97: warning: passing argument 6 of '__actual_assert' discards
qualifiers from pointer target type
oid40.c: In function 'oid40_sync':
oid40.c:111: warning: passing argument 6 of '__actual_assert' discards
qualifiers from pointer target type
oid40.c:122: warning: passing argument 6 of '__actual_assert' discards
qualifiers from pointer target type
oid40.c:125: warning: passing argument 6 of '__actual_assert' discards
qualifiers from pointer target type
oid40.c: In function 'oid40_allocate':
oid40.c:133: warning: passing argument 6 of '__actual_assert' discards
qualifiers from pointer target type
oid40.c: In function 'oid40_release':
oid40.c:146: warning: passing argument 6 of '__actual_assert' discards
qualifiers from pointer target type
oid40.c: In function 'oid40_free':
oid40.c:154: warning: passing argument 6 of '__actual_assert' discards
qualifiers from pointer target type
oid40.c: In function 'oid40_valid':
oid40.c:160: warning: passing argument 6 of '__actual_assert' discards
qualifiers from pointer target type
oid40.c: At top level:
oid40.c:204: error: static declaration of 'oid40_plug' follows non-static
declaration
oid40.h:33: error: previous declaration of 'oid40_plug' was here
make[4]: *** [liboid40_static_la-oid40.lo] Error 1
make[4]: Leaving directory
`/usr/src/redhat/BUILD/reiser4progs-1.0.4/plugin/oid/oid40'
make[3]: *** [all-recursive] Error 1
make[3]: Leaving directory `/usr/src/redhat/BUILD/reiser4progs-1.0.4/plugin/oid'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/usr/src/redhat/BUILD/reiser4progs-1.0.4/plugin'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/usr/src/redhat/BUILD/reiser4progs-1.0.4'
make: *** [all] Error 2
error: Bad exit status from /var/tmp/rpm-tmp.23778 (%build)


RPM build errors:
     Bad exit status from /var/tmp/rpm-tmp.23778 (%build)
[root@tornado tarballs]#


I use ReiserFS4 on two squid cache/object partitions and it has been stable 
and performs well. But I haven't been in the ugly situation of having to 
actually compile and run an fsck on it yet...

reuben



