Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLRPeM>; Mon, 18 Dec 2000 10:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbQLRPeC>; Mon, 18 Dec 2000 10:34:02 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:45572 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129391AbQLRPdz>; Mon, 18 Dec 2000 10:33:55 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14910.10020.692884.302587@wire.cadcamlab.org>
Date: Mon, 18 Dec 2000 09:03:00 -0600 (CST)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Daiki Matsuda <dyky@df-usa.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 asm-alpha/system.h has a problem
In-Reply-To: <20001217153444N.dyky@df-usa.com>
	<20001218033154.F3199@cadcamlab.org>
	<20001218154907.A16749@athlon.random>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Peter Samuelson]
> > You are changing perfectly legal C.

[Andrea Arcangeli]
> You're right that's not kernel issue and patch can be rejected, but
> he's not really changing anything :). If changing that helps then
> it's a compiler bug.

Not a compiler bug, a source bug of assuming a C header file can be
included by a C++ program.  The right solution, as always, is to make a
copy of the header (assuming you really do need it) and edit the copy
as necessary.  This is a simple variation on the #ifdef __KERNEL__
issue.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
