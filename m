Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279997AbRLDCz6>; Mon, 3 Dec 2001 21:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281657AbRLCXsh>; Mon, 3 Dec 2001 18:48:37 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:63504 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S285121AbRLCUjG>; Mon, 3 Dec 2001 15:39:06 -0500
Date: Mon, 3 Dec 2001 17:22:16 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jason Holmes <jholmes@psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO degradation in 2.4.17-pre2 vs. 2.4.16
In-Reply-To: <3C092CAB.4D1541F4@psu.edu>
Message-ID: <Pine.LNX.4.21.0112031717020.19010-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jason,

Yes, throughtput-only tests will have their numbers degradated with the
change applied on 2.4.16-pre2.

The whole thing is just about tradeoffs: Interactivity vs throughtput.

I'm not going to destroy interactivity for end users to get beatiful
dbench numbers.

And about your clients: Don't you think they want some kind of
decent latency on their side? 

Anyway, thanks for your report! 

On Sat, 1 Dec 2001, Jason Holmes wrote:

> I saw in a previous thread that the interactivity improvements in
> 2.4.17-pre2 had some adverse effect on IO throughput and since I was
> already evaluating 2.4.16 for a somewhat large fileserving project, I
> threw 2.4.17-pre2 on to see what has changed.  Throughput while serving
> a large number of clients is important to me, so my tests have included
> using dbench to try to see how things scale as clients increase.
> 
> 2.4.16:
> 
> Throughput 116.098 MB/sec (NB=145.123 MB/sec  1160.98 MBit/sec)  1 procs
> Throughput 206.604 MB/sec (NB=258.255 MB/sec  2066.04 MBit/sec)  2 procs
> Throughput 210.364 MB/sec (NB=262.955 MB/sec  2103.64 MBit/sec)  4 procs
> Throughput 213.397 MB/sec (NB=266.747 MB/sec  2133.97 MBit/sec)  8 procs
> Throughput 210.989 MB/sec (NB=263.736 MB/sec  2109.89 MBit/sec)  16
> procs
> Throughput 138.713 MB/sec (NB=173.391 MB/sec  1387.13 MBit/sec)  32
> procs
> Throughput 117.729 MB/sec (NB=147.162 MB/sec  1177.29 MBit/sec)  64
> procs
> Throughput 66.7354 MB/sec (NB=83.4193 MB/sec  667.354 MBit/sec)  128
> procs
> 
> 2.4.17-pre2:
> 
> Throughput 96.2302 MB/sec (NB=120.288 MB/sec  962.302 MBit/sec)  1 procs
> Throughput 226.679 MB/sec (NB=283.349 MB/sec  2266.79 MBit/sec)  2 procs
> Throughput 223.955 MB/sec (NB=279.944 MB/sec  2239.55 MBit/sec)  4 procs
> Throughput 224.533 MB/sec (NB=280.666 MB/sec  2245.33 MBit/sec)  8 procs
> Throughput 153.672 MB/sec (NB=192.09 MB/sec  1536.72 MBit/sec)  16 procs
> Throughput 91.3464 MB/sec (NB=114.183 MB/sec  913.464 MBit/sec)  32
> procs
> Throughput 64.876 MB/sec (NB=81.095 MB/sec  648.76 MBit/sec)  64 procs
> Throughput 54.9774 MB/sec (NB=68.7217 MB/sec  549.774 MBit/sec)  128
> procs
> 
> Throughput 136.522 MB/sec (NB=170.652 MB/sec  1365.22 MBit/sec)  1 procs
> Throughput 223.682 MB/sec (NB=279.603 MB/sec  2236.82 MBit/sec)  2 procs
> Throughput 222.806 MB/sec (NB=278.507 MB/sec  2228.06 MBit/sec)  4 procs
> Throughput 224.427 MB/sec (NB=280.534 MB/sec  2244.27 MBit/sec)  8 procs
> Throughput 152.286 MB/sec (NB=190.358 MB/sec  1522.86 MBit/sec)  16
> procs
> Throughput 92.044 MB/sec (NB=115.055 MB/sec  920.44 MBit/sec)  32 procs
> Throughput 78.0881 MB/sec (NB=97.6101 MB/sec  780.881 MBit/sec)  64
> procs
> Throughput 66.1573 MB/sec (NB=82.6966 MB/sec  661.573 MBit/sec)  128
> procs
> 
> Throughput 117.95 MB/sec (NB=147.438 MB/sec  1179.5 MBit/sec)  1 procs
> Throughput 212.469 MB/sec (NB=265.586 MB/sec  2124.69 MBit/sec)  2 procs
> Throughput 214.763 MB/sec (NB=268.453 MB/sec  2147.63 MBit/sec)  4 procs
> Throughput 214.007 MB/sec (NB=267.509 MB/sec  2140.07 MBit/sec)  8 procs
> Throughput 96.6572 MB/sec (NB=120.821 MB/sec  966.572 MBit/sec)  16
> procs
> Throughput 48.1342 MB/sec (NB=60.1677 MB/sec  481.342 MBit/sec)  32
> procs
> Throughput 71.3444 MB/sec (NB=89.1806 MB/sec  713.444 MBit/sec)  64
> procs
> Throughput 59.258 MB/sec (NB=74.0724 MB/sec  592.58 MBit/sec)  128 procs
> 
> I have included three runs for 2.4.17-pre2 to show how inconsistent its
> results are; 2.4.16 didn't have this problem to this extent.  bonnie++
> numbers seem largely unchanged between kernels, coming in around:
> 
>       ------Sequential Output------ --Sequential Input- --Random-
>       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
>  Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> 2512M 14348  81 49495  26 24438  16 16040  96 55006  15 373.7   1
>       ------Sequential Create------ --------Random Create--------
>       -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
> files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>    16  3087  99 +++++ +++ +++++ +++  3175 100 +++++ +++ 11042 100
> 
> The test machine is an IBM 342 with 2 1.26 GHz P3 processors and 1.25 GB
> of RAM.  The above numbers were generated off of 1 10K RPM SCSI disk
> hanging off of an Adaptec aix7899 controller.
> 
> --
> Jason Holmes
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

