Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRA2UdE>; Mon, 29 Jan 2001 15:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129175AbRA2Ucx>; Mon, 29 Jan 2001 15:32:53 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:61706 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129143AbRA2Ucl>; Mon, 29 Jan 2001 15:32:41 -0500
Date: Mon, 29 Jan 2001 14:27:23 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: [ANNOUNCE] Dolphin PCI-SCI RPM Drivers 1.1-4 released
Message-ID: <20010129142723.A14086@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii



Linux Kernel,

The RPM versions of the Dolphin PCI-SCI (Scalable Coherent Interface) 
adapter drivers have posted at vger.timpanogas.org/sci.  This release
supports the following SCI Adapters, PSB32, PSB64, and PSB66.  This 
version supports the 32-bit and 64-bit PCI versions of the Dolphin
PCI-SCI Adapters.  This RPM version supports i386, Alpha, Sparc, and
Sparc64 architecture systems.  

SCI is a high performance clustering interconnect fabric that allows 
a Linux system to perform push/pull DMA transfers of mapped regions 
of memory (such as a distributed cache) between nodes either via 
DMA or via remotely mapping R/W memory access to pages of memory 
in another cluster node.  This version of the adapters supports 
a scalable fabric on bi-CMOS chipsets that operates with a 
maximum data transfer rate of 500 Megabytes/second.  Obviously,
PCI bandwidth limits how much throughput you can actually get 
on a Live Linux System.  On an AMD Ahtalon 550Mhz System, we are
seeing @ 65 Megabytes/second with DMA and @ 45 Megabytes/second 
throughput with Memory copying between nodes with this 
version of the drivers/adapters.

Linux 2.2 vs. 2.4 performance is telling, with Linux 2.4 clearly 
providing significantly higher performance for NUMA 
operations with the Dolphin PCI-SCI adapters.   Please review 
the attached performance figures below for a comparison.

This release has removed the requirement for the bighysparea patch
for these drivers.  This package will allow these drivers to run 
on any "shrink-wrapped" Linux versions.  We have also packaged these
drivers in both tar.gz and RPM format, and a source RPM is provided
under the GNU Public License which will allow these drivers to be 
easily included into any commercial Linux Distributions that use
RPM.  We have tested this RPM package on RedHat, Suse, Caldera, 
and Ute Linux.  

This release has been tested and 2.4 Linux kernel enabled, and fully 
supports Linux kernel 2.4.  This release corrects several bugs 
and level I Oops on Linux 2.4 kernels with previous versions.   

Please feel feel to post any bugs or problems with these drivers to 
linux-kernel@vger.kernel.org or report them to jmerkey@timpanogas.org. 
I will be maintaining the RPM release of the Dolphin PCI-SCI drivers,
so please direct and reports to me and I will forward them onto
Dolphin ICS if they are related to hardware bugs.   For additional
useful information about SCI, please visit Dolphin's website
at www.dolphinics.com.

The next release of these drivers will contain a fast-path sockets 
and TCPIP interface to allow IP routing and support for LVS and 
distrbuted NUMA support for the M2FS Clustered File System on the 
Dolphin Adapters.   

Jeff Merkey
Chief Engineer, TRG



--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux22-1.sci"


Linux 2.2.18 Performance Benchmarks
------------------------------------

 /opt/DIS/bin/dma_bench program compiled Jan 28 2001 : 23:43:03

Test parameters for client 
----------------------------

Local nodeId      : 8
Remote nodeId     : 4
Local adapter no. : 0
Block size        : 65536
Loops to execute  : 3
ILoops to execute : 1000
Key Offset        : 0
Direction	  : PUSH
----------------------------

Local segment (id=0x80400, size=65536) is created. 
Local segment (id=0x80400, size=65536) is created. 
Local segment (id=0x80400) is mapped to user space.
Trying to connect to remote segment (id=0x40800) at node 4
Remote segment (id=0x40800) is connected.

-- Starting the data transfer -- 


