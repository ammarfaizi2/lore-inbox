Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283393AbRLDUiA>; Tue, 4 Dec 2001 15:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283428AbRLDUKI>; Tue, 4 Dec 2001 15:10:08 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:62704 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S283402AbRLDUIa>; Tue, 4 Dec 2001 15:08:30 -0500
Message-ID: <3C0D2D23.173A514B@mvista.com>
Date: Tue, 04 Dec 2001 12:08:03 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
CC: debian-alpha <debian-alpha@lists.debian.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: filling up pt_regs by  myself
In-Reply-To: <1007381730.1800.14.camel@satan.xko.dec.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To the best of my knowledge there is NOT a standard way to pass the
pt_regs to a system call.  Each arch does its own thing.  Makes it REAL
hard to write a system call that needs them.  I hope we can define a
standard interface.

George

"Aneesh Kumar K.V" wrote:
> 
> Hi,
> 
>  Is there any functions that i can use to setup pt_regs structure
> myself.
> 
> For example how can I take a following  i386 system call  to alpha
> 
>  sys_mycall( struct pt_regs regs)
> {
>         my_function( &regs);
> 
> }
> 
> I tried to do it same way . But then the value of members of  regs
> structure  that i am  getting are corrupted. Later looking into the
> source i found that for most of  alpha  system call is defined something
> like
> 
>  sys_mycall( arg1, arg2, arg3.....)
> 
> So i replaced the above function definition with
> 
>  sys_mycall( argument1, argument 2 argument ) here consider  it takes
> only three arguments ...
> 
> But now how i will pass the regs structure to my_function . Is there any
> already existing function that help me to do that something like
> save_regs(&regs) ? Or do i need to hand code all the saving by itself.
> Can I use SAVE_ALL #define defined in entry.S .
> 
> Thanks in advance .
> 
>  -aneesh
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
