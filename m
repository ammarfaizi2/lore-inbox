Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbTD3IZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 04:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbTD3IZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 04:25:09 -0400
Received: from vitelus.com ([64.81.243.207]:63239 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S261283AbTD3IZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 04:25:09 -0400
Date: Wed, 30 Apr 2003 01:36:07 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Daniel Phillips <dphillips@sistina.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
Message-ID: <20030430083607.GA6035@vitelus.com>
References: <200304300446.24330.dphillips@sistina.com> <20030430071907.GA30999@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030430071907.GA30999@alpha.home.local>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 09:19:07AM +0200, Willy Tarreau wrote:

> But gcc's optimizer seems to be even worse with each new version. The NIL
> checksum takes 3 times more to complete on gcc3/athlon than gcc2/athlon !!!
> And on some test, the P4 goes faster when the code is optimized for athlon
> than for P4 !

It would be interesting to compare the assembly output of the
compilers to see what's happening. The gcc folks appreciate test cases
and this function seems simple and sensitive enough to make a good one.

> ===== gcc-2.95.3 -march=i686 -O2 / athlon MP/2200 (1.8 GHz) =====

-march=athlon would give gcc a chance to make better scheduling
decisions, which could make the results more sensible.

> ==== gcc 3.2.3 -march=i686 -O3 / Pentium 4 / 2.0 GHz ====

This version of gcc accepts -march=pentium4, which again might make
gcc's behavior less bizarre.
