Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266611AbUH2Ext@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266611AbUH2Ext (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 00:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266679AbUH2Ext
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 00:53:49 -0400
Received: from gizmo01ps.bigpond.com ([144.140.71.11]:49316 "HELO
	gizmo01ps.bigpond.com") by vger.kernel.org with SMTP
	id S266611AbUH2Exr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 00:53:47 -0400
Message-ID: <41316155.80700@bigpond.net.au>
Date: Sun, 29 Aug 2004 14:53:41 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: spaminos-ker@yahoo.com
CC: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler fairness problem on 2.6 series (Attn: Nick Piggin and
 others)
References: <20040829022804.92317.qmail@web13925.mail.yahoo.com>
In-Reply-To: <20040829022804.92317.qmail@web13925.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

spaminos-ker@yahoo.com wrote:
> --- Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
>>The mode in which the scheduler was being used had all priority fiddling 
>>(except promotion) turned off so the tasks should have been just round 
>>robinning with each other.  Also, the time outs are fairly rare (every 
>>few hours according to Nicolas's e-mail) and happen with several 
>>different schedulers (with ZAPHOD (the one being used by Nicolas) and 
>>Con's staircase schedulers having less problem than the vanilla 
>>scheduler) which is why I thought it might be something outside the 
>>scheduler.  Perhaps it's something outside the kernel?
>>
> 
> 
> I can add to this that this problem occured on a variety of systems, single CPU
> Pentium IIIs and 4s, Athlon, dual PIIIs ;
> the one thing in common is that everything works fine on all those machines
> with 2.4, but breaks with 2.5 (or redhat 2.4 kernel with some backported code).

I don't suppose you know what the backported code was?  If you could 
provide a patch of the backport it might provide some clues.

> When I do the tests, the only thing I switch is the kernel and reboot.
> 
> It's true that it could be something broken outside of the scheduling code
> (like the way IRQ events are handled maybe, or the way signals are delivered).
> 
> The one difference between the artificial test (from the original post) and the
> real life test I do now, is that the real test combines disks I/O, network I/O
> (TCP/IP and UDP) and several multithreaded processes.
> Where things are kind of bad is that I am far from saturating the machine (the
> load average is less than 2), but still some processes get those annoying
> timeouts.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

