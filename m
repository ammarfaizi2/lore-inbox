Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132057AbREFCqC>; Sat, 5 May 2001 22:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131626AbREFCpx>; Sat, 5 May 2001 22:45:53 -0400
Received: from bitmover.com ([207.181.251.162]:21352 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S131497AbREFCpk>;
	Sat, 5 May 2001 22:45:40 -0400
Date: Sat, 5 May 2001 19:45:36 -0700
From: Larry McVoy <lm@bitmover.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org,
        BitKeeper Development Source <dev@bitmover.com>
Subject: Re: Wow! Is memory ever cheap!
Message-ID: <20010505194536.D14127@work.bitmover.com>
Mail-Followup-To: Chris Wedgwood <cw@f00f.org>,
	linux-kernel@vger.kernel.org,
	BitKeeper Development Source <dev@work.bitmover.com>
In-Reply-To: <20010505095802.X12431@work.bitmover.com> <20010506142043.B31269@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <20010506142043.B31269@metastasis.f00f.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2001 at 02:20:43PM +1200, Chris Wedgwood wrote:
> 1.5GB without ECC? Seems like a disater waiting to happen? Is ECC
> memory much more expensive?

Almost twice as expensive for 512MB dimms.

I used to be a die hard ECC fan but that changed since what we do here is
BitKeeper and BitKeeper checksums everything.  It tells us right away when
we have problems (to date it has found bad memory dimms, NFS corruption,
and a SPARC/Linux cache aliasing bug).  So I've given up in ECC, we don't
need it.

On the other hand, if your apps don't have built in integrity checks then
ECC is pretty much a requirement.

By the way, the integrity checks don't need to be complicated, BK uses
a horrible 16 bit ignore the overflow checksum to be compat with SCCS
and it seems to have caught everything that much more sophisticated and
CPU intensive checksums have caught.  In other words, anything is much
much better than nothing.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
