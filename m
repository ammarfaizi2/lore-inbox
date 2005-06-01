Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbVFAR43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbVFAR43 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 13:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVFARyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 13:54:41 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:30414
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261486AbVFARwy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 13:52:54 -0400
Subject: Re: RT patch acceptance
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrea Arcangeli <andrea@suse.de>
Cc: Karim Yaghmour <karim@opersys.com>, Esben Nielsen <simlo@phys.au.dk>,
       Ingo Molnar <mingo@elte.hu>, Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050601153803.GO5413@g5.random>
References: <20050601143202.GI5413@g5.random>
	 <Pine.OSF.4.05.10506011640360.1707-100000@da410.phys.au.dk>
	 <20050601150527.GL5413@g5.random> <429DD533.6080407@opersys.com>
	 <20050601153803.GO5413@g5.random>
Content-Type: text/plain
Organization: linutronix
Date: Wed, 01 Jun 2005 19:53:11 +0200
Message-Id: <1117648391.20785.7.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-01 at 17:38 +0200, Andrea Arcangeli wrote:
> On Wed, Jun 01, 2005 at 11:33:07AM -0400, Karim Yaghmour wrote:
> > in a wider context of all the other statements within that claim, the main
> > part being what I quoted earlier.
> 
> Ok great, I trust your patent knowledge given your background ;).
> 
> It's very reassuring that I was wrong and preempt-rt is not covered by
> the patent. Until now I really understood that redefining an hard irq
> disable to a soft irq disable was forbidden at large.

Thank god thats not the case. We did a patent research on this last year
and the result was that you can replace the cli/sti by a software flag
in the OS itself without violating the patent.

The combination of replacing it in the host OS and running said host OS
as an idle task of the underlying RTOS would violate the patent.

So if PREEMPT-RT would use a soft cli/sti emulation, no problem should
arise.

tglx


