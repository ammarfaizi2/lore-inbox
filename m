Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbVJSPLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVJSPLM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbVJSPLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:11:12 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:51420 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751083AbVJSPLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:11:10 -0400
Date: Wed, 19 Oct 2005 17:11:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
Message-ID: <20051019151138.GA7739@elte.hu>
References: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510191047270.24515@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi Thomas,
> 
> I switched my custom kernel timer to use the ktimers with the prio of 
> -1 as you mentioned to me offline.  I set up the timer to be monotonic 
> and have a requirement that the returned time is always greater or 
> equal to the last time returned from do_get_ktime_mono.
> 
> Now here's the results that I got between two calls of 
> do_get_ktime_mono
> 
> 358.069795728 secs then later 355.981483177.  Should this ever happen?

should be monotone - the latest -rt kernels include a debugging check 
for the monotonicity of do_get_ktime_mono().

	Ingo
