Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288655AbSAQNCm>; Thu, 17 Jan 2002 08:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288657AbSAQNCb>; Thu, 17 Jan 2002 08:02:31 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55308 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S288655AbSAQNCO>; Thu, 17 Jan 2002 08:02:14 -0500
Date: Thu, 17 Jan 2002 08:01:50 -0500
Message-Id: <200201171301.IAA01133@gatekeeper.tmr.com>
To: rml@tech9.net
Subject: Re: [PATCH] I3 sched tweaks...
Newsgroups: mail.linux-kernel
In-Reply-To: <1011216429.1083.95.camel@phantasy>
In-Reply-To: <1011215946.314.14.camel@gs256.sp.cs.cmu.edu>
Organization: TMR Associates, Schenectady NY
Cc: linux-kernel@vger.kernel.org
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1011216429.1083.95.camel@phantasy> you write:
| On Wed, 2002-01-16 at 16:19, Justin Carlson wrote:
| 
| > Don't forget that, in non-x86 land, current tends to be just kept in a 
| > register.  No computations required.  Certainly passing it around on,
| > e.g. mips is a clear loss.
| 
| current is stored in a register (esp) in x86, too.  This is why I
| cautioned that looking up current was cheap -- I think every sane arch
| stores current in some fast access way.  That's why it is a macro -- it
| is assembly code to quickly snag the address.
| 
| So is passing current still worth it?

  It sounds as if it may be one of those "it depends" things, but if
current is not calculated the exact same way in all places... people
talk about coloring (or colouring in Canada) and several other things I
forget, it's sort of nice to be sure it's calculated just once, and that
if the calculation becomes more expensive in the future that the
tradeoff between passing and calculating won't change.

  I guess passing is safer for the future and of a known cost.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
