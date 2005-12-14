Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVLNI6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVLNI6o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 03:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVLNI6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 03:58:44 -0500
Received: from smtpout.mac.com ([17.250.248.73]:57067 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932071AbVLNI6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 03:58:44 -0500
In-Reply-To: <439F5B91.4010903@mvista.com>
References: <17594.192.54.193.25.1134477932.squirrel@rousalka.dyndns.org> <439F5B91.4010903@mvista.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E3BB92B7-2723-45F9-B578-C4BD07834734@mac.com>
Cc: Nicolas Mailhot <nicolas.mailhot@laposte.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
Date: Wed, 14 Dec 2005 03:58:21 -0500
To: george@mvista.com
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 13, 2005, at 18:38, George Anzinger wrote:
> I think that there is a miss understanding here.  The kernel  
> timers, at this time, do not know or care about daylight savings  
> time.  This is not really a clock set but a time zone change which  
> does not intrude on the kernels notion of time (that being, more or  
> less UTC).

One question I have right now is:  How does the kernel treat time  
slewing?  Sometimes I might want to say: "The clock has continuous  
error and measures 24hours and 2 seconds for every 24 hours of real  
time", in which case the monotonic time should be slewed -2sec/ 
24hours.  On the other hand, I might also want to say: "The clock has  
fixed error and is 2 hours ahead cause some dummy messed up the  
time", so I'm going to fix this over the next 2 weeks by slewing  
backwards 1 hour per 7 days, in which case I do _not_ want the  
monotonic time to be affected (I'm passing 2 days, not 1 day and 22  
hours).  How does the kernel handle this?  I've never seen any good  
description of the NTP and time-control APIs; if there is one out  
there (that's not 42 pages of dry standard), I would love a link.

Cheers,
Kyle Moffett

--
If you don't believe that a case based on [nothing] could potentially  
drag on in court for _years_, then you have no business playing with  
the legal system at all.
   -- Rob Landley



