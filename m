Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWJBNk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWJBNk7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 09:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWJBNk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 09:40:59 -0400
Received: from www.osadl.org ([213.239.205.134]:11709 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932321AbWJBNk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 09:40:58 -0400
Subject: Re: [patch 00/21] high resolution timers / dynamic ticks - V2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <200610021302.k92D23W1003320@turing-police.cc.vt.edu>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
	 <200610021302.k92D23W1003320@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 15:43:02 +0200
Message-Id: <1159796582.1386.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 09:02 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 01 Oct 2006 22:59:01 -0000, Thomas Gleixner said:
> > the following patch series is an update in response to your review.
> 
> First runtime results - no lockups or other severe badness in a half-hour or so
> of running.
> 
> -mm2-hrt-dynticks5 shows severe clock drift issues if you run 'cpuspeed'.
> 
> Using speedstep-ich as a kernel built-in, and cpuspeed is invoked as:
> 
> cpuspeed -d -n -i 10 -p 10 50 -a /proc/acpi/ac_adapter/*/state
> 
> If cpuspeed drops the CPU speed from the default 1.6Ghz down to 1.2Ghz (the
> only 2 speeds available on this core), the system clock proceeds to lose
> about 15 seconds a minute.  I haven't dug further into why yet. (If the system
> is busy so cpuspeed keeps the processor at 1.6Ghz, the clock doesn't drift
> as much - so it looks like a "when speed is 1.2Ghz" issue...)

Can you please send me the bootlog and further dmesg output (especially
when related to timers / cpufreq).

> I'm also seeing gkrellm reporting about 25% CPU use when "near-idle" (X is up
> but not much is going on) when that's usually down around 5-6%.  I need to
> collect some oprofile numbers and investigate that as well.

I look into the accounting fixups again.

	tglx


		

