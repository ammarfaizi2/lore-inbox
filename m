Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVAKSTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVAKSTx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 13:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVAKRsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 12:48:36 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:46804 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261208AbVAKRhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 12:37:33 -0500
Subject: Re: User space out of memory approach
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: tglx@linutronix.de
Cc: Edjard Souza Mota <edjard@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mauricio Lin <mauriciolin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <1105433093.17853.78.camel@tglx.tec.linutronix.de>
References: <3f250c71050110134337c08ef0@mail.gmail.com>
	 <20050110192012.GA18531@logos.cnet>
	 <4d6522b9050110144017d0c075@mail.gmail.com>
	 <20050110200514.GA18796@logos.cnet>
	 <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	 <4d6522b90501101803523eea79@mail.gmail.com>
	 <1105433093.17853.78.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105461106.16168.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 11 Jan 2005 16:32:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-11 at 08:44, Thomas Gleixner wrote:
> I consider the invocation of out_of_memory in the first place. This is
> the real root of the problems. The ranking is a different playground.
> Your solution does not solve
> - invocation madness
> - reentrancy protection
> - the ugly mess of timers, counters... in out_of_memory, which aren't
> neccecary at all
> 
> This must be solved first in a proper way, before we talk about ranking.

echo "2" >/proc/sys/vm/overcommit_memory

End of problem (except for extreme cases) and with current 2.6.10-bk
(and -ac because I pulled the patch back into -ac) also for most extreme
cases as Andries pre-reserves the stack address spaces.

