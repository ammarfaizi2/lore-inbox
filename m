Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312458AbSDJF5N>; Wed, 10 Apr 2002 01:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312459AbSDJF5M>; Wed, 10 Apr 2002 01:57:12 -0400
Received: from 202-77-223-23.outblaze.com ([202.77.223.23]:20611 "EHLO
	testdcc.outblaze.com") by vger.kernel.org with ESMTP
	id <S312458AbSDJF5L>; Wed, 10 Apr 2002 01:57:11 -0400
Message-ID: <20020410055708.9474.qmail@fastermail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "mark manning" <mark.manning@fastermail.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 10 Apr 2002 00:57:08 -0500
Subject: Re: nanosleep
X-Originating-Ip: 67.241.61.228
X-Originating-Server: ws4.hk5.outblaze.com
X-DCC-Outblaze-Metrics: testdcc.outblaze.com 100; env_From=12 From=12 Message-ID=1 Received=1
	Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hrm - im confiused now - how can you do a n NANO second delay when the resolution is 10 mili seconds ?

forgive my ignorance and my persistant "stupid" questions :)

----- Original Message -----
From: "H. Peter Anvin" <hpa@zytor.com>
Date: 	9 Apr 2002 22:47:42 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: nanosleep


> Followup to:  <20020410044243.2916.qmail@fastermail.com>
> By author:    "mark manning" <mark.manning@fastermail.com>
> In newsgroup: linux.dev.kernel
> >
> > thanx - how much of a difference should i expect - i know the
> > syscall is asking for at least the required ammount but that the
> > task switcher might not give me control back for a while after the
> > requested delay but i was expecting to be a little closer to what i
> > had asked for - this isnt critical of corse but i would like to know
> > what to expect.
> > 
> 
> Read the man page:
> 
> BUGS
>        The current implementation of nanosleep is  based  on  the
>        normal  kernel  timer mechanism, which has a resolution of
>        1/HZ s (i.e, 10 ms on Linux/i386 and 1 ms on Linux/Alpha).
>        Therefore, nanosleep pauses always for at least the speci
>        fied time, however it can take up to  10  ms  longer  than
>        specified  until  the  process becomes runnable again. For
>        the same reason, the value returned in case of a delivered
>        signal  in *rem is usually rounded to the next larger mul
>        tiple of 1/HZ s.
> 
>        As some applications  require  much  more  precise  pauses
>        (e.g.,  in  order to control some time-critical hardware),
>        nanosleep is also capable of short high-precision  pauses.
>        If  the process is scheduled under a real-time policy like
>        SCHED_FIFO or SCHED_RR, then pauses of up to 2 ms will  be
>        performed as busy waits with microsecond precision.
> 
> 	-hpa
> -- 
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
> "Unix gives you enough rope to shoot yourself in the foot."
> http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 

_______________________________________________
Get your free email from http://www.fastermail.com

Powered by Outblaze
