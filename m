Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132691AbRC2ISu>; Thu, 29 Mar 2001 03:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132690AbRC2ISd>; Thu, 29 Mar 2001 03:18:33 -0500
Received: from colorfullife.com ([216.156.138.34]:36624 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132691AbRC2ISU>;
	Thu, 29 Mar 2001 03:18:20 -0500
Message-ID: <000401c0b828$bbdf7380$5517fea9@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Pavel Machek" <pavel@suse.cz>
Cc: <geirt@powertech.no>, <linux-kernel@vger.kernel.org>
In-Reply-To: <000401c0b319517fea9@local> <20010325231013.A34@(none)>
Subject: Re: Serial port latency
Date: Thu, 29 Mar 2001 09:58:31 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Pavel Machek" <pavel@suse.cz>
> > Is the computer otherwise idle?
> > I've seen one unexplainable report with atm problems that
disappeared
> > (!) if a kernel compile was running.
>
> I've seen similar bugs. If you hook something on schedule_tq and
forget
> to set current->need_resched, this is exactly what you get.
>
I'm running with a patch that printk's if cpu_idle() is called while a
softirq is pending.
If I access the floppy on my K6/200 every track triggers the check, and
sometimes the console blanking code triggers it.

What about creating a special cpu_is_idle() function that the idle
functions must call before sleeping?

--
    Manfred

