Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284726AbRLUQh7>; Fri, 21 Dec 2001 11:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284728AbRLUQht>; Fri, 21 Dec 2001 11:37:49 -0500
Received: from altus.drgw.net ([209.234.73.40]:17934 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S284726AbRLUQhl>;
	Fri, 21 Dec 2001 11:37:41 -0500
Date: Fri, 21 Dec 2001 10:29:40 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: =?iso-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
Cc: Andre Hedrick <andre@linux-ide.org>, jlm <jsado@mediaone.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Poor performance during disk writes
Message-ID: <20011221102940.W25200@altus.drgw.net>
In-Reply-To: <Pine.LNX.4.10.10112181043110.21250-100000@master.linux-ide.org> <20011218183059.L1832-100000@gerard>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011218183059.L1832-100000@gerard>; from groudier@free.fr on Tue, Dec 18, 2001 at 06:42:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 06:42:49PM +0100, Gérard Roudier wrote:
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

Uh, well, um, what drive is he writing too?? He could very well have 2 gig 
of memory in this box and half the writes were cached. 41MB/s seems 
reasonable for most common IDE disks. Of course I know Andre has some 
rather 'uncommon' IDE drives :P

Does bonnie actually do any sort of 'sync' operation to ensure data 
writen is on the disk? Is that 100mb/sec write real, or just because of 
block layer caching?

> 
> Note that if you intend to use it only for write-only applications,
> performance are not that bad, even if just dropping the data on the floor
> would give you infinite throughput without any difference in
> functionnality. :-)
> 
> 
> Gérard Roudier
> Not CEO, not President of anything.
> 
> > Regards,
> >
> >
> > Andre Hedrick
> > CEO/President, LAD Storage Consulting Group
> > Linux ATA Development
> > Linux Disk Certification Project
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
