Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbTDGVnV (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 17:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263696AbTDGVnV (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 17:43:21 -0400
Received: from mallard.mail.pas.earthlink.net ([207.217.120.48]:28839 "EHLO
	mallard.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S263695AbTDGVnL (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 17:43:11 -0400
Date: Mon, 7 Apr 2003 18:02:06 -0400
To: linux-kernel@vger.kernel.org
Subject: [benchmark] lmbench on 2 Linux and 3 Sun boxes
Message-ID: <20030407220206.GA23630@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just for fun...
5 machines ran lmbench 25 times.  Below is the average of the 25 runs.

linux-4x700 = Quad 700 mhz P3 Xeon 1 M cache, 4 GB ram running 2.4.19-rc1.
480r-2x900 = Sun V480 with 2GB ram, 2 900 mhz Ultrasparc III 8 Mb cache running Solaris 8
880r-8x750 = Sun V880 with 16 GB ram, 8 750 mhz Ultrasparc III 8 Mb cache running Solaris 8
e10k-12x333 = Sun E10000 with 12 GB ram and 12 333 mhz Ultrasparc II 4 Mb cache running Solaris 7 11/99.
s390-linux = Mainframe with 1 GB ram, 2 436 mhz CPUs running 2.4.9-37 (I think that's the right revision).

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
                null     null                       open    signal   signal   fork     exec    /bin/sh
kernel          call      I/O     stat    fstat    close   install   handle  process  process  process
------------  -------  -------  -------  -------  -------  -------  -------  -------  -------  -------
linux-4x700     0.499  0.88351    3.672    1.073    5.241    1.261    3.777    335.7   1030.8   4246.1
480r-2x900      0.805  3.36067    6.482    2.255    8.267    1.499   17.167   1368.9   4001.8   8203.9
880r-8x750      0.960  4.04983   10.374    2.892   14.304    1.795   20.654   1809.9   5425.9  10778.8
e10k-12x333     2.471  8.18372   34.726    7.412   52.539    4.340   53.203   4811.0  13563.5  30694.7
s390-linux      2.873  2.81517   61.169    3.981   69.761    6.146   20.782   1221.3   5510.5  21925.8

File select - times in microseconds - smaller is better
-------------------------------------------------------
               select   select   select   select   select   select   select   select
kernel          10 fd   100 fd   250 fd   500 fd   10 tcp  100 tcp  250 tcp  500 tcp
------------  -------  -------  -------  -------  -------  -------  -------  -------
linux-4x700     4.591   30.482   74.020  142.894    5.617   40.672   97.180   195.23
480r-2x900      8.584   65.730  161.389  338.983   12.371  100.656  249.271   519.16
880r-8x750     10.459   78.409  193.460  423.433   14.904  121.374  302.301  638.721
e10k-12x333    22.289  217.624  511.148 1043.836   29.461  284.463  689.844  1389.86
s390-linux     18.797   56.076  118.010  221.433   21.296  80.4670  194.125  343.976

Context switching with 0K - times in microseconds - smaller is better
---------------------------------------------------------------------
               2proc/0K   4proc/0K   8proc/0k  16proc/0k  32proc/0k  64proc/0k  96proc/0k
kernel        ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
------------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
linux-4x700       2.738      2.948      3.072      3.113      3.210      4.091      4.103
480r-2x900       10.677     11.826     13.100     14.299     14.651     15.081     15.365
880r-8x750       14.281     14.447     14.896     15.908     16.661     17.444     17.737
e10k-12x333      40.492     42.880     45.938     54.990     50.990     83.009     71.357
s390-linux       13.030     14.599     15.914     16.506     17.107     18.644     20.678

Context switching with 16K - times in microseconds - smaller is better
----------------------------------------------------------------------
              2proc/16k  4proc/16k  8proc/16k  16prc/16k  32prc/16k  64prc/16k  96prc/16k
kernel        ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
------------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
linux-4x700       8.740      8.737      8.843      8.971     12.380     11.624     15.522
480r-2x900       13.737     19.975     22.493     23.788     24.482     25.323     26.013
880r-8x750       15.039     15.588     23.702     27.266     29.002     31.079     32.333
e10k-12x333      66.257     70.736     85.141    118.717    103.736    109.087    105.873
s390-linux       12.875     23.420     24.712     25.695     28.848     38.603     45.975

Context switching with 32K - times in microseconds - smaller is better
----------------------------------------------------------------------
              2proc/32k  4proc/32k  8proc/32k  16prc/32k  32prc/32k  64prc/32k  96prc/32k
kernel        ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
------------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
linux-4x700      13.849     13.856     14.138     17.657     19.356     31.234     51.617
480r-2x900       18.365     28.298     32.059     33.466     34.127     35.884     37.808
880r-8x750       15.723     15.853     31.846     38.899     41.660     46.213     53.577
e10k-12x333     101.515    130.054    131.786    147.901    154.531    164.156    163.258
s390-linux       17.049     31.543     33.310     36.153     48.789     70.835     79.947

The 32, 64 and 96 process context switch test with 64k doesn't fit in the 1MB L2 cache on 
the quad Xeon.  

Context switching with 64K - times in microseconds - smaller is better
----------------------------------------------------------------------
              2proc/64k  4proc/64k  8proc/64k  16prc/64k  32prc/64k  64prc/64k  96prc/64k
kernel        ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch  ctx swtch
------------  ---------  ---------  ---------  ---------  ---------  ---------  ---------
linux-4x700      24.061     24.120     28.283     41.731     52.586    118.128    164.964
480r-2x900       25.748     47.277     51.813     53.133     54.428     68.155     85.570
880r-8x750       24.402     26.411     53.711     63.891     70.696     86.658    118.974
e10k-12x333     164.256    173.835    179.648    233.146    225.028    271.155    347.985
s390-linux       17.333     48.334     52.162     72.101    112.426    136.097    138.215

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
kernel         Pipe    AF/Unix    UDP    RPC/UDP    TCP    RPC/TCP  TCPconn
------------  -------  -------  -------  -------  -------  -------  -------
linux-4x700    10.798   25.656   38.617   59.390   43.524   77.583   85.024
480r-2x900     33.208   41.887   65.927  104.881   68.144  123.152  207.294
880r-8x750     37.138   49.319   77.186  125.514   82.725  148.831  260.240
e10k-12x333   105.968  139.294  203.185  308.967  231.860  354.566  568.435
s390-linux     51.910  121.889  111.409  172.958  125.973  194.822  406.810

File create/delete and VM system latencies in microseconds - smaller is better
----------------------------------------------------------------------------
                0K       0K       1K       1K       4K       4K      10K      10K     Mmap     Prot    Page
kernel        Create   Delete   Create   Delete   Create   Delete   Create   Delete   Latency  Fault   Fault
------------- -------  -------  -------  -------  -------  -------  -------  -------  -------  ------  ------
linux-4x700     87.09    26.61   135.74    47.37   136.81    47.46   210.80    57.77   2724.4   0.992    3.00
480r-2x900    1315.25   642.32  1419.43  1250.36  1417.62  1268.72  1848.71  1333.36  25125.2   3.708  511.78
880r-8x750     966.16   971.16  1268.35  1025.95  1264.14  1035.89  1303.68  1048.78  44715.1   4.883  581.21
e10k-12x333    423.47  2079.65  3792.09  2756.66  3868.43  2252.06  4324.28  2498.27  18678.3  12.631 7541.69
s390-linux     355.18   174.77   603.53   276.96   676.36   276.41   947.89   348.36  52840.0   0.000   34.65

The libc bcopy test uses 8 MB looks good on the 2x900 with 8 MB cache, though
that test is meant to outsize the CPU cache.

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
                                          File     Mmap    Bcopy    Bcopy    Memory   Memory
kernel         Pipe    AF/Unix    TCP    reread   reread   (libc)   (hand)    read     write
------------  -------  -------  -------  -------  -------  -------  -------  -------  -------
linux-4x700    471.04   273.62   173.77   303.08   366.12   162.03   162.02   366.07   215.19
480r-2x900     188.86   370.31   434.11   303.21   244.52   871.46   143.79   244.50   261.55
880r-8x750     121.75   156.51   216.60   164.61   232.61   228.70   120.31   229.55   217.12
e10k-12x333     41.96    86.76   128.62    50.30    92.73   160.55    52.87    92.74   103.44
s390-linux     112.04   220.51   210.60   248.57   424.61   276.53   231.94   433.11   341.18

Memory latencies in nanoseconds - smaller is better
--------------------------------------
kernel         Mhz     L1 $     L2 $    Main mem
------------  -----  -------  -------  ---------
linux-4x700     698    4.301   12.906     163.69
480r-2x900      900    2.222   14.662     194.10
880r-8x750      749    2.671   17.645     238.13
e10k-12x333     333    6.009   30.332     564.98
s390-linux      436    6.839    6.858     211.43
-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

