Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbTLNCJM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 21:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265332AbTLNCJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 21:09:12 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47109 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265331AbTLNCJJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 21:09:09 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test11: i2c-dev.h for userspace
Date: 14 Dec 2003 01:57:44 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <brgg2n$i2v$1@gatekeeper.tmr.com>
References: <20031212145652.GA30747@convergence.de> <20031212175656.GA2933@kroah.com> <20031212185357.GB32169@convergence.de> <20031212190105.GB3038@kroah.com>
X-Trace: gatekeeper.tmr.com 1071367064 18527 192.168.12.62 (14 Dec 2003 01:57:44 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031212190105.GB3038@kroah.com>, Greg KH  <greg@kroah.com> wrote:

| They aren't.  The rule is:
| 	DO NOT INCLUDE KERNEL HEADER FILES IN USERSPACE TOOLS.
| Please read the archives for lkml on why this is true.
| 
| Yeah, we do need a way to have "sanitized" kernel headers so that
| userspace can include them, but for now, use what your libc provides.
| 
| So please use the headers that are present in the lmsensors project, or
| copy those headers into your project.
| 
| I don't want this thread to drag out into the usual argument for or
| against this issue, please.

I think you are pissing into the wind on this one, as long as people
have the choice between a kernel header which will always have the right
definitions and trying to find a header elsewhere which will work until
the kernel changes again, people are going to use kernel headers.

Not that I disagree with the intent at all, it's better software
engineering to do it that way. Your desired practice is totally correct
and a better way to do it.

However, in the real world, it might be a lot better to have an ABI
header directory, and to have both the user and kernel programs get
unformation from that. The kernel could do its thing and still be in
step with the user program (modulo recompilation when kernel development
is taking place). Packages and libraries could be compiled using the ABI
includes and be certain they would work on new kernels. And developers
would have a clear indication that if they changed things in the ABI
includes they would mess up compiled user programs. That's not a bad
thing either.

On a development kernel finding other headers is more work and less
reliable, human nature doesn't work well that way.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