----------------------------------------------------
Segment size:	Latency:		Throughput:
----------------------------------------------------
64		    112.00 us		    0.57 MBytes/s
128		    113.00 us		    1.13 MBytes/s
256		    115.00 us		    2.23 MBytes/s
512		    120.00 us		    4.27 MBytes/s
1024		    130.00 us		    7.88 MBytes/s
2048		    150.00 us		   13.65 MBytes/s
4096		    188.00 us		   21.79 MBytes/s
8192		    266.00 us		   30.80 MBytes/s
16384		    423.00 us		   38.73 MBytes/s
32768		    758.00 us		   43.23 MBytes/s
65536		   1440.00 us		   45.51 MBytes/s
----------------------------------------------------
Segment size:	Latency:		Throughput:
----------------------------------------------------
64		    112.00 us		    0.57 MBytes/s
128		    113.00 us		    1.13 MBytes/s
256		    115.00 us		    2.23 MBytes/s
512		    120.00 us		    4.27 MBytes/s
1024		    130.00 us		    7.88 MBytes/s
2048		    150.00 us		   13.65 MBytes/s
4096		    188.00 us		   21.79 MBytes/s
8192		    266.00 us		   30.80 MBytes/s
16384		    423.00 us		   38.73 MBytes/s
32768		    758.00 us		   43.23 MBytes/s
65536		   1439.00 us		   45.54 MBytes/s
----------------------------------------------------
Segment size:	Latency:		Throughput:
----------------------------------------------------
64		    112.00 us		    0.57 MBytes/s
128		    112.00 us		    1.14 MBytes/s
256		    115.00 us		    2.23 MBytes/s
512		    120.00 us		    4.27 MBytes/s
1024		    129.00 us		    7.94 MBytes/s
2048		    150.00 us		   13.65 MBytes/s
4096		    188.00 us		   21.79 MBytes/s
8192		    266.00 us		   30.80 MBytes/s
16384		    423.00 us		   38.73 MBytes/s
32768		    758.00 us		   43.23 MBytes/s
65536		   1439.00 us		   45.54 MBytes/s
Node 8 triggering interrupt

Interrupt message sent to remote node

DMA transfer done!
The segment is disconnected
The local segment is unmapped
The local segment is removed

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux24-1.sci"


Linux 2.4.0 Performance Benchmarks
------------------------------------

 /opt/DIS/bin/dma_bench program compiled Jan 28 2001 : 22:41:53

Test parameters for client 
----------------------------

Local nodeId      : 4
Remote nodeId     : 8
Local adapter no. : 0
Block size        : 65536
Loops to execute  : 3
ILoops to execute : 1000
Key Offset        : 0
Direction	  : PUSH
----------------------------

Local segment (id=0x40800, size=65536) is created. 
Local segment (id=0x40800, size=65536) is created. 
Local segment (id=0x40800) is mapped to user space.
Trying to connect to remote segment (id=0x80400) at node 8
Remote segment (id=0x80400) is connected.

-- Starting the data transfer -- 


----------------------------------------------------
Segment size:	Latency:		Throughput:
----------------------------------------------------
64		     52.00 us		    1.23 MBytes/s
128		     52.00 us		    2.46 MBytes/s
256		     54.00 us		    4.74 MBytes/s
512		     58.00 us		    8.83 MBytes/s
1024		     65.00 us		   15.75 MBytes/s
2048		     80.00 us		   25.60 MBytes/s
4096		    110.00 us		   37.24 MBytes/s
8192		    170.00 us		   48.19 MBytes/s
16384		    290.00 us		   56.50 MBytes/s
32768		    532.00 us		   61.59 MBytes/s
65536		   1009.00 us		   64.95 MBytes/s
----------------------------------------------------
Segment size:	Latency:		Throughput:
----------------------------------------------------
64		     52.00 us		    1.23 MBytes/s
128		     52.00 us		    2.46 MBytes/s
256		     54.00 us		    4.74 MBytes/s
512		     58.00 us		    8.83 MBytes/s
1024		     65.00 us		   15.75 MBytes/s
2048		     80.00 us		   25.60 MBytes/s
4096		    110.00 us		   37.24 MBytes/s
8192		    170.00 us		   48.19 MBytes/s
16384		    290.00 us		   56.50 MBytes/s
32768		    531.00 us		   61.71 MBytes/s
65536		   1011.00 us		   64.82 MBytes/s
----------------------------------------------------
Segment size:	Latency:		Throughput:
----------------------------------------------------
64		     52.00 us		    1.23 MBytes/s
128		     52.00 us		    2.46 MBytes/s
256		     54.00 us		    4.74 MBytes/s
512		     58.00 us		    8.83 MBytes/s
1024		     65.00 us		   15.75 MBytes/s
2048		     80.00 us		   25.60 MBytes/s
4096		    110.00 us		   37.24 MBytes/s
8192		    170.00 us		   48.19 MBytes/s
16384		    290.00 us		   56.50 MBytes/s
32768		    532.00 us		   61.59 MBytes/s
65536		   1012.00 us		   64.76 MBytes/s
Node 4 triggering interrupt

