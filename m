Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281978AbRKZR7B>; Mon, 26 Nov 2001 12:59:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281969AbRKZR6l>; Mon, 26 Nov 2001 12:58:41 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:57583 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S281972AbRKZR6d>; Mon, 26 Nov 2001 12:58:33 -0500
Message-ID: <3C0282AF.7C96B32A@mvista.com>
Date: Mon, 26 Nov 2001 09:58:07 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: sekhar raja <manamraja@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Doubt in Kernel Timers
In-Reply-To: <20011126125517.27715.qmail@web14504.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sekhar raja wrote:
> 
> Hi Folks
> 
> I have a doubt in Kernel Timers, Can we delete the
> Timer with out adding it to the timer List.
> 
> What do i mean is with out Doing add_timer() can we
> use del_timer().
> 
> If we can not do that, how do we check whether the
> particular timer is running or not.
> 
> Your help will be greatly Appreciated, Please CC me
> the Answer as i am not Subscribe to the mailing list.
> 
> Thanks in Advance
> -Rajasekhar
> 
A quick glance at the source would assure you that YES you can
del_timer() at any time.  Looking at this code you would discover that
the list linkage being NULL indicates that the timer is not active.

Read the SOURCE.
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
