Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132292AbRAKSnv>; Thu, 11 Jan 2001 13:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132800AbRAKSnl>; Thu, 11 Jan 2001 13:43:41 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11296 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132292AbRAKSng>; Thu, 11 Jan 2001 13:43:36 -0500
Date: Thu, 11 Jan 2001 19:43:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Russell King <rmk@arm.linux.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>,
        Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
Message-ID: <20010111194354.F3560@athlon.random>
In-Reply-To: <20010110013755.D13955@suse.de> <200101100654.f0A6sjJ02453@flint.arm.linux.org.uk> <20010110163158.F19503@athlon.random> <shszogy2jmr.fsf@charged.uio.no> <3A5DDD09.C8C70D36@colorfullife.com> <14941.61668.697523.866481@charged.uio.no> <shsae8y2blg.fsf@charged.uio.no> <20010111192758.E3560@athlon.random> <14941.64473.902580.756312@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14941.64473.902580.756312@charged.uio.no>; from trond.myklebust@fys.uio.no on Thu, Jan 11, 2001 at 07:30:49PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 07:30:49PM +0100, Trond Myklebust wrote:
> OK. In that case my patch, would just be amended to eliminate the
> redundant comparison as is the case below.

This patch looks fine w.r.t. alignment but given the below seems called
at runtime (not just at mount time) for performance and to save a dozen of bytes
of kernel stack it would probably better to use the nfs_fh structure in
2.2.19pre7 for the in-kernel representation and to define a new structure for
userspace message passing (defined as the nfs_fh in 2.2.19pre6). But at least
now we see _why_ it broke ;)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
