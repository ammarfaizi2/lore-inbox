Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVFKWgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVFKWgw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 18:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVFKWgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 18:36:51 -0400
Received: from opersys.com ([64.40.108.71]:59398 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261839AbVFKWgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 18:36:47 -0400
Message-ID: <42AB662B.4010104@opersys.com>
Date: Sat, 11 Jun 2005 18:31:07 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
References: <42AA6A6B.5040907@opersys.com> <20050611191448.GA24152@elte.hu>
In-Reply-To: <20050611191448.GA24152@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> how were interrupt response times measured, precisely? What did the 
> target (measured) system have to do to respond to an interrupt? Did you 
> use the RTC to measure IRQ latencies?

The logger used two TSC values. One prior to shooting the interrupt to the
target, and one when receiving the response. Responding to an interrupt
meant that a driver was hooked to the target's parallel port interrupt and
simply acted by toggling an output pin on the parallel port, which in turn
was hooked onto the logger's parallel port in a similar fashion. We'll
post the code for all components (both logger and target) for everyone to
review. There's no validity in any tests if others can't analyze/criticize/
duplicate.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
