Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264852AbTFQRNW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 13:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264854AbTFQRNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 13:13:21 -0400
Received: from franka.aracnet.com ([216.99.193.44]:44993 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264852AbTFQRNI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 13:13:08 -0400
Date: Tue, 17 Jun 2003 10:26:57 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 817] New: Receiving "Bus master arbitration failure, status ffff" error
Message-ID: <33960000.1055870817@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Receiving "Bus master arbitration failure, status ffff"
                    error
    Kernel Version: 2.5.72
            Status: NEW
          Severity: normal
             Owner: jgarzik@pobox.com
         Submitter: robbiew@us.ibm.com
                CC: sglass@us.ibm.com


Distribution: SuSE 8.0

Hardware Environment:
---------------------
vega:~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 702.103
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1380.35

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 702.103
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1396.73

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 702.103
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1396.73

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 702.103
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1400.83

vega:~ # cat /proc/meminfo
MemTotal:      4305168 kB
MemFree:        552256 kB
Buffers:        288532 kB
Cached:        3212108 kB
SwapCached:          0 kB
Active:         328008 kB
Inactive:      3179916 kB
HighTotal:     3440612 kB
HighFree:       218816 kB
LowTotal:       864556 kB
LowFree:        333440 kB
SwapTotal:     2097136 kB
SwapFree:      2097136 kB
Dirty:           25028 kB
Writeback:           0 kB
Mapped:          10540 kB
Slab:           165396 kB
Committed_AS:    21932 kB
PageTables:        360 kB
VmallocTotal:   114680 kB
VmallocUsed:      2188 kB
VmallocChunk:   112492 kB
vega:~ # lspci
00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 21)
00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
00:00.2 Host bridge: ServerWorks: Unknown device 0006
00:00.3 Host bridge: ServerWorks: Unknown device 0006
00:05.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] 
(rev 44)
00:06.0 VGA compatible controller: S3 Inc. Savage 4 (rev 04)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 04)
02:01.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
02:01.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
05:02.0 Ethernet controller: National Semiconductor Corporation DP83815 
(MacPhyter) Ethernet Controller
---------------------

Software Environment:
---------------------
*Using the pcnet32 driver, which is built into the kernel.
Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      2.4.12
e2fsprogs              1.26
jfsutils               1.0.15
xfsprogs               2.0.0
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        x    1 root     root      1394238 Mar 23  
2002 /lib/libc.so.6
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
No Modules Loaded
------------------------

Problem Description: 
While attempting to perform some NFS testing, the error msg, "Bus master 
arbitration failure, status ffff" is repeatedly printed to the console and 
eventually the machine hangs up.  An 'ifconfig' of the ethernet card shows the 
number of receive and transmit errors increasing.  I installed another ethernet 
card (netsemi driver) and the message, along with the received/transmitt 
errors, stopped.

Steps to reproduce:
Execute the test scenario defined at http://ltp.sf.net/nfs.


