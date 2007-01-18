Return-Path: <linux-kernel-owner+w=401wt.eu-S1751917AbXARHjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbXARHjr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 02:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbXARHjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 02:39:47 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53279 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917AbXARHjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 02:39:46 -0500
Date: Thu, 18 Jan 2007 08:38:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: tglx@linutronix.de, khilman@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] futex null pointer timeout
Message-ID: <20070118073816.GA28486@elte.hu>
References: <20070118002503.418478415@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070118002503.418478415@mvista.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.3 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.0 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> This fix is mostly from Thomas ..
> 
> The problem was that a futex can be called with a zero timeout (0 
> seconds, 0 nanoseconds) and it's a valid expired timeout. However, the 
> current futex in -rt assumes a zero timeout is an infinite timeout.
> 
> Kevin Hilman found this using LTP's nptl01 test case which would soft 
> hang occasionally.
> 
> The patch reworks do_futex, and futex_wait* so a NULL pointer in the 
> timeout position is infinite, and anything else is evaluated as a real 
> timeout.

thanks, applied.

	Ingo
