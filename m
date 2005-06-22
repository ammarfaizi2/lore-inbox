Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262582AbVFVW4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262582AbVFVW4E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 18:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVFVWxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 18:53:17 -0400
Received: from opersys.com ([64.40.108.71]:7953 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262467AbVFVWvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 18:51:36 -0400
Message-ID: <42B9EE0B.80802@opersys.com>
Date: Wed, 22 Jun 2005 19:02:35 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, Philippe Gerum <rpm@xenomai.org>
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
References: <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com> <1119460803.5825.13.camel@localhost> <20050622185019.GG1296@us.ibm.com> <20050622190422.GA6572@elte.hu> <42B9C777.8040202@opersys.com> <20050622202242.GA17301@elte.hu> <42B9D208.4080305@opersys.com> <20050622224123.GA7658@elte.hu>
In-Reply-To: <20050622224123.GA7658@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> otherwise par_test_irq_handler will run with interrupts enabled, opening 
> the window for other interrupts to be injected and increasing the 
> worst-case latency! Take a look at drivers/char/lpptest.c how to do this 
> properly. Also, double-check that there is no IRQ 7 thread running on 
> the PREEMPT_RT kernel, to make sure you are measuring irq latencies.

We'll check on this also. Thanks for pointing it out.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
