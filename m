Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268940AbRIHKxe>; Sat, 8 Sep 2001 06:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268963AbRIHKxZ>; Sat, 8 Sep 2001 06:53:25 -0400
Received: from mons.uio.no ([129.240.130.14]:63987 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S268940AbRIHKxN>;
	Sat, 8 Sep 2001 06:53:13 -0400
MIME-Version: 1.0
Message-ID: <15257.63655.764646.844202@charged.uio.no>
Date: Sat, 8 Sep 2001 12:53:27 +0200
To: "Mike Black" <mblack@csihq.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8 NFS Problems
In-Reply-To: <04c301c137b4$34604590$e1de11cc@csihq.com>
In-Reply-To: <024f01c13601$c763d3c0$e1de11cc@csihq.com>
	<shsae07md9d.fsf@charged.uio.no>
	<033a01c1379e$e3514880$e1de11cc@csihq.com>
	<15256.56528.460569.700469@charged.uio.no>
	<04c301c137b4$34604590$e1de11cc@csihq.com>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Mike Black <mblack@csihq.com> writes:

     > The file is being copied from yeti to picard.  Last packet seen
     > is picard telling yeti "OK" after the commit.  If soft timeouts
     > were occurring shouldn't we be seeing packets from yeti again
     > with no response from picard?

You are assuming that the last packet seen is the one that corresponds
to your read. In doing so, you are neglecting the fact that these are
asynchronous reads, and that file readahead can muddle the waters for
you.

Look, this is getting us nowhere. The bottom line is: if you are able
to reproduce the EIO on hard mounts it is a bug, and I'll be happy to
help you trace it. If it is occuring only on soft mounts, it is user
error...

Cheers,
  Trond
