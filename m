Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161948AbWKJSgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161948AbWKJSgB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 13:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161950AbWKJSgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 13:36:01 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:32725 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161948AbWKJSgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 13:36:00 -0500
Date: Fri, 10 Nov 2006 19:35:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, John Stultz <johnstul@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Helmut Duregger <Helmut.Duregger@student.uibk.ac.at>
Subject: Re: [patch] ktime: Fix signed / unsigned mismatch in ktime_to_ns
Message-ID: <20061110183525.GA2001@elte.hu>
References: <20061110182418.134188000@cruncher.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061110182418.134188000@cruncher.tec.linutronix.de>
User-Agent: Mutt/1.4.2.2i
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


* Thomas Gleixner <tglx@linutronix.de> wrote:

> The 32 bit implementation of ktime_to_ns returns unsigned value, while the
> 64 bit version correctly returns an signed value. There is no current user
> affected by this, but it has to be fixed, as ktime values can be negative.
> 
> Pointed-out-by: Helmut Duregger <Helmut.Duregger@student.uibk.ac.at>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
