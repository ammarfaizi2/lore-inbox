Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVFAV4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVFAV4i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVFAV42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:56:28 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:1295 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261330AbVFAVyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:54:23 -0400
Date: Wed, 1 Jun 2005 14:59:13 -0700
To: Bill Huey <bhuey@lnxw.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601215913.GB28196@nietzsche.lynx.com>
References: <20050601192224.GV5413@g5.random> <Pine.OSF.4.05.10506012129460.1707-100000@da410.phys.au.dk> <20050601195905.GX5413@g5.random> <20050601201754.GA27795@nietzsche.lynx.com> <20050601203212.GZ5413@g5.random> <20050601204612.GA27934@nietzsche.lynx.com> <20050601210716.GB5413@g5.random> <20050601214257.GA28196@nietzsche.lynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601214257.GA28196@nietzsche.lynx.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 02:42:57PM -0700, Bill Huey wrote:
> On Wed, Jun 01, 2005 at 11:07:16PM +0200, Andrea Arcangeli wrote:
> > Ingo just said that making local_irq_disable a "soft-cli" is planned.

I forgot. You basically turn it into one single big system wide mutex and
and deal pathological cases as it turns up. Doing this is optional and
if you can get away with letting the cli/sti function stay in place, then
it's less work for us to handle.

> preempt RT will be deterministic as this patch gets pounded more and
> remaining latency paths are reworked. It hasn't been hard so far and the
> results have been near perfect since the core kernel is, for the most
> part, fully preemptive.

There are many ways to handle various issues at runtime. We have the
instrumentation in place to detect it and conversion is easy since it's
been at the lower layers.

bill

