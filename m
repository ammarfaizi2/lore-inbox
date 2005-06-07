Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVFGNOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVFGNOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 09:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVFGNOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 09:14:44 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:30166 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261855AbVFGNOc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 09:14:32 -0400
Subject: Re: TASK_NONINTERACTIVE (was: Machine Freezes while Running
	Crossover Office)
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050603105713.GA29060@elte.hu>
References: <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
	 <84144f0205052911202863ecd5@mail.gmail.com>
	 <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org>
	 <1117399764.9619.12.camel@localhost>
	 <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org>
	 <1117466611.9323.6.camel@localhost>
	 <Pine.LNX.4.58.0505301024080.10545@ppc970.osdl.org>
	 <courier.429C05C1.00005CC5@courier.cs.helsinki.fi>
	 <20050601073544.GA21384@elte.hu>
	 <courier.42A01623.00005D5C@courier.cs.helsinki.fi>
	 <20050603105713.GA29060@elte.hu>
Date: Tue, 07 Jun 2005 16:14:28 +0300
Message-Id: <1118150068.2447.7.camel@haji.ri.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Fri, 2005-06-03 at 12:57 +0200, Ingo Molnar wrote:
> could you please make it double sure and try the attached patch ontop of 
> the other patch? It adds a /proc/sys/kernel/pipe_noninteractive tunable 
> (default: off). It's quite tricky to test interactivity between kernels 
> (there's too much other state that may matter), so having a runtime 
> tunable can help significantly. Could you enable/disable it and see 
> whether it has a negative impact on interactivity? (besides fixing the 
> Wine problem too, of course)

I was able to reproduce the XMMS skip with pipe_noninteractive set to
zero so the interactivity problems mentioned in the previous mail are
not due to the pipe fix. As Ingo's patch fixes the Wine problem and
doesn't cause any interactivity regressions for me, please consider
putting it to -mm.

			Pekka

