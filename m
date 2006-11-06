Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753568AbWKFU7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbWKFU7P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753612AbWKFU7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:59:15 -0500
Received: from gate.crashing.org ([63.228.1.57]:35764 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1753568AbWKFU7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:59:13 -0500
Subject: Re: PATCH? hrtimer_wakeup: fix a theoretical race wrt
	rt_mutex_slowlock()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0611060732020.14553@gandalf.stny.rr.com>
References: <20061105193457.GA3082@oleg>
	 <Pine.LNX.4.64.0611051423150.25218@g5.osdl.org>
	 <1162803471.28571.303.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0611060732020.14553@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 07:53:53 +1100
Message-Id: <1162846433.28571.341.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 07:35 -0500, Steven Rostedt wrote:

> It is relevant.  In powerpc, can one write happen before another write?
> 
> 
>   x = 1;
>   barrier();  (only compiler barrier)
>   b = 2;
> 
> 
> And have CPU 2 see b=2 before seeing x=1?

Yes. Definitely.

> If so, then I guess this is indeed a bug on powerpc.

Ben.


