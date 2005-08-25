Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbVHYVcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVHYVcq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 17:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbVHYVcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 17:32:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:50679 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S964777AbVHYVcq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 17:32:46 -0400
Subject: Re: [RFC] RT-patch update to remove the global pi_lock
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>,
       Sven-Thorsten Dietrich <sven@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       george anzinger <george@mvista.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <1125000563.6264.10.camel@localhost.localdomain>
References: <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
	 <1124739657.5809.6.camel@localhost.localdomain>
	 <1124739895.5809.11.camel@localhost.localdomain>
	 <1124981238.5350.6.camel@localhost.localdomain>
	 <1124982413.5350.19.camel@localhost.localdomain>
	 <20050825174732.GA23774@elte.hu>
	 <1125000563.6264.10.camel@localhost.localdomain>
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 25 Aug 2005 14:32:17 -0700
Message-Id: <1125005537.10901.1.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 16:09 -0400, Steven Rostedt wrote:

> A word of caution (aka. disclaimer). This is still new.  I still expect
> there are some cases in the code that was missed and can cause a dead
> lock or other bad side effect.  Hopefully, we can iron these all out.
> Also, I noticed that since the task takes it's own pi_lock for most of
> the code, if something locks up and a NMI goes off, the down_trylock in
> printk will also lock when it tries to take it's own pi_lock.

maybe it's time for ALL_TASKS_PI ?


Daniel

