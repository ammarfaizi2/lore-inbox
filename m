Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbULNRmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbULNRmA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 12:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbULNRkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 12:40:18 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:32983 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261572AbULNRja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:39:30 -0500
Date: Tue, 14 Dec 2004 18:38:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Martin =?utf-8?Q?MOKREJ=C5=A0?= <mmokrejs@ribosome.natur.cuni.cz>
Cc: tglx@linutronix.de, Andrew Morton <akpm@osdl.org>, piggin@cyberone.com.au,
       chris@tebibyte.org, marcelo.tosatti@cyclades.com, andrea@novell.com,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] fix spurious OOM kills
Message-ID: <20041214173858.GJ16322@dualathlon.random>
References: <419F2AB4.30401@ribosome.natur.cuni.cz> <1100957349.2635.213.camel@thomas> <419FB4CD.7090601@ribosome.natur.cuni.cz> <1101037999.23692.5.camel@thomas> <41A08765.7030402@ribosome.natur.cuni.cz> <1101045469.23692.16.camel@thomas> <1101120922.19380.17.camel@tglx.tec.linutronix.de> <41A2E98E.7090109@ribosome.natur.cuni.cz> <1101205649.3888.6.camel@tglx.tec.linutronix.de> <41BF0F0D.4000408@ribosome.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41BF0F0D.4000408@ribosome.natur.cuni.cz>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 05:04:29PM +0100, Martin MOKREJŠ wrote:
> I see the machine a lot less responsive when it starts swapping
> compared to 2.6.10-rc2-mm3. For example, just moving mouse between
> windows takes some 10-12 seconds to fvwm2 to re-focus to another xterm
> window.

I don't know exactly what's the issue here, but the oom fixes we
developed cannot change anything until you see the first printk in the
logs (the printk tells the admin the machine reached oom).

So slowdowns during paging can be discussed separately from the oom
killer issues.