Interrupt message sent to remote node

DMA transfer done!
The segment is disconnected
The local segment is unmapped
The local segment is removed

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=NOTES


Copyright (c) 1990-2001 Dolphin Interconnect Solutions, Inc.
All Rights Reserved.


RPM (RedHat Package Manager) installation notes for DIS PCI-SCI Adapters 
------------------------------------------------------------------------

This release contains the Dolphin PCI-SCI adapter drivers for the PSB32, 
PSB64, and PSB66 adapters in RPM (RedHat Package Manager) package 
format.  

These packages are built using the RPM build utility.  The RPM format
is 3.04, and is compatible with RPM versions 3 and versions 4.  RPM
packages are provided in both source (.src.rpm) and binary forms
(.i386.rpm, .alpha.rpm, etc.).  A binary RPM package contains the
drivers and driver installation scripts needed to install or 
remove a version of the PCI-SCI drivers from your Linux systems.

The source RPM package contains the source code and build scripts
needed to rebuild the binary RPM packages for a target system. If 
you are using modversioned kernels, you will need to rebuild the 
binary packages for your system against the source RPM package.

All commercial Linux distributions use the RPM tools to administer 
packages and verify dependencies and version matches required to 
support a particular package.  If you are using a system that does 
not support RPM, please visit Dolphin's Website at www.dolphinics.com
for a copy of the latest .tar.gz or tar version of the PCI-SCI 
drivers for your Unix or Linux system.  

This release consists of the following RPM packages note: %{version} is the 
RPM package version release number:

RPM source package:

pci-sci-%{version}.src.rpm

RPM binary packages:

Intel X86:

pci-sci-PSB32-%{version}.i386.rpm
pci-sci-PSB64-%{version}.i386.rpm
pci-sci-PSB66-%{version}.i386.rpm

Sparc:

pci-sci-PSB32-%{version}.sparc.rpm
pci-sci-PSB64-%{version}.sparc.rpm
pci-sci-PSB66-%{version}.sparc.rpm
pci-sci-PSB32-%{version}.sparc64.rpm
pci-sci-PSB64-%{version}.sparc64.rpm
pci-sci-PSB66-%{version}.sparc64.rpm

Alpha:

pci-sci-PSB32-%{version}.alpha.rpm
pci-sci-PSB64-%{version}.alpha.rpm
pci-sci-PSB66-%{version}.alpha.rpm


Installing RPM source and binary packages
-----------------------------------------

It is recommended that you rebuild the .src.rpm if you are using a kernel
build with modversions enabled, and install the binary RPM packages created
from this build.  You must have a valid and properly configured 
kernel build sources tree located in the /usr/src/linux directory 
on your system in order to rebuild the PCI-SCI drivers.  Please consult 
the /usr/src/Linux/Documentation directory or the /usr/src/Linux/README 
file for specific instructions on setting up your kernel build tree.

To rebuild a source RPM on a target system, enter the following command:

rpm --rebuild pci-sci-%{version}.src.rpm 

