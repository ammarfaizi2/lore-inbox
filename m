Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030538AbWHJCV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030538AbWHJCV7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 22:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030543AbWHJCV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 22:21:59 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:62367
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1030538AbWHJCV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 22:21:58 -0400
Date: Wed, 9 Aug 2006 19:18:35 -0700
To: Esben Nielsen <nielsen.esben@gogglemail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Robert Crocombe <rcrocomb@gmail.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhltc@us.ibm.com>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [Patch] restore the RCU callback to defer put_task_struct() Re: Problems with 2.6.17-rt8
Message-ID: <20060810021835.GB12769@gnuppy.monkey.org>
References: <e6babb600608012231r74470b77x6e7eaeab222ee160@mail.gmail.com> <e6babb600608012237g60d9dfd7ga11b97512240fb7b@mail.gmail.com> <1154541079.25723.8.camel@localhost.localdomain> <e6babb600608030448y7bb0cd34i74f5f632e4caf1b1@mail.gmail.com> <1154615261.32264.6.camel@localhost.localdomain> <20060808025615.GA20364@gnuppy.monkey.org> <20060808030524.GA20530@gnuppy.monkey.org> <Pine.LNX.4.64.0608090050500.23474@frodo.shire>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608090050500.23474@frodo.shire>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 12:05:57AM +0200, Esben Nielsen wrote:
> I had a long discussion with Paul McKenney about this. I opposed the patch 
> from a latency point of view: Suddenly a high-priority RT task could be 
> made into releasing a task_struct. It would be better for latencies to 
> defer it to a low priority task.
> 
> The conclusion we ended up with was that it is not a job for the RCU 
> system, but it ought to be deferred to some other low priority task to 
> free the task_struct.

I agree. It's just hack to get it not to crash at this time. It really
should be done in another facility or utilizing another threading context.

bill

