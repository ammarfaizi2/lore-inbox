Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262212AbTIOAA3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 20:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbTIOAA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 20:00:28 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:39437 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262212AbTIOAA1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 20:00:27 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: 14 Sep 2003 23:51:26 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bk2utu$fne$1@gatekeeper.tmr.com>
References: <20030912182216.GK27368@fs.tum.de> <20030912202851.3529e7e7.ak@suse.de>
X-Trace: gatekeeper.tmr.com 1063583486 16110 192.168.12.62 (14 Sep 2003 23:51:26 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030912202851.3529e7e7.ak@suse.de>,
Andi Kleen  <ak@suse.de> wrote:
| On Fri, 12 Sep 2003 20:22:16 +0200
| Adrian Bunk <bunk@fs.tum.de> wrote:
| 
| 
| > 
| > But even CONFIG_X86_GENERIC doesn't do what you expect. A kernel 
| > compiled for Athlon wouldn't run on a Pentium 4 even with 
| > CONFIG_X86_GENERIC.
| 
| It does. Just try it.
| 
| > 
| > Quoting arch/i386/Kconfig in -test5:
| > 
| > <--  snip  -->
| > 
| > config X86_USE_3DNOW
| >         bool
| >         depends on MCYRIXIII || MK7
| >         default y
| 
| That's obsolete and could be removed. All 3dnow! code is dynamically patched depending on the CPUID.

And if that isn't all in init it's another good target for getting rid
of bloat. You suggested people look for other places, here's one.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
