Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267520AbRHaPty>; Fri, 31 Aug 2001 11:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267621AbRHaPtp>; Fri, 31 Aug 2001 11:49:45 -0400
Received: from atlrel7.hp.com ([192.151.27.9]:57866 "HELO atlrel7.hp.com")
	by vger.kernel.org with SMTP id <S267520AbRHaPtd>;
	Fri, 31 Aug 2001 11:49:33 -0400
Message-ID: <F341E03C8ED6D311805E00902761278C04728F03@xfc04.fc.hp.com>
From: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
To: "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Performance 2.4.8 is worse than 2.4.x<8 (SPEC NFS results sho
	w this)
Date: Fri, 31 Aug 2001 11:47:46 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More results:
- 2.4.7 with ext3
- 2.4.7_with ext3 and "interactivity" patch
http://www.uow.edu.au/~andrewm/linux/ext3/interactivity.patch
- 2.4.7 (reiserfs) with ext3's "interactivity" patch
- 2.4.7 with Arjan van de Ven highmem patch
http://mail.nl.linux.org/linux-mm/2001-08/msg00270.html
- 2.4.9 compiled for 1GB memory
- 2.4.9 compiled for 4GB memory
- 2.4.9 compiled for 4GB memory and Benjamin Redelings I Set Page Referenced
patch http://mail.nl.linux.org/linux-mm/2001-08/msg00200.html
- 2.4.9 with jens axboe highmem-13
http://www.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.9/block-high
mem-all-13.bz2
- 2.4.10pre2 compiled for 1GB memory

2.4.7_ext3
            500     497     1.4   149169  300 3 U    5070624   1 48  2  2
2.0
           1000    1002     2.4   299710  299 3 U   10141248   1 48  2  2
2.0
           1500    1505     2.4   449887  299 3 U   15210624   1 48  2  2
2.0
INVALID
peak IOPS: 43% of 2.4.5pre1

2.4.7_ext3-interactivity
            500     495     1.2   148578  300 3 U    5070624   1 48  2  2
2.0
           1000    1001     2.0   300294  300 3 U   10141248   1 48  2  2
2.0
           1500    1497     2.5   447462  299 3 U   15210624   1 48  2  2
2.0
INVALID
peak IOPS: 42% of 2.4.5pre1

2.4.7 (reiserfs) with ext3's "interactivity" patch
            500     499     1.0   149149  299 3 U    5070624   1 48  2  2
2.0
           1000    1003     1.2   300026  299 3 U   10141248   1 48  2  2
2.0
           1500    1502     1.3   449119  299 3 U   15210624   1 48  2  2
2.0
peak IOPS: 56% of 2.4.5pre1

2.4.7_arjan-highmem
            500     498     1.2   149007  299 3 U    5070624   1 48  2  2
2.0
           1000    1002     1.5   299680  299 3 U   10141248   1 48  2  2
2.0
           1500    1501     1.5   448802  299 3 U   15210624   1 48  2  2
2.0
peak IOPS: 63% of 2.4.5pre1

2.4.9_1GB
            500     497     1.3   149088  300 3 U    5070624   1 48  2  2
2.0
           1000    1002     1.5   299681  299 3 U   10141248   1 48  2  2
2.0
           1500    1497     2.7   449230  300 3 U   15210624   1 48  2  2
2.0
peak IOPS: 34% of 2.4.5pre1

2.4.9_4GB
            500     500     1.9   149360  299 3 U    5070624   1 48  2  2
2.0
           1000    1046     7.1   312741  299 3 U   10141248   1 48  2  2
2.0
peak IOPS: 14% of 2.4.5pre1

2.4.9_4GB_pagereffix
            500     499     1.4   149120  299 3 U    5070624   1 48  2  2
2.0
           1000    1005     5.0   300564  299 3 U   10141248   1 48  2  2
2.0
           1500    1574     8.9   470658  299 3 U   15210624   1 48  2  2
2.0
peak IOPS: 21% of 2.4.5pre1

