Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129780AbRAaLKt>; Wed, 31 Jan 2001 06:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130017AbRAaLKj>; Wed, 31 Jan 2001 06:10:39 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:14867 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129780AbRAaLK3>; Wed, 31 Jan 2001 06:10:29 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14967.62112.447929.546585@wire.cadcamlab.org>
Date: Wed, 31 Jan 2001 05:10:24 -0600 (CST)
To: Tom Leete <tleete@mountain.net>
Cc: David Ford <david@linux.com>, Stephen Frost <sfrost@snowman.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
In-Reply-To: <3A777E1A.8F124207@linux.com>
	<20010130220148.Y26953@ns>
	<3A77966E.444B1160@linux.com>
	<3A77C6E7.606DDA67@mountain.net>
	<20010131042616.A32636@cadcamlab.org>
	<3A77ED7F.466582F0@mountain.net>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Tom Leete]
> No, I'm saying that SMP locking etc. is compatible with Athlon.  The
> failure to build is not a workaround but a coding error.  SMP builds
> for UP machines are supposed to work.

Yes, but if SMP for Athlons is not supported, what is the point in
allowing CONFIG_SMP + CONFIG_MK7 (or CONFIG_SMP + CONFIG_MK6)?  Such a
kernel will not run on *any* SMP system, since AMD kernels do not work
on Intel.  If an AMD user really wants to carry around SMP baggage for
no reason, let him use CONFIG_M586TSC.

This is like offering MCA-bus drivers for 'make config' on SPARC.
Sure, they might compile, but nobody will have any use for them.  Thus,
we ensure that they never appear on the menus in the first place.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
