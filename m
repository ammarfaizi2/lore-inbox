Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbTGCSMh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 14:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbTGCSMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 14:12:36 -0400
Received: from 200-204-171-188.insite.com.br ([200.204.171.188]:16137 "HELO
	proxy.inteliweb.com.br") by vger.kernel.org with SMTP
	id S265224AbTGCSMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 14:12:33 -0400
Message-ID: <016901c34191$14c4a1c0$3300a8c0@Slepetys>
From: "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>
To: "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, <linux-kernel@vger.kernel.org>
References: <00d901c340a8$810556c0$3300a8c0@Slepetys> <1083830000.1057158848@aslan.scsiguy.com> <01b101c340dc$ede386c0$3300a8c0@Slepetys>
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble
Date: Thu, 3 Jul 2003 15:29:46 -0300
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

Ops....
The linux box halted again, after 12 hours operating normaly.

The more strange is that there isn't any message in the /var/log/message,
the system simples stop to respond, and some strange behavior is that the
TOP comand gaves me :

15:10:15     up   33 min, 1 user, load average: 1.06, 1.17, 1.14
91 processes: 90 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:   0.0% user   3.1% system    0.0% nice   0.0% iowait  96.2%
idle
CPU1 states:   0.0% user   0.1% system    0.0% nice   0.0% iowait  99.2%
idle
Mem:   513172k av,  437740k used,   75432k free,       0k shrd,   17500k
buff
                    258436k actv,   41792k in_d,   76644k in_c
Swap: 1060088k av,      44k used, 1060044k free                  339860k
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
    9 root      16   0     0    0     0 SW    0.8  0.0   0:02   0
kscand/Normal
   31 root      15   0     0    0     0 DW    0.5  0.0   0:05   0 raid1syncd
 2425 root      15   0  1088 1088   864 R     0.2  0.2   0:00   1 top
    1 root      15   0   396  396   344 S     0.0  0.0   0:03   1 init
    2 root      RT   0     0    0     0 SW    0.0  0.0   0:00   0
migration/0
... others...

Meanning that the Load Average is incompatible with the use of the CPUs.

I really have no idea where to find some clue about what is going on.

Thanks
Roberto Slepetys



----- Original Message ----- 
From: "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>; <linux-kernel@vger.kernel.org>
Sent: Wednesday, July 02, 2003 6:00 PM
Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble


> Hi,
>
> I upgraded it for the 6.2.36, using RPM and I am making some heavy tests.
>
> Until now, it's ok, and for this kind of tests, the old configuration gave
> some trouble.
>
> Thanks
> Slepetys
>
> ----- Original Message ----- 
> From: "Justin T. Gibbs" <gibbs@scsiguy.com>
> To: "Roberto Slepetys Ferreira" <slepetys@homeworks.com.br>;
> <linux-kernel@vger.kernel.org>
> Sent: Wednesday, July 02, 2003 12:14 PM
> Subject: Re: Probably 2.4 kernel or AIC7xxx module trouble
>
>
> > > The system halts easily if I do a large I/O, like reindexing a
database,
> > > giving me some messages like: (scsi0:A:1:0): Locking max tag count at
> 128...
> >
> > The "Locking max tag count" messages are normal.  It means the SCSI
> > driver was able to determine the maximum queue depth of your drive.
> >
> > 6.2.8 is rather old.  I don't know that upgrading the aic7xxx driver
> > will solve your problem, but it might be worth a shot.  The latest
> > is available here:
> >
> > http://people.FreeBSD.org/~gibbs/linux/SRC/
> >
> > After upgrading, you should be at 6.2.36.
> >
> > --
> > Justin


