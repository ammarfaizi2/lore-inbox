Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSHFRUD>; Tue, 6 Aug 2002 13:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSHFRUC>; Tue, 6 Aug 2002 13:20:02 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63220 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S314277AbSHFRUB>;
	Tue, 6 Aug 2002 13:20:01 -0400
Message-ID: <3D500607.78A11BFD@mvista.com>
Date: Tue, 06 Aug 2002 10:23:19 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Zeuner, Axel" <Axel.Zeuner@partner.commerzbank.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Thread group exit
References: <A1081E14241CD4119D2B00508BCF80410843F27D@SV021558> <1028544328.17780.18.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Mon, 2002-08-05 at 09:58, Zeuner, Axel wrote:
> > I would expect, that changes of the parent of one member of the thread group
> > do not affect the interactions between the members of the group.
> > Corrections are welcome.
> > (Please cc mails to me, I read only the archives of the
> > linux-kernel list.)
> 
> I agree with your diagnosis I'm not convinced by your change. The thread
> groups are only used by NGPT not by glibc pthreads while the problem is
> true across both.

Have the glibc folks decided NOT to move to thread groups? 
I sort of expected that they were just taking their time,
but would eventually move.

-g
> 
> Possibly the right fix is to remove the reparent to init increment of
> self_exec_id and instead explicitly check process 1 in the signal paths.
> 
> Opinions ?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
