Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263919AbTH1GKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 02:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbTH1GKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 02:10:20 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:11403 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S263919AbTH1GKN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 02:10:13 -0400
Date: Thu, 28 Aug 2003 09:10:00 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-ID: <20030828061000.GG150921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0308272020461.23236@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0308272020461.23236@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 08:22:07PM -0300, you [Marcelo Tosatti] wrote:
> 
> Ville,
> 
> Which kernel doesnt hang on your box? 2.4 something ? 

2.4.20pre7 ran for over 9 months before it suddenly begun locking up (I
_suppose_ it could just mean the bug/problem is hard to trigger.) Nothing
had been changed: the box had been up for that nine month period, and the
same oracle dump cron job had been running each night.

Earlier 2.4's had too many problems with aic7xxx (crashes and so on), so I
can't comment on them.

After 2.4.20pre7, I tried 2.4.21-jam1 (based on -aa patchset) and
2.4.22-pre8. I also tried compiling 2.4.21-jam1 with gcc-3.2.1 instead of
2.96. All of those locked up eventually, sometimes within a day from
reboot, some times it takes weeks. At one point, 2.4.21-jam1 seemed to
reliably lock up when compiling kernel, but it no longer happens no matter
how hard I try. Usually the lock up happens during nightly oracle backup
dump.

> 2.2?

2.2.22 and 2.2.22-secure1 never locked up, but I didn't run them for more
than a couple of months.

I realize I should try to change all pieces of hardware one at the time and
try various different kernels, but it all seem tedious and shooting in the
dark: the lock up can take weeks to trigger. I would love to get some kind
of lead or theory on what causes the problem before resorting to brute force
search.

I think I'll try 2.4.22-final + a kernel debugger next. Or is there a better
way of getting information on hard lock ups than kdb? (Tried nmi watchdog
and sysrq already).


-- v --

v@iki.fi
