Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270688AbRHJXvX>; Fri, 10 Aug 2001 19:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270690AbRHJXvO>; Fri, 10 Aug 2001 19:51:14 -0400
Received: from eriador.apana.org.au ([203.14.152.116]:12296 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S270688AbRHJXu6>; Fri, 10 Aug 2001 19:50:58 -0400
Date: Sat, 11 Aug 2001 09:50:51 +1000
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Remotely rebooting a machine with state 'D' processes, how?
Message-ID: <20010811095051.A28624@gondor.apana.org.au>
In-Reply-To: <Pine.LNX.4.33.0108101557180.1048-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108101557180.1048-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.18i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2001 at 03:58:02PM -0700, Linus Torvalds wrote:
> 
> Besides, does the reboot system call actually get the BKL? I don't think
> it should need it..

Actually, the machine in question turned out to be UP :)

However, it does have RAID 1 and the notifier call chain stuff looks like
a killer to me since it leads to do_md_stop.

Perhaps we need a RESTART3 that restarts without notifying?
-- 
Debian GNU/Linux 2.2 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
