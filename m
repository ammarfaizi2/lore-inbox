Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbTHVAJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 20:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbTHVAJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 20:09:19 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:57031
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262939AbTHVAJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 20:09:18 -0400
Message-ID: <1061510950.3f455f26b14fa@kolivas.org>
Date: Fri, 22 Aug 2003 10:09:10 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Wes Janzen <superchkn@sbcglobal.net>
Cc: Mike Galbraith <efault@gmx.de>, Voluspa <lista1@comhem.se>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O17int
References: <5.2.1.1.2.20030821090657.00b45af8@pop.gmx.net> <200308210723.42789.kernel@kolivas.org> <5.2.1.1.2.20030821090657.00b45af8@pop.gmx.net> <5.2.1.1.2.20030821154224.01990b48@pop.gmx.net> <3F454532.4030200@sbcglobal.net>
In-Reply-To: <3F454532.4030200@sbcglobal.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wes Janzen <superchkn@sbcglobal.net>:

> I wish I could get mm3 running so I could evaluate those interactivity 
> statements.  I can't imagine it being worse than what I'm experiencing now:

Umm. You didn't mention which kernel/patch? I seem to recall you were using 
Osomething but which?

> That would be compiling the kernel, bunzipping a file, and some cron 
> mandb thing that was running gzip in the background niced.  Plus X and 
> Mozilla, which probably starts the problem.  At the end there, you see 
> things calm down.  That's also the way it starts out, then something 
> sets off the "priority inversion" and the machine becomes completely 
> worthless.  Even the task that are running aren't really accomplishing 
> anything.  So the load goes from around 4/5 into the teens and the 
> context switching makes a corresponding jump.  And then both 
> interactivity AND throughput fall through the floor.
> 
> I can't imagine any interactivity regressions that are worse than this 
> behavior...

If this is Osomething, can you tell me when it started doing this and what 
vanilla does.

> And this happens with just X and Mozilla running.  It happens less often 
> without X running, but still happens.  Even if I'm at a VT, it could 
> take 5-6 seconds for my text to appear after I type.  This happens all 
> the time, about once every few minutes and correlates with a 
> simultaneous increase in context switches and load.

Ditto

> Can you set a cutoff point where if the process uses less that X percent 
> of the max timeslice, it is penalized?  I don't know if it's possible  
> to do a loop of empty spins at some point and time it to find out what 
> the cut-off point should be...otherwise I imagine it would need to be 
> tuned for every processor speed.  Could you use the bogomips to gauge 
> the speed of the machine and use that to determine the min timeslice?  
>  From what I understand above, that would perhaps be more selective than 
> just penalizing every process and have a positive affect on 
> everything...of course I'm open to the possibility that I have it all 
> wrong ;-)

A thought, but unfortunately some arbitrary limit would just be hit by 
everything randomly rather than with any meaningful frequency. The timeslice  
interactive things use up is extremely variable depending on circumstances. 

Con
