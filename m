Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287373AbRL3KMf>; Sun, 30 Dec 2001 05:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287370AbRL3KMZ>; Sun, 30 Dec 2001 05:12:25 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:22266 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S287377AbRL3KMM>; Sun, 30 Dec 2001 05:12:12 -0500
Message-ID: <3C2EE86A.98BBCED@mvista.com>
Date: Sun, 30 Dec 2001 02:11:54 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kousalya K <kkasinat@npd.hcltech.com>
CC: rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Any idea about watchdog timer in linux
In-Reply-To: <Pine.LNX.4.33L2.0112040902260.18921-100000@dragon.pdx.osdl.net> <015d01c19111$299ab1c0$3e64a8c0@hcltech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kousalya K wrote:
> 
> Hi all,
> 
> I wanted to call a timer function to get current time within kernel space. I
> don't want any function call to do this.
> Any idea ? In AIX we have watchdog stucture and w_stop, w_start, w_init
> functions are there to stop, initiate and  start the watchdog timer.
> Anything like that is available in linux?
> 
I think you are after the add_timer()  del_timer_sync() stuff.  These
timers are in units of HZ and cause a function to be called when they
expire.  Most of them are deleted prior to expire time.
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
