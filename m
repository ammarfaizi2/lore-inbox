Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262587AbVAKIiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbVAKIiZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 03:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbVAKIiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 03:38:25 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:21053
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262587AbVAKIiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 03:38:22 -0500
Date: Tue, 11 Jan 2005 09:38:37 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Edjard Souza Mota <edjard@gmail.com>,
       Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: User space out of memory approach
Message-ID: <20050111083837.GE26799@dualathlon.random>
References: <3f250c71050110134337c08ef0@mail.gmail.com> <20050110192012.GA18531@logos.cnet> <4d6522b9050110144017d0c075@mail.gmail.com> <20050110200514.GA18796@logos.cnet> <1105403747.17853.48.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105403747.17853.48.camel@tglx.tec.linutronix.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 01:35:47AM +0100, Thomas Gleixner wrote:
> confirmed fix for this available. It was posted more than once.

I posted 6 patches (1/4,2/4,3/4,4/4,5/4,6/4), they should be all
applied to mainline, they're self contained. They add the userspace
ratings too.

Those patches fixes a longstanding PF_MEMDIE race too and they optimize
used_math as well.

I'm running with all 6 patches applied with an uptime of 6 days on SMP
and no problems at all. They're all 6 patches applied to the kotd too
(plus the other bits posted on l-k as well for the write throttling,
just one bit is still missing but I'll add it soon):

	ftp://ftp.suse.com/pub/projects/kernel/kotd/i386/HEAD


