Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbVFKUEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbVFKUEv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 16:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVFKUEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 16:04:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27130 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261803AbVFKUEQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 16:04:16 -0400
Subject: Re: [PATCH] local_irq_disable removal
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.OSF.4.05.10506111851240.2917-100000@da410.phys.au.dk>
References: <Pine.OSF.4.05.10506111851240.2917-100000@da410.phys.au.dk>
Content-Type: text/plain
Date: Sat, 11 Jun 2005 13:02:59 -0700
Message-Id: <1118520182.5593.31.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> Well, isn't enough to see that the code contains more instructions and
> looks somewhat more complicated?
> 

And - another thing:

Not all instructions take the same amount of time to execute.

Think about the cli operation. This can take real time on highly
pipelined processors, when compared to a simple increment by one
operation.

So the more complex-looking code, might make things faster.

I'm going to say it one last time.

Do the analysis scientifically, and use numbers to get your answers.

This stuff is profound. 

Think it through, and when you find a real problem, then we can take a
look together, and see if it requires a bug fix. 

And consider this - 

There are robots walking around today, that use this concept in Linux
2.4, and they can help you carry a 20 foot long plank across rugged
terrain. In addition, they will stand it up against a wall for you...

So be careful when you say it can't be done in 2.6.

Sven



