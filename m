Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAHXTV>; Mon, 8 Jan 2001 18:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbRAHXTL>; Mon, 8 Jan 2001 18:19:11 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:4872 "EHLO
	mf1.private") by vger.kernel.org with ESMTP id <S129226AbRAHXSz>;
	Mon, 8 Jan 2001 18:18:55 -0500
Date: Mon, 8 Jan 2001 15:22:44 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.30.0101081352400.954-100000@mf2.private>
Message-ID: <Pine.LNX.4.30.0101081515090.18737-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Wayne Whitney wrote:

> On Mon, 8 Jan 2001, Szabolcs Szakacsits wrote:
>
> > AFAIK newer glibc = CVS glibc but the malloc() tune parameters work
> > via environment variables for the current stable ones as well,
>
> I'll arrange a binary linked against glibc2.2, and then your suggestion
> will hopefully do the trick.  Thanks for your kind help!

OK, I now have a binary dynamically linked against /lib/libc.so.6,
(according to ldd), and that points to glibc-2.1.92.  And I tried setting
the environment variables you suggested, I checked that they are set and
checked that they appear in /lib/libc.so.6.  But the behaviour is
unchanged:  MAGMA still hits this barrier at 830M (not 870M, that was a
typo).

I guess I conclude that either (1) MAGMA does not use libc's malloc
(checking on this, I doubt it) or (2) glibc-2.1.92 knows of these
variables but has not yet implemented the tuning (I'll try glibc-2.2) or
(3) this is not the problem.

I'll look at Andrea's hack as well.  Thanks for everybody's help!

Cheers, Wayne






-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
