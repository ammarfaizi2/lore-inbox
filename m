Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262284AbVBKRpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbVBKRpf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 12:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVBKRko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 12:40:44 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:27124 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262283AbVBKRgt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 12:36:49 -0500
Subject: Re: Interrupt starvation points
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050211173025.GA17387@elte.hu>
References: <1108141521.21940.44.camel@dhcp153.mvista.com>
	 <20050211173025.GA17387@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1108143402.21935.83.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Feb 2005 09:36:42 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-11 at 09:30, Ingo Molnar wrote:
> 
> i'm wondering what the best approach would be. Right now if
> DIRECT_PREEMPT is enabled [it's disabled currently] and a higher-prio
> task has been woken up we switch to it without ever enabling interrupts
> again. Re-enabling interrupts during schedule() will reduce irq
> latencies but will lengthen critical sections.


	Yeah, it's a trade off .. The longest points that I observed involved
kernel threads like desched . Things that the scheduler() regularly
wakes up anyways. I would imagine there is an upper bound on the number
of tasks the scheduler can wake up.

Daniel

