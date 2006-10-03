Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965575AbWJCIf4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965575AbWJCIf4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 04:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965574AbWJCIf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 04:35:56 -0400
Received: from www.osadl.org ([213.239.205.134]:8395 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S965575AbWJCIfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 04:35:55 -0400
Subject: Re: [patch 00/21] high resolution timers / dynamic ticks - V2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <20061002210053.16e5d23c.akpm@osdl.org>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
	 <20061002210053.16e5d23c.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 10:38:01 +0200
Message-Id: <1159864681.1386.90.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 21:00 -0700, Andrew Morton wrote:
> These patches make my Vaio run really really slowly.  Maybe a quarter of
> the normal speed or lower.  Bisection shows that the bug is introduced by
> clockevents-drivers-for-i386.patch+clockevents-drivers-for-i386-fix.patch
> 
> With all patches applied, the slowdown happens with
> CONFIG_HIGH_RES_TIMERS=n and also with CONFIG_HIGH_RES_TIMERS=y &&
> CONFIG_NO_HZ=y.  So something got collaterally damaged.
> 
> I put various helpful stuff at http://userweb.kernel.org/~akpm/x/

> I uploaded all the patches I was using to
> http://userweb.kernel.org/~akpm/x/patches/

That's basically the same set I have here +/- the fixups

> It doesn't seem to be a cpufreq thing: cpuinfo_min_freq=800kHz,
> cpuinfo_max_freq=2GHz and cpuinfo_cur_freq goes up to 2GHz under load. 
> Wall time is increasing at one second per second.

I retest on my Vaio.

	tglx


