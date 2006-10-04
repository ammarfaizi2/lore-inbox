Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWJDGyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWJDGyS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 02:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWJDGyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 02:54:18 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:30136 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932184AbWJDGyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 02:54:17 -0400
Date: Wed, 4 Oct 2006 08:46:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch] clockevents: drivers for i386, fix #2
Message-ID: <20061004064620.GA22364@elte.hu>
References: <20061001225720.115967000@cruncher.tec.linutronix.de> <20061002210053.16e5d23c.akpm@osdl.org> <20061003084729.GA24961@elte.hu> <20061003103503.GA6350@elte.hu> <20061003203620.d85df9c6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003203620.d85df9c6.akpm@osdl.org>
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

> Disabling LOCAL_APIC does fix it.

thanks, that narrows it down quite a bit. (We've double-checked the 
lapic path and it seemed all our changes are NOP, but obviously it isnt 
and we'll check it all again.)

(if you have that kernel still booted by any chance then do you see the 
'LOC' IRQ count in /proc/interrupts or any other count in /proc/stats 
increasing at an alarming rate? That would narrow it down to lapic timer 
misprogramming.)

	Ingo
