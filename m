Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbTIKVrf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbTIKVrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:47:35 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:6919 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261558AbTIKVrc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:47:32 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: 11 Sep 2003 21:38:37 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bjqq0t$tu5$1@gatekeeper.tmr.com>
References: <bjqk1p$t9r$1@gatekeeper.tmr.com> <1063313075.3881.4.camel@dhcp23.swansea.linux.org.uk>
X-Trace: gatekeeper.tmr.com 1063316317 30661 192.168.12.62 (11 Sep 2003 21:38:37 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1063313075.3881.4.camel@dhcp23.swansea.linux.org.uk>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
| On Iau, 2003-09-11 at 20:56, bill davidsen wrote:
| > | When we know at compile time it's not needed, it should not be enabled.
| > 
| > Clearly that's right. This buys nothing on CPUs which don't have the
| > problem, why have *any* overhead in size and speed? It's too bad that
| > people have to read around all that code, they don't need to give it a
| > home in their RAM and execute it as well.
| 
| We have always built kernels that contained the support for older chips.
| A 586 kernel for example is minutely slowed by the fact it will run on
| the Pentium Pro.
| 
| If someone wants to put in clear "this CPU only" stuff as well then
| fine, but with my distributor hat on I defy you to benchmark the
| difference in the real world between PIV and PIV with 100 bytes of extra
| workaround code.

I was not even thinking of CPU overhead, embedded applications benchmark
changes with "size" rather than "/bin/time" and this code is relatively
large and unlikely to be useful on any embedded system.

| You could get that much code back by spending 10 minutes tidying some
| random other piece of code you use, or shortening a couple of printk
| messages.

Perhaps for 2.7 a good case could be made for i18n on some of the
printk's, including some very small messages indeed for the embedded
folks. Most are not overly verbose now, but could be replaced by
abbreviations, or a magic message number.

I'm not against the fix, I do 5-6 hours a week on a K7-1400 original
Athlon, and I'll be running applications on some Duron boxen late this
year. I just find the work done to support embedded applications
evidence that 2.6 will be better than 2.6 without nearly as much
hacking. This code is large enough that a few ifdefs will have less
effect size on the kernel source than the lack of them will on the
binary.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
