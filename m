Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932947AbWJIPjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932947AbWJIPjx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932949AbWJIPjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:39:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37045 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932948AbWJIPjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:39:52 -0400
Subject: RE: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot
	handle IRQ -1"
From: Arjan van de Ven <arjan@infradead.org>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@osdl.org>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>, Roland Dreier <rdreier@cisco.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0D17@USRV-EXCH4.na.uis.unisys.com>
References: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0D17@USRV-EXCH4.na.uis.unisys.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 09 Oct 2006 17:39:20 +0200
Message-Id: <1160408360.3000.227.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-09 at 10:28 -0500, Protasevich, Natalie wrote:

> I'd like also to question current policies of user space irqbalanced. It
> seems to just go round-robin without much heuristics involved.

only for the timer interrupt and only because "people" didn't want to
see it bound to a specific CPU. For all others there's quite some
heuristics actually

>  We are
> seeing loss of timer interrupts on our systems - and the more processors
> the more noticeable it is, but it starts even on 8x partitions; on 48x
> system I see about 50% loss, on both ia32 and x86_64 (haven't checked on
> ia64 yet). With say 16 threads it is unsettling to see 70% overall idle
> time, and still only 40-50% of interrupts go through. System's time is
> not affected, so the problem is on the back burner for now :) It's not
> clear yet whether this is software or hardware fault, 

I'd call it a hardware fault. But them I'm biased.