This command will install the source files into the RPM build tree 
on your system and rebuild all the binary packages.  This tree is always 
found at /usr/src/($distribution)/ and contains BUILD, SOURCES, 
SPECS, SRPMS, and RPMS subdirectories. ($distribution) is the name of 
your Linux distribution.  For example, if your Linux distribution is 
Red Hat, then this directory would be located at /usr/src/redhat/.  
If your distribution is Caldera Linux, the this directory would be 
located at /usr/src/OpenLinux/.  It's a good idea to simply list 
the contents of /usr/src/ to locate your particular RPM build tree
for your commercial Linux distribution. 

The recompiled binary RPM packages will be found after the build 
finishes at /usr/src/($distribution)/RPMS/($arch).  ($arch) is 
the architecture of the system on which you are building.  If you 
are rebuilding the source RPM package on an Intel System on 
RedHat 6.2, then this directory would be /usr/src/redhat/RPMS/i386.
If you are rebuilding the source RPM package on an Alpha System on 
RedHat 6.2, then this directory would be /usr/src/redhat/RPMS/alpha.

To install either the pre-built or the rebuilt RPM binary packages
simply type the following command dpending on which PCI-SCI adapter 
is in your system (PSB32, PSB64, PSB66):

rpm -i pci-sci-PSB64-%{version}.i386.rpm

You can also force RPM to overwrite previously installed versions 
of the pci-sci drivers with this command:

rpm -i --force pci-sci-PSB64-%{version}.i386.rpm

You should see several messages on the system console detailing 
the progress of the PCI-SCI driver installtion.  They should
look something like this:

#
#
# rpm -i pci-sci-PSB64-1.0-1.i386.rpm
pci-sci reports this system has 1 processor(s) (LINUX)
Installing Dolphin PCI-SCI adapter drivers ...
Command:add
Adapter:PSB64
SMP: NOSMP
Creating /etc/rc.d/init.d/sci_irm_sisci for PSB64-2.2.18-27-NOSMP
Reading IRM driver configuration informaiton from /opt/DIS-1.0/sbin/..//lib/modules/pcisci.conf

Done.
#
#

The /var/log/messages file should also contain entries similiar to the 
following if your SCI hardware initialized properly:

