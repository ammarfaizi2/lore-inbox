Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132206AbQL2UOn>; Fri, 29 Dec 2000 15:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132228AbQL2UOc>; Fri, 29 Dec 2000 15:14:32 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:32352 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132206AbQL2UOY>; Fri, 29 Dec 2000 15:14:24 -0500
Date: Fri, 29 Dec 2000 20:43:33 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Matt Liotta <mliotta@teamtoolz.com>
Cc: "'Andi Kleen'" <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Petru Paler <ppetru@ppetru.net>, Jure Pecar <pegasus@telemach.net>,
        linux-kernel@vger.kernel.org, thttpd@bomb.acme.com
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
Message-ID: <20001229204333.E16261@athlon.random>
In-Reply-To: <85F1402515F13F498EE9FBBC5E07594220ABD2@TTGCS.teamtoolz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85F1402515F13F498EE9FBBC5E07594220ABD2@TTGCS.teamtoolz.net>; from mliotta@teamtoolz.com on Fri, Dec 29, 2000 at 11:29:12AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 11:29:12AM -0800, Matt Liotta wrote:
> as such doesn't scale well with Linux 2.2 on a dual CPU machine.  Our
> benchmarks show that we can handle more load on a single CPU machine then a
> dual CPU one with Linux 2.2.  However, it is encouraging to see that the

If for whatever reason you can't use 2.4.x on it right now, in 2.2.19pre3aa4
there's an hack to do tcp_sendmsg checksum and all the copy_user (copies
between pagecache and userspace) with the big kernel lock released (so that it
can scale better in SMP). That's ugly but people on this list asked for this
feature and since it was very fast to implement it I added it. But don't expect
anything like 2.4.x SMP scalability!

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
