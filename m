Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132094AbQKJWdz>; Fri, 10 Nov 2000 17:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132079AbQKJWdp>; Fri, 10 Nov 2000 17:33:45 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:39684 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S132059AbQKJWd0>; Fri, 10 Nov 2000 17:33:26 -0500
Message-ID: <3A0C76C0.CAC8B9D4@timpanogas.org>
Date: Fri, 10 Nov 2000 15:29:20 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: sendmail fails to deliver mail with attachments in /var/spool/mqueue
In-Reply-To: <3A0C3F30.F5EB076E@timpanogas.org> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <26054.973893835@euclid.cs.niu.edu> <8uhs7c$2hr$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"H. Peter Anvin" wrote:
> 
> Followup to:  <26054.973893835@euclid.cs.niu.edu>
> By author:    Neil W Rickert <sendmail+rickert@sendmail.org>
> In newsgroup: linux.dev.kernel
> >
> > "Jeff V. Merkey" <jmerkey@timpanogas.org> wrote:
> >
> > >The problem of dropping connections on 2.4 was related to the O RefuseLA
> > >settings.  The defaults  in the RedHat, Suse, and OpenLinux RPMs are
> > >clearly set too low for modern Linux kernels.  You may want them cranked
> > >up to 100 or something if you want sendmail to always work.
> >
> > If a modern Linux kernel requires high load average defaults, I will
> > stop using Linux.
> >
> 
> Numerically high load averages aren't inherently a bad thing.  There
> isn't anything bad about a system with a loadavg of 20 if it does what
> it should in the time you'd expect.  However, if your daemons start
> blocking because they assume this number means badness, than that is
> the problem, not the loadavg in itself.

Well, here's what the sendmail folks **REAL** opinion of Linux is and
the way load average is calculated (senders name removed)

[... sendmail person ...]

 Ok, here's my blunt answer: Linux sucks.  Why does it have a load
> average of 10 if there are two processes running? Let's check the
> man page:
> 
>             and the three load averages for the system.  The load
>             averages  are  the average number of process ready to
>             run during the last 1, 5 and 15 minutes.   This  line
>             is  just  like  the  output of uptime(1).
> 
> So: Linux load average on these systems is broken.

So I guess we know where we stand with the sendmail folks.  If the US
post office delivered mail at Christmas time using a size based priority
the way sendmail does, folks would all get their Christmas presents
about mid-February unless O NumberOfPostalWorkers=20 was set high
enough.  

Jeff


> 
>         -hpa
> 
> --
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!
> "Unix gives you enough rope to shoot yourself in the foot."
> http://www.zytor.com/~hpa/puzzle.txt
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