Jan 24 22:37:52 nwfs kernel: SCI Driver : Linux SMP support disabled 
Jan 24 22:37:52 nwfs kernel: SCI Driver : using MTRR 
Jan 24 22:37:52 nwfs kernel: PCI SCI Bridge - device id 0xd665 found 
Jan 24 22:37:52 nwfs kernel: 1 supported PCI-SCI bridges (PSB's) found on the system 
Jan 24 22:37:52 nwfs kernel: Define PSB 1 key: Bus:  0 DevFn: 72 
Jan 24 22:37:52 nwfs kernel: Key 1: Key: (Bus:  0,DevFn: 72), Device No. 1, irq 9 
Jan 24 22:37:52 nwfs kernel: Mapping address space CSR space: phaddr f3100000 sz 32768 out of 32768 
Jan 24 22:37:52 nwfs kernel: Mapping address space CSR space: vaddr c40ae000 
Jan 24 22:37:52 nwfs kernel: Mapping address space IO space: phaddr d0000000 sz 268435456 out of 268435456 
Jan 24 22:37:52 nwfs kernel: Mapping address space IO space: vaddr c40b7000 
Jan 24 22:37:52 nwfs kernel: SCI Driver : version Dolphin IRM 1.10.2 ( Beta 1 2000-12-18 ) initializing 
Jan 24 22:37:52 nwfs kernel: SCI Driver : 32 bit mode Compiled Jan 24 2001 : 22:35:50 
Jan 24 22:37:52 nwfs kernel: Interrupt 9 function registered 
Jan 24 22:37:52 nwfs kernel: SCI Adapter 0 : Driver attaching 
Jan 24 22:37:52 nwfs kernel: osif_big_alloc 8192 align 0 <NULL> 
Jan 24 22:37:52 nwfs kernel: osif_big_alloc 65792 align 0 SW packet buffers 
Jan 24 22:37:52 nwfs kernel: SCI Adapter 0 : NodeId is 4 ( 0x4 ) Serial no : 100963 (0x18a63) 
Jan 24 22:37:52 nwfs kernel: osif_big_alloc 8192 align 2 ma_allocBuffer 
Jan 24 22:37:52 nwfs kernel: osif_big_alloc 520700 align 0 MbxMsgQueueDescArray 
Jan 24 22:37:52 nwfs kernel: osif_big_alloc 8192 align 2 ma_allocBuffer 
Jan 24 22:37:52 nwfs kernel: SCI driver : successfully registerd. Major number = 254 


Removing and Querying RPM packages
----------------------------------

To remove the PCI-SCI drivers from your system, enter the following 
command with the proper adapter type installed in your system:

rpm -e pci-sci-PSB64

Messages similiar to the following should be displayed on the system
console.

#
#
# rpm -e pci-sci-PSB64
pci-sci reports this system has 1 processor(s) (LINUX)
Command:rem
Adapter:PSB64
SMP: NOSMP
Removing the IRM and SISCI drivers from the system
Removing SCI device nodes and unloading drivers
Done.
#
#

The /var/log/messages file should also contain entries similiar to the 
following if your SCI hardware shutdown properly:

Jan 24 22:38:03 nwfs kernel: osif_big_free 8192 ma_allocBuffer 
Jan 24 22:38:03 nwfs kernel: osif_big_free 520700 MbxMsgQueueDescArray 
Jan 24 22:38:03 nwfs kernel: osif_big_free 8192 ma_allocBuffer 
Jan 24 22:38:04 nwfs kernel: osif_big_free 65792 SW packet buffers 
Jan 24 22:38:04 nwfs kernel: osif_big_free 8192 <NULL> 
Jan 24 22:38:04 nwfs kernel: SCI Adapter 0 : Adapter terminated 
Jan 24 22:38:04 nwfs kernel: SCI Driver : version Dolphin IRM 1.10.2 ( Beta 1 2000-12-18 ) terminating 
Jan 24 22:38:04 nwfs kernel: Trying to free free IRQ9 


Querying RPM information
------------------------

If you need to query whether the RPM packages have been installed or 
not in your system, type the following command:
  
rpm -q pci-sci-PSB64

This should produce output similiar to the following:

#
#
# rpm -q pci-sci-PSB64
pci-sci-PSB64-1.0-1
#
#

Additional useful information concerning the options and versions of 
the RPM tools can be found by visiting the RPM website at www.rpm.org 
or by typing 'info rpm' or 'man rpm' from your system console.  The 
man and info listing on RPM contains detailed information about 
using the RPM tools.

rpm --help | more

will also provide additional information about querying RPM options
that are available.

Rebuilding the RPM from the pci-sci-%{version}.spec file
-------------------------------------

If you want to rebuild your .src.rpm and binary rpm packages from 
the RPM build tree, then you can change directory (cd) into the 
/usr/src/$(distribution)/SPECS directory.  This directory will 
contain the rpm .spec files for any installed .src.rpm packages
either installed via rpm -i <rpm name>.src.rpm command or the 
rpm --rebuild <rpm name>.src.rpm command.  An RPM spec file is 
a file containing install scripts and build instructions for 
an RPM package or set of packages, along with versioning and 
dependecy information.

To rebuild the PCI-SCI drivers from the SPECS directory, type
the following command:

rpm -ba pci-sci.spec

This command will trigger complete rebuild of the .src.rpm and 
binary rpms for the PCI-SCI package.


Increasing the Number of SCI Nodes Supported
--------------------------------------------

This version of the PCI-SCI adapters will support up to 256 
clustered SCI nodes.  To increase the number of nodes supported,
you will need to change the following line in the 
/src/IRM/drv/src/id.h file, line 36 contained in the pci-sci-1.1.tar.gz 
file contained in the source RPM.  This file will normally be 
located in the /usr/src/$(distribution)/SOURCES directory.

#define          MAX_NODE_IDS        256  

This value can be increased up to 1024 nodes.  Increasing this value 
will also increase the amount of memory needed to setup the SCI 
mbx structures from 130K to 520K.  


--45Z9DzgjV8m4Oswq--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
