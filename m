Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281832AbRKWBtP>; Thu, 22 Nov 2001 20:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281844AbRKWBtG>; Thu, 22 Nov 2001 20:49:06 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:61057 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S281832AbRKWBs7>;
	Thu, 22 Nov 2001 20:48:59 -0500
Message-ID: <3BFDAB08.28F8B5C8@pobox.com>
Date: Thu, 22 Nov 2001 17:48:56 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.15-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no, linux-kernel <linux-kernel@vger.kernel.org>
CC: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: sunrpc woes with tux2 in 2.4.15-pre8,9
In-Reply-To: <3BFD7633.2525641E@pobox.com>
		<shsn11eidv0.fsf@charged.uio.no>
		<3BFD9078.63FE28F2@pobox.com> <15357.38291.883472.720575@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

> Something is indeed very wrong. Your setup uses a PIII, and no SMP. It
> shouldn't be requiring atomic_dec_and_lock() at all. Certainly this is
> the case on my own setup on stock 2.4.15-pre9.
>
> Could you check that the TUX patch isn't squashing the #define and
> test for ATOMIC_DEC_AND_LOCK that is contained in
> include/linux/spinlock.h in the stock Linus kernel. The latter is a
> workaround that is designed to stop MODVERSIONS from interfering with
> the re-#definition of atomic_dec_and_lock() in spinlock.h.

Yes, it looks like he's doing just that -

I built it with smp enabled and the problem
goes away, so it's an implicit assumption
of smp in the current tux code.

cu

jjs

