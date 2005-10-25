Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbVJYThc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVJYThc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 15:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbVJYThb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 15:37:31 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:32998
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932323AbVJYTha
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 15:37:30 -0400
Subject: Re: 2.6.14-rc5-rt6  -- False NMI lockup detects
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1130268292.21118.22.camel@localhost.localdomain>
References: <1130250219.21118.11.camel@localhost.localdomain>
	 <20051025142848.GA7642@elte.hu>
	 <1130268292.21118.22.camel@localhost.localdomain>
Content-Type: text/plain
Organization: linutronix
Date: Tue, 25 Oct 2005 21:40:19 +0200
Message-Id: <1130269219.8167.41.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-25 at 15:24 -0400, Steven Rostedt wrote:

> Isn't the jiffy tick implemented with the PIT when possible?

Yes, PIT is the tick event source.

>  So the apic is only used when a timer is needed.  

And it might be used for profiling, which is also tick bound in the hrt
case at the moment.

> Also note that this "lockup"
> happens on boot up while things are being initialized, so not many
> things may be using the timer.

Can you send me a log of the boot messages please ?

	tglx


