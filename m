Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272290AbTGYSKu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 14:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272324AbTGYSKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 14:10:43 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:41741 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S272310AbTGYSIk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 14:08:40 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
Date: 25 Jul 2003 18:16:15 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bfrs5f$os$1@gatekeeper.tmr.com>
References: <200307232046.46990.bernie@develer.com> <200307240007.15377.bernie@develer.com> <20030723222747.GF643@alpha.home.local> <200307242227.16439.bernie@develer.com>
X-Trace: gatekeeper.tmr.com 1059156975 796 192.168.12.62 (25 Jul 2003 18:16:15 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200307242227.16439.bernie@develer.com>,
Bernardo Innocenti  <bernie@develer.com> wrote:
| On Thursday 24 July 2003 00:27, Willy Tarreau wrote:
| 
| > On Thu, Jul 24, 2003 at 12:07:15AM +0200, Bernardo Innocenti wrote:
| > >    text    data     bss     dec     hex filename
| > >  633028   37952  134260  805240   c4978 linux-2.4.x/linux-Os
| > >  819276   52460   78896  950632   e8168 linux-2.5.x/vmlinux-inline-Os
| > >  ^^^^^^
| > >        2.6 still needs a hard diet... :-/
| >
| > I did the same observation a few weeks ago on 2.5.74/gcc-2.95.3. I tried
| > to track down the responsible, to the point that I completely disabled
| > every driver, networking option and file-system, just to see, and got about
| > a 550 kB vmlinux compiled with -Os. 550 kB for nothing :-(
| 
| Some of the bigger 2.6 additions cannot be configured out.
| I wish sysfs and the different I/O schedulers could be removed.

Perhaps after 2.6.n is out and stable for a month or so someone could
look at the problem. Certainly the various io schedulers are good
candidates for being optional and/or modules. The problem is that the
parts which aren't needed aren't large, so you may not gain much.

Clearly you have to have *some* io scheduler, I'm not sure if sysfs is
optional in any meaningful way any more. I haven't tried running w/i
/proc in a few months, it didn't work when I did, but old kernels are
old news.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
