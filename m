Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136438AbREINZu>; Wed, 9 May 2001 09:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136441AbREINZm>; Wed, 9 May 2001 09:25:42 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:13898 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136438AbREINZ2>; Wed, 9 May 2001 09:25:28 -0400
Date: Wed, 9 May 2001 15:25:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Kurt Garloff <garloff@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs MAP_SHARED corruption fix
Message-ID: <20010509152517.E2506@athlon.random>
In-Reply-To: <20010508160050.F543@athlon.random> <shs3dafvpcx.fsf@charged.uio.no> <20010508173847.I22739@garloff.suse.de> <15096.61962.130340.998058@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15096.61962.130340.998058@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, May 09, 2001 at 09:30:18AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 09:30:18AM +0200, Trond Myklebust wrote:
> Here therefore is Andrea's patch with the changes I propose. Opinions?

flushing the dirty pages before locks is probably not required, a dirty
page in the dirty_pages list is no different than a mapped page not in
the dirty_pages list but only with the pte marked dirty, and we cannot flush
the pages with only the pte marked dirty before the locks, but flushing
the dirty_pgaes list won't hurt so overall it looks ok to me.

Andrea
