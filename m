Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266578AbTATQ6z>; Mon, 20 Jan 2003 11:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266609AbTATQ6y>; Mon, 20 Jan 2003 11:58:54 -0500
Received: from fmr01.intel.com ([192.55.52.18]:5609 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S266578AbTATQ6s> convert rfc822-to-8bit;
	Mon, 20 Jan 2003 11:58:48 -0500
content-class: urn:content-classes:message
Subject: RE: Intel C++ compiler?
Date: Mon, 20 Jan 2003 09:07:50 -0800
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB5647D14F2@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Intel C++ compiler?
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcLApRY30tl/UCyXEde/HABQi2jWFgAAMAaA
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>, "John Bradford" <john@grabjohn.com>
Cc: "Henrik Andersen" <peter900000@hotmail.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Jan 2003 17:07:50.0356 (UTC) FILETIME=[766A0940:01C2C0A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com]
> Sent: Monday, January 20, 2003 8:54 AM
> To: John Bradford
> Cc: Henrik Andersen; linux-kernel@vger.kernel.org
> Subject: Re: Intel C++ compiler?
> 
> On Mon, Jan 20, 2003 at 04:48:55PM +0000, John Bradford wrote:
> > > Does Intels C++ compiler for Linux works fine for compiling the Linux
> > > kernel? It is not 100% compatible, as far as I know.
> >
> > I doubt it - Linux makes extensive use of GCC compiler extensions.
> 
> I doubt your doubting.  It works.
> 
> 	Jeff
> 
That's true. 

I posted this on Fri 10/25/2002:
============================================================================
The following are the lmbench results (P3 and P4P) we tried to get. The kernels built by gcc 3.2 were not stable for P4P, so we used an older version of gcc.

p70 -- the kernel built by just with the -O2 optimization (Intel compiler 7.0)
pgoipo -- P70 + PGO (profile-guided optimization) + IPO (interprocedural optimization)
inline -- pgoipo + forced inline
gcc32 -- gcc 3.2
gcc30 -- gcc 3.02 

Jun Nakajima

-----Original Message-----
From: Andi Kleen [mailto:ak@suse.de]
Sent: Friday, October 18, 2002 7:29 PM
To: Nakajima, Jun
Cc: Andi Kleen; David S. Miller; torvalds@transmeta.com;
linux-kernel@vger.kernel.org; Mallick, Asit K; Saxena, Sunil
Subject: Re: [PATCH] fixes for building kernel using Intel compiler



BTW do you have any benchmark / code size results to share with 
Intel compiler vs gcc 3.2 ? How much does it give ?

-Andi
-------------------------------------------------------------------------


UP P3 ====================================================================

cd results && make summary percent 2>/dev/null | more
make[1]: Entering directory `/home/hd7/yu/LMbench/results'

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
p70        Linux 2.4.18       i686-pc-linux-gnu  847
p70        Linux 2.4.18       i686-pc-linux-gnu  847
p70        Linux 2.4.18       i686-pc-linux-gnu  847
pgo        Linux 2.4.18       i686-pc-linux-gnu  847
pgo        Linux 2.4.18       i686-pc-linux-gnu  847
pgo        Linux 2.4.18       i686-pc-linux-gnu  847
pgoipo     Linux 2.4.18       i686-pc-linux-gnu  847
pgoipo     Linux 2.4.18       i686-pc-linux-gnu  847
pgoipo     Linux 2.4.18       i686-pc-linux-gnu  847
inline     Linux 2.4.18       i686-pc-linux-gnu  847
inline     Linux 2.4.18       i686-pc-linux-gnu  847
inline     Linux 2.4.18       i686-pc-linux-gnu  847
gcc32      Linux 2.4.18       i686-pc-linux-gnu  847
gcc32      Linux 2.4.18       i686-pc-linux-gnu  847
gcc32      Linux 2.4.18       i686-pc-linux-gnu  847

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
p70        Linux 2.4.18  847 0.37 0.54 2.76 3.61  15.4 0.93 2.92 95.4 1144 5418
p70        Linux 2.4.18  847 0.37 0.54 2.80 3.61  15.9 0.93 2.92 96.3 1130 5414
p70        Linux 2.4.18  847 0.37 0.57 2.78 3.68  16.0 0.93 2.92 95.8 1152 5417
pgo        Linux 2.4.18  847 0.35 0.52 2.88 3.42  15.5 0.91 2.92 95.8 1122 5342
pgo        Linux 2.4.18  847 0.35 0.52 2.73 3.38  16.8 0.91 2.94 97.4 1107 5332
pgo        Linux 2.4.18  847 0.35 0.52 2.83 3.41  13.7 0.91 2.92 95.6 1133 5324
pgoipo     Linux 2.4.18  847 0.35 0.53 2.32 2.76  13.3 0.92 2.84 91.9 1131 5267
pgoipo     Linux 2.4.18  847 0.35 0.52 2.25 2.76  14.5 0.92 2.84 106. 1120 5259
pgoipo     Linux 2.4.18  847 0.35 0.51 2.34 2.81  13.2 0.92 2.84 95.8 1121 5270
inline     Linux 2.4.18  847 0.35 0.51 2.26 2.77  13.4 0.92 2.84 105. 1173 5294
inline     Linux 2.4.18  847 0.35 0.51 2.26 2.89  13.4 0.92 2.84 91.0 1099 5280
inline     Linux 2.4.18  847 0.35 0.51 2.32 2.92  13.3 0.92 2.84 90.6 1126 5329
gcc32      Linux 2.4.18  847 0.35 0.52 3.01 3.67  15.0 0.95 3.10 104. 1200 5532
gcc32      Linux 2.4.18  847 0.35 0.51 3.03 3.73  15.6 0.95 3.10 103. 1182 5521
gcc32      Linux 2.4.18  847 0.35 0.51 3.06 3.76  15.0 0.95 3.10 104. 1169 5520

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
p70        Linux 2.4.18 0.770 3.9900   13.3 4.5000  163.2    33.3   163.8
p70        Linux 2.4.18 0.700 3.9500   13.7 6.1400  163.4    31.4   163.4
p70        Linux 2.4.18 0.730 4.1900   13.0 7.9100  162.7    37.6   162.9
pgo        Linux 2.4.18 0.840 4.1100   22.0 8.9200  164.0    36.6   164.4
pgo        Linux 2.4.18 0.820 3.9900   13.0 5.6000  162.6    32.8   163.2
pgo        Linux 2.4.18 0.930 3.9900   13.1 4.8700  162.9    33.4   163.4
pgoipo     Linux 2.4.18 0.820 3.9100   13.0 6.1800  163.5    30.0   163.5
pgoipo     Linux 2.4.18 0.860 3.9600   13.1 5.2000  163.7    33.6   163.6
pgoipo     Linux 2.4.18 0.820 4.1000   13.5 5.4900  162.4    33.7   163.2
inline     Linux 2.4.18 0.900 4.0800   13.1 7.3500  162.8    30.7   162.9
inline     Linux 2.4.18 0.830 4.0600   13.3 7.7100  163.6    33.1   163.9
inline     Linux 2.4.18 0.810 3.9300   62.7 4.7700  162.2    31.4   163.3
gcc32      Linux 2.4.18 0.780 4.1100   14.9 8.2400  163.6    33.0   164.3
gcc32      Linux 2.4.18 0.870 4.1900   13.1 4.4300  162.6    30.8   163.0
gcc32      Linux 2.4.18 0.900 4.2000   15.3 6.4100  162.2    30.7   162.5

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
p70        Linux 2.4.18 0.770 4.111 7.30  13.1  32.8  18.9  44.7 69.1
p70        Linux 2.4.18 0.700 4.405 7.51  13.2  32.8  19.2  45.6 70.1
p70        Linux 2.4.18 0.730 4.392 7.37  13.5  32.8  19.3  44.7 70.8
pgo        Linux 2.4.18 0.840 4.187 7.32  11.5  28.6  14.0  36.8 54.4
pgo        Linux 2.4.18 0.820 4.354 7.23  11.6  28.4  14.3  36.9 54.8
pgo        Linux 2.4.18 0.930 4.386 7.50  11.7  28.6  14.5  37.1 54.9
pgoipo     Linux 2.4.18 0.820 4.072 6.83  10.8  27.6  14.0  36.7 53.6
pgoipo     Linux 2.4.18 0.860 4.309 7.05  10.9  27.6  14.2  36.3 53.1
pgoipo     Linux 2.4.18 0.820 4.168 7.09  11.0  27.7  14.2  37.2 53.3
inline     Linux 2.4.18 0.900 4.126 6.96  10.9  27.8  14.1  36.9 53.0
inline     Linux 2.4.18 0.830 4.348 6.96  10.8  27.6  14.1  36.7 53.5
inline     Linux 2.4.18 0.810 4.363 7.15  10.8  27.3  14.1  36.7 53.7
gcc32      Linux 2.4.18 0.780 4.224 7.33  15.7  35.3  21.6  47.5 72.9
gcc32      Linux 2.4.18 0.870 4.327 7.56  15.7  35.6  21.8  47.1 73.0
gcc32      Linux 2.4.18 0.900 4.377 7.55  15.6  35.5  21.9  48.0 72.8

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page	
                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
p70        Linux 2.4.18   17.4 5.0970  101.8   11.6    417.0 0.729 2.00000
p70        Linux 2.4.18   17.5 5.2120  102.3   11.7    420.0 0.729 2.00000
p70        Linux 2.4.18   17.4 5.1150  101.3   11.7    430.0 0.731 2.00000
pgo        Linux 2.4.18   18.2 4.9460  102.5   10.9    409.0 0.712 2.00000
pgo        Linux 2.4.18   18.1 4.8450  101.6   10.8    422.0 0.700 2.00000
pgo        Linux 2.4.18   18.2 4.9180  101.9   10.9    432.0 0.701 2.00000
pgoipo     Linux 2.4.18   17.1 4.5070  100.2   10.4    376.0 0.709 2.00000
pgoipo     Linux 2.4.18   17.0 4.4400  100.2   10.3    388.0 0.708 2.00000
pgoipo     Linux 2.4.18   17.1 4.5340  100.1   10.5    393.0 0.730 2.00000
inline     Linux 2.4.18   17.1 4.4790  101.0   10.4    375.0 0.709 2.00000
inline     Linux 2.4.18   17.1 4.5270  100.9   10.4    387.0 0.709 2.00000
inline     Linux 2.4.18   17.2 4.5390   99.6   10.4    380.0 0.709 2.00000
gcc32      Linux 2.4.18   36.1 5.4180  123.8   12.1    379.0 0.709 2.00000
gcc32      Linux 2.4.18   36.2 5.3890  122.8   12.0    393.0 0.715 2.00000
gcc32      Linux 2.4.18   36.1 5.3990  121.0   12.0    398.0 0.709 2.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
p70        Linux 2.4.18 847. 660. 205.  402.5  372.7  157.5  150.8 372. 196.1
p70        Linux 2.4.18 841. 409. 233.  410.2  372.8  153.8  147.5 372. 197.1
p70        Linux 2.4.18 848. 712. 235.  414.5  372.8  156.1  151.5 372. 202.0
pgo        Linux 2.4.18 863. 571. 280.  415.1  372.8  152.8  146.8 372. 193.2
pgo        Linux 2.4.18 860. 555. 285.  415.1  372.8  151.9  145.3 372. 195.0
pgo        Linux 2.4.18 847. 750. 168.  415.4  372.6  152.7  146.6 372. 195.7
pgoipo     Linux 2.4.18 869. 704. 237.  417.4  372.9  152.7  146.1 372. 193.1
pgoipo     Linux 2.4.18 868. 683. 308.  414.2  372.9  151.5  145.3 372. 194.9
pgoipo     Linux 2.4.18 866. 393. 220.  413.9  372.9  152.8  146.4 372. 195.8
inline     Linux 2.4.18 880. 550. 223.  406.1  372.6  152.9  146.7 372. 191.8
inline     Linux 2.4.18 803. 345. 212.  416.7  372.9  151.5  145.3 372. 195.0
inline     Linux 2.4.18 872. 704. 236.  413.6  372.9  152.7  146.2 372. 195.9
gcc32      Linux 2.4.18 872. 612. 190.  414.0  372.8  158.5  151.2 372. 194.9
gcc32      Linux 2.4.18 868. 384. 230.  416.8  372.5  155.2  150.1 372. 199.4
gcc32      Linux 2.4.18 856. 675. 196.  416.6  372.8  157.1  151.8 372. 202.8

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
p70        Linux 2.4.18   847 3.540 8.2610  131.8
p70        Linux 2.4.18   847 3.540 8.2630  131.8
p70        Linux 2.4.18   847 3.541 8.2610  131.8
pgo        Linux 2.4.18   847 3.541 8.2600  131.8
pgo        Linux 2.4.18   847 3.541 8.2600  131.8
pgo        Linux 2.4.18   847 3.541 8.2610  131.8
pgoipo     Linux 2.4.18   847 3.540 8.2710  131.8
pgoipo     Linux 2.4.18   847 3.540 8.2700  131.8
pgoipo     Linux 2.4.18   847 3.541 8.2610  131.8
inline     Linux 2.4.18   847 3.541 8.2610  131.8
inline     Linux 2.4.18   847 3.540 8.2610  131.8
inline     Linux 2.4.18   847 3.541 8.2700  131.8
gcc32      Linux 2.4.18   847 3.541   46.8  131.8
gcc32      Linux 2.4.18   847 3.541 8.2610  131.8
gcc32      Linux 2.4.18   847 3.540 8.2610  131.8

