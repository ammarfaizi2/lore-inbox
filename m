Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317278AbSIAQge>; Sun, 1 Sep 2002 12:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317264AbSIAQge>; Sun, 1 Sep 2002 12:36:34 -0400
Received: from mons.uio.no ([129.240.130.14]:23796 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317263AbSIAQgd>;
	Sun, 1 Sep 2002 12:36:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15730.17171.162970.367575@charged.uio.no>
Date: Sun, 1 Sep 2002 18:40:51 +0200
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
In-Reply-To: <1030890022.2145.52.camel@ldb>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
	<1030822731.1458.127.camel@ldb>
	<15729.17279.474307.914587@charged.uio.no>
	<1030835635.1422.39.camel@ldb>
	<15730.4100.308481.326297@charged.uio.no>
	<15730.8121.554630.859558@charged.uio.no>
	<1030890022.2145.52.camel@ldb>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Luca Barbieri <ldb@ldb.ods.org> writes:

    >> You are forgetting that the fscred might simultaneously be
    >> referenced by an open struct file. Are you saying that this
    >> file should suddenly see its credential change?
     > No, it cannot be referenced by an open struct file because you
     > copy the structure, not pointers to it.

So you are proposing to optimize for the rare case of setuid(),
instead of the more common case of file open()?

Cheers,
  Trond
