Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272493AbTGZO2j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272494AbTGZO2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:28:39 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:39817
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272493AbTGZO2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:28:37 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Sun, 27 Jul 2003 00:47:54 +1000
User-Agent: KMail/1.5.2
Cc: mingo@elte.hu
References: <1059211833.576.13.camel@teapot.felipe-alfaro.com> <200307261142.43277.m.c.p@wolk-project.de>
In-Reply-To: <200307261142.43277.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307270047.54349.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jul 2003 19:46, Marc-Christian Petersen wrote:
> On Saturday 26 July 2003 11:30, Felipe Alfaro Solana wrote:
>
> Hi Felipe,
>
> > I just only wanted to publicly invite Con Kolivas to keep on working
> > with the scheduler patches he has been doing and that have required a
> > constant and fair amount of time from him. I don't know if Con patches
> > do work as good for others in this list as for me, so I also invite
> > everyone who is/has been testing them to express their feelings so we
> > all can know what's the current status of the 2.6 scheduler.
>
> For me, all the Oxint Scheduler patches won't work well. Even for O8int I
> can say the same as for 01int to 07int, the system is dog slow when doing
> "make -j2 bzImage modules". XMMS does not skip, but hey, I don't care about
> XMMS skipping at all. I want a system which is responsive under heavy load,
> where opening an new xterm does not take 5-10 seconds, or writing an email
> in my MUA looks like a child is writing on a typewriter with one finger ;)
>
> Now that I've tested 2.6.0-test-1-wli (William Lee Irwin's Tree) for over a
> week, I thought about, that the problem might _not_ be only the O(1)
> Scheduler, because -wli has changed almost nothing to the scheduler stuff,
> it's almost 2.6.0-test1 code and running that kernel, my system is _alot_
> more responsive than 2.6.0-test1 or 2.6.0-test1-mm* or all the Oxint
> scheduler fixes have ever been.
>
> Strange no?

Actually this is not strange to me. It has become obvious that the problems 
with interactivity that have evolved in 2.5 are not scheduler related. Just 
try plugging in all the old 2.4 O(1) scheduler settings into the current 
scheduler and you will see that it still performs badly. What exactly is the 
cause is a mystery but seems to be more a combination of factors with a 
careful look at the way the vm behaves being part of that.  However, as has 
been evident, evolving the interactivity estimation in the scheduler by 
whatever means is able to help, which is why I started on this project in the 
first place. 

I make no apologies for the fact my changes so far have made it feel slower at 
starting applications under load (your mileage may vary depending on hardware 
or whatever as no doubt MCP's experience seems bad) when other very obvious 
limitations abound in the performance in other areas. I have addressed each 
and every issue I could find along the way and this issue is a tweaking one, 
not an infrastructure change, unless other kernel areas are radically changed 
(as in -wli) which appears increasingly unlikely as 2.6 final approaches.

Con

