Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130210AbQKBLV0>; Thu, 2 Nov 2000 06:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129873AbQKBLVR>; Thu, 2 Nov 2000 06:21:17 -0500
Received: from [195.63.194.11] ([195.63.194.11]:28933 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S129734AbQKBLVL>; Thu, 2 Nov 2000 06:21:11 -0500
Message-ID: <3A015AB9.D3B80830@evision-ventures.com>
Date: Thu, 02 Nov 2000 13:14:49 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Richard Henderson <rth@twiddle.net>
CC: tytso@mit.edu, Jakub Jelinek <jakub@redhat.com>,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10-pre6: Use of abs()
In-Reply-To: <200010281629.e9SGTah07672@sleipnir.valparaiso.cl> <39FD7F2C.9A3F3976@evision-ventures.com> <20001030081938.K6207@devserv.devel.redhat.com> <39FD9E6A.AD10E699@evision-ventures.com> <20001101094619.A15283@trampoline.thunk.org> <20001101102216.A18206@twiddle.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson wrote:
> 
> On Wed, Nov 01, 2000 at 09:46:19AM -0500, tytso@mit.edu wrote:
> > What versions of gcc produce the built-in functions?
> 
> 2.95 and previous.  In 2.96 somewhere we fixed a bug that
> automatically prototypes these builtin functions for you;
> ie with current code you get an undeclared function warning.
> 
> > And does it do so for *all* platforms?  (i.e., PPC, Alpha,
> > IA64, etc., etc., etc.)
> 
> Yes.  The thing about abs, though, is that it's "int abs(int)"
> which does naughty things with longs on 64-bit targets.  You're
> much better off writing (x < 0 ? -x : x) directly.

Thank's for answering it... I was already looking up the GCC source for
an exact answer ;-). However what's the difference in respect of
optimization between unrolling the abs function by hand and
relying on the built in?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
