Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281836AbRKWARy>; Thu, 22 Nov 2001 19:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281834AbRKWARo>; Thu, 22 Nov 2001 19:17:44 -0500
Received: from mons.uio.no ([129.240.130.14]:34457 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S281832AbRKWAR3>;
	Thu, 22 Nov 2001 19:17:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15357.38291.883472.720575@charged.uio.no>
Date: Fri, 23 Nov 2001 01:17:23 +0100
To: J Sloan <jjs@pobox.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sunrpc woes with tux2 in 2.4.15-pre8,9
In-Reply-To: <3BFD9078.63FE28F2@pobox.com>
In-Reply-To: <3BFD7633.2525641E@pobox.com>
	<shsn11eidv0.fsf@charged.uio.no>
	<3BFD9078.63FE28F2@pobox.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Something is indeed very wrong. Your setup uses a PIII, and no SMP. It
shouldn't be requiring atomic_dec_and_lock() at all. Certainly this is
the case on my own setup on stock 2.4.15-pre9.

Could you check that the TUX patch isn't squashing the #define and
test for ATOMIC_DEC_AND_LOCK that is contained in
include/linux/spinlock.h in the stock Linus kernel. The latter is a
workaround that is designed to stop MODVERSIONS from interfering with
the re-#definition of atomic_dec_and_lock() in spinlock.h.

Cheers,
   Trond
