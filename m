Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVILJO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVILJO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 05:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVILJO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 05:14:26 -0400
Received: from mail.gmx.de ([213.165.64.20]:39583 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751150AbVILJOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 05:14:25 -0400
X-Authenticated: #4399952
Date: Mon, 12 Sep 2005 11:14:24 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: "linux-kernel @ vger. kernel. org" <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: possible bug in RP kernel
Message-ID: <20050912111424.1ae2f93e@mango.fruits.de>
In-Reply-To: <20050912090115.GA5731@elte.hu>
References: <20050912105010.701a822f@mango.fruits.de>
	<20050912090115.GA5731@elte.hu>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sep 2005 11:01:15 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> > 23 seconds gap between two wakeups
> > 
> > Maybe my understanding of how sched fifo works is wrong, but i assumed 
> > a higher prio thread shold get woken up from a sleep by the scheduler 
> > which gets run by the timer interrupt [which is still non 
> > preemptible].
> 
> depending on what type of timeout you are using you'll also need to chrt 
> the softirq-timer kernel thread(s) to prio 99. Otherwise the timer fn 
> will have no chance to be executed. There's work going on by Thomas to 
> make such things automatic, by prioritizing timers. If you have HRT 
> enabled in the .config then it should mostly be automatic already 
> though.

Ah,

thanks for the info. So it is a user (me) bug in the end :) This has
helped. Actually the code i had attached had another bug in it. But that
wasn't the responsible one.

Thanks again, and sorry for the multiple mails,
Florian Schmidt

-- 
Palimm Palimm!
http://tapas.affenbande.org
