Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129862AbQKASZJ>; Wed, 1 Nov 2000 13:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130473AbQKASZA>; Wed, 1 Nov 2000 13:25:00 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:32271 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S129862AbQKASYt>; Wed, 1 Nov 2000 13:24:49 -0500
Date: Wed, 1 Nov 2000 10:22:16 -0800
From: Richard Henderson <rth@twiddle.net>
To: tytso@mit.edu
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Jakub Jelinek <jakub@redhat.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10-pre6: Use of abs()
Message-ID: <20001101102216.A18206@twiddle.net>
In-Reply-To: <200010281629.e9SGTah07672@sleipnir.valparaiso.cl> <39FD7F2C.9A3F3976@evision-ventures.com> <20001030081938.K6207@devserv.devel.redhat.com> <39FD9E6A.AD10E699@evision-ventures.com> <20001101094619.A15283@trampoline.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20001101094619.A15283@trampoline.thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 09:46:19AM -0500, tytso@mit.edu wrote:
> What versions of gcc produce the built-in functions?

2.95 and previous.  In 2.96 somewhere we fixed a bug that
automatically prototypes these builtin functions for you;
ie with current code you get an undeclared function warning.

> And does it do so for *all* platforms?  (i.e., PPC, Alpha,
> IA64, etc., etc., etc.)

Yes.  The thing about abs, though, is that it's "int abs(int)"
which does naughty things with longs on 64-bit targets.  You're
much better off writing (x < 0 ? -x : x) directly.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