2.4.9_axboehighmem13
            500     498     1.8   149031  299 3 U    5070624   1 48  2  2
2.0
           1000    1003     3.3   300847  300 3 U   10141248   1 48  2  2
2.0
           1500    1493     4.3   447802  300 3 U   15210624   1 48  2  2
2.0
INVALID
peak IOPS: 36% of 2.4.5pre1

2.4.10-pre2-1GB
            500     497     1.1   149088  300 3 U    5070624   1 48  2  2
2.0
           1000    1034     8.7   309283  299 3 U   10141248   1 48  2  2
2.0
           1500    1301    12.5   390299  300 3 U   15210624   1 48  2  2
2.0
INVALID
peak IOPS: 18% of 2.4.5pre1

> -----Original Message-----
> From: HABBINGA,ERIK (HP-Loveland,ex1) 
> Sent: Friday, August 17, 2001 10:15 AM
> To: 'linux-kernel@vger.kernel.org'
> Subject: RE: Performance 2.4.8 is worse than 2.4.x<8 (SPEC NFS results
> show this)
> 
> 
> More results: 
> 
> 2.4.7 with Dieter Nutzel's kupdated/bdflush ideas 
> http://lists.insecure.org/linux-kernel/2001/Aug/2377.html
> 2.4.7 with ext2
> 2.4.9-pre3
> 2.4.9-pre3 with ext2
> 2.4.9 (not good)
> 
> 2.4.7 with Dieter Nutzel's kupdated/bdflush ideas 
> http://lists.insecure.org/linux-kernel/2001/Aug/2377.html
>   500     497     1.2   149158  300 3 U    5070624   1 48  2  2 2.0
>  1000    1005     1.4   300591  299 3 U   10141248   1 48  2  2 2.0
>  1500    1504     1.4   449815  299 3 U   15210624   1 48  2  2 2.0
> peak IOPS: 63% of 2.4.5pre1
> performance slightly worse (2%, could be within 
> repeatability) than without Dieter's ideas.
> 
> 2.4.7 with ext2
>   500     497     0.9   149186  300 3 U    5070624   1 48  2  2 2.0
>  1000    1004     1.0   300202  299 3 U   10141248   1 48  2  2 2.0
>  1500    1500     1.1   448489  299 3 U   15210624   1 48  2  2 2.0
> peak IOPS: 78% of 2.4.5pre1
> 
> 2.4.9-pre3
>   500     497     1.3   149177  300 3 U    5070624   1 48  2  2 2.0
>  1000     995     2.0   298633  300 3 U   10141248   1 48  2  2 2.0
>  1500    1487     2.0   446234  300 3 U   15210624   1 48  2  2 2.0
> peak IOPS: 55% of 2.4.5pre1
> 
> 2.4.9-pre3 with ext2
>   500     497     1.5   149113  300 3 U    5070624   1 48  2  2 2.0
>  1000    1078     1.5   322280  299 3 U   10141248   1 48  2  2 2.0
>  1500    1512     1.6   452080  299 3 U   15210624   1 48  2  2 2.0
> INVALID
> peak IOPS: 57% of 2.4.5pre1
> This test started having rpc problems late in the test.  I 
> had stopped the reiserfs 2.4.9-pre3 test before getting that 
> far, so I don't know if 2.4.9-pre3 would have the same problems.
> 
> 2.4.9 (not good)
>   500     499     1.9   149185  299 3 U    5070624   1 48  2  2 2.0
>  1000    1007     4.8   302210  300 3 U   10141248   1 48  2  2 2.0
>  1500    1561    11.0   466752  299 3 U   15210624   1 48  2  2 2.0
> INVALID
> peak IOPS: 21% of 2.4.5pre1
> response time kept increasing dramatically after the 1500 
> IOPS run, failing after a few more tests
> 
> Erik
> 
> > -----Original Message-----
> > From: HABBINGA,ERIK (HP-Loveland,ex1) 
> > Sent: Wednesday, August 15, 2001 3:14 PM
> > To: 'linux-kernel@vger.kernel.org'
> > Subject: re: Performance 2.4.8 is worse than 2.4.x<8 (SPEC 
> NFS results
> > show this)
> > 
> > 
> > And the results for 2.4.9pre4 (not good)
> > 
> >             500     492     2.6   147693  300 3 U    5070624  
> >  1 48  2  2 2.0
> >            1000    1019     4.4   304713  299 3 U   10141248  
> >  1 48  2  2 2.0
> >            1500    1475     6.1   442446  300 3 U   15210624  
> >  1 48  2  2 2.0
> > peak IOPS: 22% of 2.4.5pre1 
> > TIMED OUT
> > 
> > response time kept going up, only two more SPEC runs (2500 
> > IOPS) finished.
> > 
> > Erik
> > 
> > > -----Original Message-----
> > > From: HABBINGA,ERIK (HP-Loveland,ex1) 
> > > Sent: Monday, August 13, 2001 10:41 AM
> > > To: 'linux-kernel@vger.kernel.org'
> > > Subject: re: Performance 2.4.8 is worse than 2.4.x<8 (SPEC 
> > NFS results
> > > show this)
> > > 
> > > 
> > > Here are some SPEC SFS NFS testing 
> > > (http://www.spec.org/osg/sfs97) results I've been doing over 
> > > the past few weeks that shows NFS performance degrading since 
> > > the 2.4.5pre1 kernel.  I've kept the hardware constant, only 
> > > changing the kernel.  I'm prevented by management from 
> > > releasing our top numbers, but have given our results 
> > > normalized to the 2.4.5pre1 kernel.  I've also shown the 
> > > results from the first three SPEC runs to show the response 
> > > time trend.
> > > 
> > > Normally, response time should start out very low, increasing 
> > > slowly until the maximum load of the system under test is 
> > > reached.  Starting with 2.4.8pre8, the response time starts 
> > > very high, and then decreases.  Very bizarre behaviour.
> > > 
> > > The spec results consist of the following data (only the 
> > > first three numbers are significant for this discussion)
> > > - load.  The load the SPEC prime client will try to get out 
> > > of the system under test.  Measured in I/O's per second (IOPS).
> > > - throughput.  The load seen from the system under test.  
> > > Measured in IOPS
> > > - response time.  Measured in milliseconds
> > > - total operations
> > > - elapsed time.  Measured in seconds
> > > - NFS version. 2 or 3
> > > - Protocol. UDP (U) or TCP (T)
> > > - file set size in megabytes
> > > - number of clients
> > > - number of SPEC SFS processes
> > > - biod reads
> > > - biod writes
> > > - SPEC SFS version
> > > 
> > > The 2.4.8pre4 and 2.4.8 tests were invalid.  Too many (> 1%) 
> > > of the RPC calls between the SPEC prime client and the system 
> > > under test failed.  This is not a good thing.
> > > 
> > > I'm willing to try out any ideas on this system to help find 
> > > and fix the performance degradation.
> > > 
> > > Erik Habbinga
> > > Hewlett Packard
> > > 
> > > Hardware:
> > > 4 processors, 4GB ram
> > > 45 fibre channel drives, set up in hardware RAID 0/1
> > > 2 direct Gigabit Ethernet connections between SPEC SFS prime 
> > > client and system under test
> > > reiserfs
> > > all NFS filesystems exported with sync,no_wdelay to insure 
> > > O_SYNC writes to storage
> > > NFS v3 UDP
> > > 
> > > Results:
> > > 2.4.5pre1
> > >             500     497     0.8   149116  300 3 U    5070624  
> > >  1 48  2  2 2.0
> > >            1000    1004     1.0   300240  299 3 U   10141248  
> > >  1 48  2  2 2.0
> > >            1500    1501     1.0   448807  299 3 U   15210624  
> > >  1 48  2  2 2.0
> > > peak IOPS: 100% of 2.4.5pre1
> > > 
> > > 2.4.5pre2
> > >             500     497     1.0   149195  300 3 U    5070624  
> > >  1 48  2  2 2.0
> > >            1000    1005     1.2   300449  299 3 U   10141248  
> > >  1 48  2  2 2.0
> > >            1500    1502     1.2   449057  299 3 U   15210624  
> > >  1 48  2  2 2.0
> > > peak IOPS: 91% of 2.4.5pre1
> > > 
> > > 2.4.5pre3
> > >             500     497     1.0   149095  300 3 U    5070624  
> > >  1 48  2  2 2.0
> > >            1000    1004     1.1   300135  299 3 U   10141248  
> > >  1 48  2  2 2.0
> > >            1500    1502     1.2   449069  299 3 U   15210624  
> > >  1 48  2  2 2.0
> > > peak IOPS: 91% of 2.4.5pre1
> > > 
> > > 2.4.5pre4
> > >    wouldn't run (stale NFS file handle error)
> > > 
> > > 2.4.5pre5
> > >    wouldn't run (stale NFS file handle error)
> > > 
> > > 2.4.5pre6
> > >    wouldn't run (stale NFS file handle error)
> > > 
> > > 2.4.7
> > >             500     497     1.2   149206  300 3 U    5070624  
> > >  1 48  2  2 2.0
> > >            1000    1005     1.5   300503  299 3 U   10141248  
> > >  1 48  2  2 2.0
> > >            1500    1502     1.3   449232  299 3 U   15210624  
> > >  1 48  2  2 2.0
> > > peak IOPS: 65% of 2.4.5pre1
> > > 
> > > 2.4.8pre1
> > >    wouldn't run
> > > 
> > > 2.4.8pre4
> > >             500     497     1.1   149180  300 3 U    5070624  
> > >  1 48  2  2 2.0
> > >            1000    1002     1.2   299465  299 3 U   10141248  
> > >  1 48  2  2 2.0
> > >            1500    1502     1.3   449190  299 3 U   15210624  
> > >  1 48  2  2 2.0
> > > INVALID
> > > peak IOPS: 54% of 2.4.5pre1
> > > 
> > > 2.4.8pre6
> > >             500     497     1.1   149168  300 3 U    5070624  
> > >  1 48  2  2 2.0
> > >            1000    1004     1.3   300246  299 3 U   10141248  
> > >  1 48  2  2 2.0
> > >            1500    1502     1.3   449135  299 3 U   15210624  
> > >  1 48  2  2 2.0
> > > peak IOPS 55% of 2.4.5pre1
> > > 
> > > 2.4.8pre7
> > >             500     498     1.5   149367  300 3 U    5070624  
> > >  1 48  2  2 2.0
> > >            1000    1006     2.2   301829  300 3 U   10141248  
> > >  1 48  2  2 2.0
> > >            1500    1502     2.2   449244  299 3 U   15210624  
> > >  1 48  2  2 2.0
> > > peak IOPS: 58% of 2.4.5pre1
> > > 
> > > 2.4.8pre8
> > >             500     597     8.3   179030  300 3 U    5070624  
> > >  1 48  2  2 2.0
> > >            1000    1019     6.5   304614  299 3 U   10141248  
> > >  1 48  2  2 2.0
> > >            1500    1538     4.5   461335  300 3 U   15210624  
> > >  1 48  2  2 2.0
> > > peak IOPS: 48% of 2.4.5pre1
> > > 
> > > 2.4.8
> > >             500     607     7.1   181981  300 3 U    5070624  
> > >  1 48  2  2 2.0
> > >            1000     997     7.0   299243  300 3 U   10141248  
> > >  1 48  2  2 2.0
> > >            1500    1497     2.9   447475  299 3 U   15210624  
> > >  1 48  2  2 2.0
> > > INVALID
> > > peak IOPS: 45% of 2.4.5pre1
> > > 
> > > 2.4.9pre2
> > >    wouldn't run (NFS readdir errors)
> > > 
> > 
> 
