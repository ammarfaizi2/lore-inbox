Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132357AbQLRSpv>; Mon, 18 Dec 2000 13:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132418AbQLRSpb>; Mon, 18 Dec 2000 13:45:31 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:26612 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S132357AbQLRSp0>; Mon, 18 Dec 2000 13:45:26 -0500
Date: Mon, 18 Dec 2000 12:15:00 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <14910.10020.692884.302587@wire.cadcamlab.org>
In-Reply-To: <20001217153444N.dyky@df-usa.com> <20001218033154.F3199@cadcamlab.org> 
	<20001218154907.A16749@athlon.random>
Subject: Re: 2.2.18 asm-alpha/system.h has a problem
X-Mailer: The Polarbar Mailer; version=1.19; build=71
Message-Id: <20001218184531Z132357-439+4699@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Peter Samuelson <peter@cadcamlab.org> on Mon, 18 Dec
2000 09:03:00 -0600 (CST)


> Not a compiler bug, a source bug of assuming a C header file can be
> included by a C++ program.  The right solution, as always, is to make a
> copy of the header (assuming you really do need it) and edit the copy
> as necessary. 

That just creates more maintenance problems.  What if the kernel header file
changes?  Then he'll have to change his copy as well.  He'll forever need to
check changes in that kernel header file, or risk having an obscure bug that's
otherwise hard to track.


Yes, it's perfectly valid C, but so what?  That doesn't mean that it's a good
idea.  It does no harm to make a minor change to the header file to allow a C++
compiler to digest it.  I consider it to be a "professional courtesy" of a C
programmer for a C++ programmer.  All the C programmer needs to do is
acknowledge that someone might want to use a C++ compiler on the code, and just
make a few minor changes that have no negative affect at all.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
