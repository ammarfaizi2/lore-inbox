Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263282AbTJUT42 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 15:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTJUT42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 15:56:28 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:2564 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263282AbTJUT4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 15:56:25 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [RFC] frandom - fast random generator module
Date: 21 Oct 2003 19:46:24 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn42eg$ic9$1@gatekeeper.tmr.com>
References: <HbGf.8rL.1@gated-at.bofh.it> <ugzng1axel.fsf@panda.mostang.com> <3F8EF17A.2040502@users.sf.net> <20031016144205.I7000@schatzie.adilger.int>
X-Trace: gatekeeper.tmr.com 1066765584 18825 192.168.12.62 (21 Oct 2003 19:46:24 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031016144205.I7000@schatzie.adilger.int>,
Andreas Dilger  <adilger@clusterfs.com> wrote:
| On Oct 16, 2003  21:28 +0200, Eli Billauer wrote:
| > Allow me to supply a couple facts about frandom:
| > 
| > * It's not a "crappy" RNG. Its RC4 origins and the fact, that it has 
| > passed tests indicate the opposite. A fast RNG doesn't necessarily mean 
| > a bad one. I doubt if any test will tell the difference between frandom 
| > and any other good RNG. You're most welcome to try.
| 
| The "crappy RNG" being referred to is just some code we implemented to
| give us somewhat unique numbers instead of sucking CPU.
| 
| > * Frandom is written completely in C. On an i686, gcc compiles the 
| > critical part to 26 assembly instructions per byte, and I doubt if any 
| > hand assembly would help significantly. The algorithms is clean and 
| > simple, and the compiler performs well with it.
| 
| This is still more expensive than a hw RNG (which will be about 1 ins
| per 4 bytes), so it would be nice to make this arch-specific if possible
| (runtime and compile time).

Clearly that's true inside the kernel. Although the speed will be
somewhat less because you may not always need four bytes, no?

The benefit of a random number source user programs can use, which is
going to avoid giving the same number to multiple processes or threads
is significant for simulations and sampling. It doesn't matter if this
is done with frandom or speeding urandom to similar speed, other than
that some people will protest a change in urandom, even a change for the
better.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
