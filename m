Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWJEIbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWJEIbp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWJEIbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:31:44 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:6073 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751336AbWJEIbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:31:43 -0400
Date: Thu, 5 Oct 2006 10:23:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [patch 00/22] high resolution timers / dynamic ticks - V3
Message-ID: <20061005082348.GA30940@elte.hu>
References: <20061004172217.092570000@cruncher.tec.linutronix.de> <20061005011608.b69e3461.akpm@osdl.org> <20061005011909.3e1a9fec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005011909.3e1a9fec.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> It just did something:
> 
> [   12.112000] kjournald starting.  Commit interval 5 seconds
> [   12.160000] EXT3-fs: recovery complete.
> [   12.164000] EXT3-fs: mounted filesystem with ordered data mode.
> [   12.980000] audit(1160010604.980:2): enforcing=1 old_enforcing=0 auid=4294967295
> [   18.808000] security:  3 users, 6 roles, 1417 types, 151 bools, 1 sens, 256 cats
> [   18.812000] security:  57 classes, 41080 rules
> [   18.816000] SELinux:  Completing initialization.
> [   18.816000] SELinux:  Setting up existing superblocks.
> [   18.824000] SELinux: initialized (dev sda6, type ext3), uses xattr
> [   18.860000] SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
> 
> 
> Those "six seconds" took at least three minutes.  With luck I'll have 
> a login prompt tomorrow morning.

as per your previous stats, the ratio between expected and real local 
APIC timer IRQs is 3:250. So if your normal bootup takes 1 minute, you 
should be up and running in an hour or so :-/

you should be seeing similar symptoms when booting the x86 SMP kernel on 
that box. Or is the anomalously slow LOC count only an artifact of the 
hres tree?

	Ingo
