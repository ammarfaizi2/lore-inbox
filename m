Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261623AbRESCJG>; Fri, 18 May 2001 22:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261627AbRESCI5>; Fri, 18 May 2001 22:08:57 -0400
Received: from idiom.com ([216.240.32.1]:63239 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S261623AbRESCIr>;
	Fri, 18 May 2001 22:08:47 -0400
Message-ID: <3B05D57F.EB837E2B@namesys.com>
Date: Fri, 18 May 2001 19:07:59 -0700
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>
CC: =?koi8-r?Q?=E1=CE=C4=D2=C5=CA=20=F4=C0=CC=C5=CE=C5=D7?= 
	<postum@mail.ru>,
        reiserfs-list@namesys.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-list] reiserfs, xfs, ext2, ext3 (simple benchmarks)
In-Reply-To: <4211243847.20010513012324@mail.ru> <3AFDC9D1.592D566D@namesys.com> <3AFFA0EE.35199482@yura.polnet.botik.ru> <3B0160E0.55E05D7F@yura.polnet.botik.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord, please work with Yura to resolve the bug that mongo triggers in
XFS.  I assume you will be as eager as we usually are for any script that can
reproduce a bug.

Yura's benchmarks don't really show off the strengths of XFS, just as the
spanish benchmark didn't show off the strengths of reiserfs.  I expect that once
mongo works there will be areas where XFS has clear advantages, probably in
large file IO and for reads.  We look forward to measuring reiser4 against XFS
during linux 2.6, though I suspect there will always be (changing) areas where
the two filesystems each offer the users different advantages.

Hans

"Yury Yu. Rupasov" wrote:
> 
> "Yury Yu. Rupasov" wrote:
> >
> > Hans Reiser wrote:
> > >
> > > Andrey Tulenev wrote:
> > >
> > > > Hello reiserfs-list,
> > > >
> > > > http://www.uwsg.indiana.edu/hypermail/linux/kernel/0105.1/0358.html
> > > > http://bulma.lug.net/body.phtml?nIdNoticia=626
> > > >
> > > > --
> > > > Best regards,                  [Team òõäîÉË]
> > > >  Andrey                          mailto:postum@mail.ru
> > > > Pager: 913-5353 ab.17403   or  17403@pager.asvt.ru
> > >
> > > I don't understand why you all didn't run more serious benchmarks.
> > > We'll try mongo.pl from the benchmarks section of www.namesys.com, and
> > > report on the results.
> > >
> > > Hans
> >
> > Yes, we have some results : ext2 vs. reiserfs on our web page :
> > http://www.namesys.com/benchmarks/benchmark-results.html
> >
> > But yes, now when xfs is released, it would be not bad to check
> > it performance too. The results will be ready a bit later.
> >
> 
> I have some results now : bonnie++ for ext2, reiserfs and xfs :
> 
> ftp://ftp.botik.ru/rented/namesys/ftp/pub/linux+reiserfs/gif/a.html
> 
> Linux-2.4.2+xfs-1.0-patches,
> 
> There was no problems to apply the next xfs patches
> to pure linux-2.4.2 :
> 
> linux-2.4-xfs-1.0.patch
> linux-2.4.2-core-xfs-1.0,patch
> 
> Test Machine : Celeron 500, 128 MB RAM,
>                8 GB test partition of 36 GB IDE HDD.
> 
> The bonnie++ results show that reiserfs is much more faster
> in case of big amount of files (30000 files here).
> 
> Here are also dbench results :
> 
>               ext2       xfs      reiserfs
>             -------------------------------------
> dbench  1   15.6062    19.0732    23.1156    mb/sec
> dbench  5    8.4490    11.6781    11.8350    mb/sec
> dbench 10    9.3481     6.1847     8.9247    mb/sec
> dbench 20    7.3631     2.6893     6.9256    mb/sec
> 
> Unfortunately, I have no mongo.pl results, because the system
> hangs during performing mongo test on xfs system.
> 
> I had to press "reset" button to reboot system, because all
> others ways did not work.
> 
> There was no any error messages in the system log.
> 
> Thanks,
> Yura.
