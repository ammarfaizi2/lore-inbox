Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266555AbSLWFE6>; Mon, 23 Dec 2002 00:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266565AbSLWFE6>; Mon, 23 Dec 2002 00:04:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41480 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266555AbSLWFE5>; Mon, 23 Dec 2002 00:04:57 -0500
Date: Sun, 22 Dec 2002 21:14:07 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: LKML <linux-kernel@vger.kernel.org>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>
Subject: Re: [RESEND][PATCH] better compat_jiffies_to_clock_t
In-Reply-To: <20021223145439.368d4d05.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0212222112490.1225-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Dec 2002, Stephen Rothwell wrote:
>
> At David Mosberger's suggestion can we use this new version of
> compat_jiffies_to_clock_t?  It does better rounding and will not fail
> if COMPAT_USER_HZ > HZ.

I don't like using "long long" and divisions.

Since this code is currently only used for 64-bit targets, is there any
reason to use "long long" at all, and not just use "long"? I can see a
64-bit target where "long long" would be 128 bits, and this would do the
wrong thing.

		Linus

