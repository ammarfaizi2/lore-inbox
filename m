Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbSKKLBq>; Mon, 11 Nov 2002 06:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265668AbSKKLBq>; Mon, 11 Nov 2002 06:01:46 -0500
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:10603 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id <S265484AbSKKLBp>; Mon, 11 Nov 2002 06:01:45 -0500
Date: Mon, 11 Nov 2002 05:55:10 -0500 (EST)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.47 NFSv4 compile error
Message-ID: <Pine.LNX.4.44.0211110545420.12624-100000@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fs/nfsd/nfs4proc.c: In function `nfsd4_write':
fs/nfsd/nfs4proc.c:484: warning: passing arg 4 of `nfsd_write' from 
incompatible pointer type
fs/nfsd/nfs4proc.c:484: warning: passing arg 6 of `nfsd_write' makes 
integer from pointer without a cast
fs/nfsd/nfs4proc.c:484: too few arguments to function `nfsd_write'
fs/nfsd/nfs4proc.c: In function `nfsd4_proc_compound':
fs/nfsd/nfs4proc.c:568: structure has no member named `rq_resbuf'
fs/nfsd/nfs4proc.c:569: structure has no member named `rq_resbuf'
fs/nfsd/nfs4proc.c:569: structure has no member named `rq_resbuf'
make[2]: *** [fs/nfsd/nfs4proc.o] Error 1
make[1]: *** [fs/nfsd] Error 2
make: *** [fs] Error 2


.config

CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
# CONFIG_NFSD_TCP is not set


My gcc is 3.1.1.   I get same error using gcc 3.2.  When I take out 
CONFIG_NFS_V4 and CONFIG_NFSD_V4 it compiles just fine.


John Kim

