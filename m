Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbTGCT6m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 15:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265337AbTGCT6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 15:58:42 -0400
Received: from 200-204-171-188.insite.com.br ([200.204.171.188]:45321 "HELO
	proxy.inteliweb.com.br") by vger.kernel.org with SMTP
	id S265335AbTGCT6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 15:58:39 -0400
Message-ID: <01f101c3419f$e6d30360$3300a8c0@Slepetys>
From: "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>
To: "Jim Gifford" <jim@jg555.com>, <linux-kernel@vger.kernel.org>
References: <00d901c340a8$810556c0$3300a8c0@Slepetys> <1083830000.1057158848@aslan.scsiguy.com> <01b101c340dc$ede386c0$3300a8c0@Slepetys> <016901c34191$14c4a1c0$3300a8c0@Slepetys> <13e101c3419d$f62f9410$3400a8c0@W2RZ8L4S02>
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble
Date: Thu, 3 Jul 2003 17:15:51 -0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,
It's exacly the same problem, after about 12-24 hour everything locks up,
but I can still ping (sometimes).

But the syslog stops, and I only reboot by hardware, because the CTL+ALT+DEL
doesn't works, and the terminal either.

It's a SMP (dual pentium III) too, but after some tests with single CPU and
NOAPIC parameter to the kernel, the trouble continues.

I have no clue for what kind of tests I can do to generate the trouble, or
for what logs, or files to look for.

[]s
Slepetys



> Roberto,
>     How does this problem manifest itself. I think it's the same problem
> that I'm having. Let me know what you think. I'm using the megaraid driver
> and aic7xxx driver. After about a 12-20 hour period, everything locks up,
> but there is not error message. The kernel sysreq information does work
and
> I'm able to reboot.
>
> top - 12:59:05 up  3:02,  2 users,  load average: 4.17, 4.35, 4.38
> Tasks: 122 total,   5 running, 117 sleeping,   0 stopped,   0 zombie
>  Cpu0 :  25.0% user,  50.0% system,  25.0% nice,   0.0% idle
>  Cpu1 :  62.5% user,  31.2% system,   0.0% nice,   6.2% idle
> Mem:   1033896k total,   823636k used,   210260k free,   160412k buffers
> Swap:  1060280k total,        0k used,  1060280k free,   352848k cached
>
>
> ----- Original Message ----- 
> From: "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>
> To: "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>; "Justin T.
> Gibbs" <gibbs@scsiguy.com>; <linux-kernel@vger.kernel.org>
> Sent: Thursday, July 03, 2003 11:29 AM
> Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble
>
>
> > Ops....
> > The linux box halted again, after 12 hours operating normaly.
> >
> > The more strange is that there isn't any message in the
/var/log/message,
> > the system simples stop to respond, and some strange behavior is that
the
> > TOP comand gaves me :
> >
> > 15:10:15     up   33 min, 1 user, load average: 1.06, 1.17, 1.14
> > 91 processes: 90 sleeping, 1 running, 0 zombie, 0 stopped
> > CPU0 states:   0.0% user   3.1% system    0.0% nice   0.0% iowait  96.2%
> > idle
> > CPU1 states:   0.0% user   0.1% system    0.0% nice   0.0% iowait  99.2%
> > idle
> > Mem:   513172k av,  437740k used,   75432k free,       0k shrd,   17500k
> > buff
> >                     258436k actv,   41792k in_d,   76644k in_c
> > Swap: 1060088k av,      44k used, 1060044k free                  339860k
> > cached
> >
> >   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU
COMMAND
> >     9 root      16   0     0    0     0 SW    0.8  0.0   0:02   0
> > kscand/Normal
> >    31 root      15   0     0    0     0 DW    0.5  0.0   0:05   0
> raid1syncd
> >  2425 root      15   0  1088 1088   864 R     0.2  0.2   0:00   1 top
> >     1 root      15   0   396  396   344 S     0.0  0.0   0:03   1 init
> >     2 root      RT   0     0    0     0 SW    0.0  0.0   0:00   0
> > migration/0
> > ... others...
> >
> > Meanning that the Load Average is incompatible with the use of the CPUs.
> >
> > I really have no idea where to find some clue about what is going on.
> >
> > Thanks
> > Roberto Slepetys
> >
> >
> >
> > ----- Original Message ----- 
> > From: "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>
> > To: "Justin T. Gibbs" <gibbs@scsiguy.com>;
<linux-kernel@vger.kernel.org>
> > Sent: Wednesday, July 02, 2003 6:00 PM
> > Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble
> >
> >
> > > Hi,
> > >
> > > I upgraded it for the 6.2.36, using RPM and I am making some heavy
> tests.
> > >
> > > Until now, it's ok, and for this kind of tests, the old configuration
> gave
> > > some trouble.
> > >
> > > Thanks
> > > Slepetys
> > >
> > > ----- Original Message ----- 
> > > From: "Justin T. Gibbs" <gibbs@scsiguy.com>
> > > To: "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>;
> > > <linux-kernel@vger.kernel.org>
> > > Sent: Wednesday, July 02, 2003 12:14 PM
> > > Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble
> > >
> > >
> > > > > The system halts easily if I do a large I/O, like reindexing a
> > database,
> > > > > giving me some messages like: (scsi0:A:1:0): Locking max tag count
> at
> > > 128...
> > > >
> > > > The "Locking max tag count" messages are normal.  It means the SCSI
> > > > driver was able to determine the maximum queue depth of your drive.
> > > >
> > > > 6.2.8 is rather old.  I don't know that upgrading the aic7xxx driver
> > > > will solve your problem, but it might be worth a shot.  The latest
> > > > is available here:
> > > >
> > > > http://people.FreeBSD.org/~gibbs/linux/SRC/
> > > >
> > > > After upgrading, you should be at 6.2.36.
> > > >
> > > > --
> > > > Justin
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>


