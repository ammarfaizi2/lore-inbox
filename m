Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317658AbSFRW4b>; Tue, 18 Jun 2002 18:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317660AbSFRW4a>; Tue, 18 Jun 2002 18:56:30 -0400
Received: from pc132.utati.net ([216.143.22.132]:52865 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S317658AbSFRW43>; Tue, 18 Jun 2002 18:56:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: David Schwartz <davids@webmaster.com>, <mgix@mgix.com>,
       <root@chaos.analogic.com>, Chris Friesen <cfriesen@nortelnetworks.com>
Subject: Re: Question about sched_yield()
Date: Tue, 18 Jun 2002 12:58:09 -0400
X-Mailer: KMail [version 1.3.1]
Cc: <rml@tech9.net>, <linux-kernel@vger.kernel.org>
References: <20020618191114.AAA27826@shell.webmaster.com@whenever>
In-Reply-To: <20020618191114.AAA27826@shell.webmaster.com@whenever>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020618223028.DC8CA7D9@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 June 2002 03:11 pm, David Schwartz wrote:

> 	I'm sorry, but you are being entirely unreasonable. The kernel has no way
> to know which processes are doing something useful and which ones are just
> wasting CPU.

So the fact one of them is calling sched_yield (repeatedly) and the other one 
isn't doesn't count as just a little BIT of a hint?

> 	What sched_yield is good for is if you encounter a situation where you
> need/want some resource and another thread/process has it. You call
> sched_yield once, and maybe when you run again, the other thread/process
> will have released it.

Not if it was a higher-priority task that has already exhausted its time 
slice...

> You can also use it as the spin function in
> spinlocks.

In user space?

Rob
