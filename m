Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284871AbRLFAMi>; Wed, 5 Dec 2001 19:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284872AbRLFAM3>; Wed, 5 Dec 2001 19:12:29 -0500
Received: from [202.135.142.194] ([202.135.142.194]:45326 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S284871AbRLFAMR>; Wed, 5 Dec 2001 19:12:17 -0500
Date: Thu, 6 Dec 2001 11:13:06 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: mfedyk@matchmail.com, hps@intermeta.de, lm@bitmover.com,
        jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
Message-Id: <20011206111306.6ce4039e.rusty@rustcorp.com.au>
In-Reply-To: <Pine.GSO.4.21.0112010003410.7958-100000@binet.math.psu.edu>
In-Reply-To: <20011130201235.A489@mikef-linux.matchmail.com>
	<Pine.GSO.4.21.0112010003410.7958-100000@binet.math.psu.edu>
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Dec 2001 00:14:54 -0500 (EST)
Alexander Viro <viro@math.psu.edu> wrote:

> 
> 
> On Fri, 30 Nov 2001, Mike Fedyk wrote:
> 
> > This is Linux-Kernel.  Each developer is on their own on how they pay the
> > their bills.  The question is... Why not accept a *driver* that *works* but
> > the source doesn't look so good?
> 
> Because this "works" may very well include exploitable buffer overruns in
> kernel mode.  I had seen that - ioctl() assuming that nobody would pass

And: bad code spreads.  Anyone who has done infrastructure change in the
kernel sees this: people copy (presumed) working code.

Hence I now lean towards "change EVERYTHING" rather than "wrap old source, add
new", and "fix even if not broken", eg. my "set_bit needs a long" patch which
also changed x86-specific code (where it doesn't matter).

Cheers,
Rusty.
-- 
  Anyone who quotes me is an idiot. -- Rusty Russell.
