Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285152AbRLRUnq>; Tue, 18 Dec 2001 15:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285148AbRLRUlh>; Tue, 18 Dec 2001 15:41:37 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:39940
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S285150AbRLRUkv> convert rfc822-to-8bit; Tue, 18 Dec 2001 15:40:51 -0500
Date: Tue, 18 Dec 2001 12:34:36 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
cc: jlm <jsado@mediaone.net>, linux-kernel@vger.kernel.org
Subject: Re: Poor performance during disk writes
In-Reply-To: <20011218183059.L1832-100000@gerard>
Message-ID: <Pine.LNX.4.10.10112181230570.21250-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2001, Gérard Roudier wrote:

> 
> 
> On Tue, 18 Dec 2001, Andre Hedrick wrote:
> 
> > File './Bonnie.2276', size: 1073741824, volumes: 1
> > Writing with putc()...  done:  72692 kB/s  83.7 %CPU
> > Rewriting...            done:  25355 kB/s  12.0 %CPU
> > Writing intelligently...done: 103022 kB/s  40.5 %CPU
> > Reading with getc()...  done:  37188 kB/s  67.5 %CPU
> > Reading intelligently...done:  40809 kB/s  11.4 %CPU
> > Seeker 2...Seeker 1...Seeker 3...start 'em...done...done...done...
> >               ---Sequential Output (nosync)--- ---Sequential Input-- --Rnd Seek-
> >               -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --04k (03)-
> > Machine    MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU   /sec %CPU
> >        1*1024 72692 83.7 103022 40.5 25355 12.0 37188 67.5 40809 11.4  382.1  2.4
> >
> > Maybe this is the kind of performance you want out your ATA subsystem.
> > Maybe if I could get a patch in to the kernels we could all have stable
> > and fast IO.
> 
> I rather see lots of wasting rather than performance, here. Bonnie says
> that your subsystem can sustain 103 MB/s write but only 41 MB/s read. This
> looks about 60% throughput wasted for read.
> 
> Note that if you intend to use it only for write-only applications,
> performance are not that bad, even if just dropping the data on the floor
> would give you infinite throughput without any difference in
> functionnality. :-)

Well sense somebody paid/paying me make write performance go through the
roof -- that is what I did.  Now if you look closely you could see that in
writing we are doing a boat load more work than reading.  If somebody want
me to throttle the reads more then they know how to get it done.

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

