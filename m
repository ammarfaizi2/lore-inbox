Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276050AbRJCIgo>; Wed, 3 Oct 2001 04:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276072AbRJCIgf>; Wed, 3 Oct 2001 04:36:35 -0400
Received: from chiara.elte.hu ([157.181.150.200]:12807 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276050AbRJCIgX>;
	Wed, 3 Oct 2001 04:36:23 -0400
Date: Wed, 3 Oct 2001 10:34:23 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: jamal <hadi@cyberus.ca>
Cc: <linux-kernel@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Simon Kirby <sim@netnation.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110021739160.2323-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.33.0110031025530.1694-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2 Oct 2001, jamal wrote:

> [...] please have the courtesy of at least posting results/numbers of
> how this improved things and under what workloads and conditions.
> [...]

500 MHz PIII UP server, 433 MHz client over a single 100 mbit ethernet
using Simon Kirby's udpspam tool to overload the server. Result: 2.4.10
locks up before the patch. 2.4.10 with the first generation irqrate patch
applied protects against the lockup (if max_rate is correct), but results
in dropped packets. The auto-tuning+polling patch results in a working
system and working network, no lockup and no dropped packets. Why this
happened and how it happened has been discussed extensively.

(the effect of polling-driven networking is just an extra and unintended
bonus side-effect.)

	Ingo

