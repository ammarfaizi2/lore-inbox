Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284019AbRLAJ2c>; Sat, 1 Dec 2001 04:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284020AbRLAJ2X>; Sat, 1 Dec 2001 04:28:23 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:22408 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S284021AbRLAJ2H>; Sat, 1 Dec 2001 04:28:07 -0500
Date: Sat, 1 Dec 2001 02:32:24 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: [ANNOUNCE] PCI-SCI Drivers (RPM and tar.gz) v1.13 Released
Message-ID: <20011201023224.A18232@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



The Dolphin PCI-SCI (Scalable Coherent Interface) Drivers v1.13 
High Speed Interconnect Drivers have been posted at:

ftp.timpanogas.org:/sci 
ftp.utah-nac.org:/sci
ftp.kernel.org:/pub/linux/kernel/people/jmerkey/sci

These drivers are released under the GPL and are posted in 
Red Hat Package Manager (RPM) and tar.gz formats.  This release
has been tested and is current as of Linux Kernels 2.5.0 and 
Linux Kernels 2.4.17.  This version of the drivers has also 
been tested against Red hat 7.1/7.2 Distributions.

The Dolphin PCI-SCI Interconnect adapters are used in 
high-performance supercomputing environments and very 
large Linux clusters.

Jeff Merkey



--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=SCI_RELEASE



SCI Adapter Driver Changes and Bug Fixes
----------------------------------------

IRM 1.10.12 ( 3rd August 2001 )
*Linux: Added property (set_prefetch_space_size) to set prefetch space
 size with only CSR mapped ( only D33x support ).
*2D Torus support reduced to 14x14, Added support for D330/D333
 connection to 2D Torus topology.


IRM 1.10.13 ( 13th August 2001 )
*Linux: Added property (set_prefetch_space_size) to set prefetch space
 size with only CSR mapped ( only D33x support ).
*2D Torus support reduced to 14x14, Added support for D330/D333
 connection to 2D Torus topology.
*Improved automatic SCI topology detection and handling (D33x only).
*Added a number of new map attributes.


IRM 1.10.14  ( 29th August 2001 ) 
DISsp_1_9
*Linux:Fixed bogous MTRR setting introduced in IRM 1.10.13 causing low
 performance.
*Set default maximum prefetch space to 448MB. 
*Added support for Intel 810, 810 DC100, 850 and 860  hostbridge.
*Added support for VIA KX133 and KT133 hostbridge.
*Fixed bug in identifying nonidentified hostbridge
*Fixed bug sciconfig utility command line handling. Configuration info improved.

IRM 1.10.15  ( 13th September 2001 ) 
DISsp_1_10
*Fixed syntax error in hostbridge declaration for SOLARIS introduced in IRM 1.10.14.
*Added support for Intel 810E hostbridge.
*Added genif function to get local ioaddress of remote segment 
*Linux:Implemented ConnectSCISpace
*Clined up map flag restrictions in sci_map_segments().


IRM 1.10.16  ( 12th October 2001 ) 
DISsp_1_11
*Fixed Timer problem on Lynxos ( Thanks to Jose Ameida ) Gnats #1329
*Fixed DMA problem for PowerPC / PSB66. Gnats #1056
*Fixed Lynx 3.1/3.0.1 compile problem. Gnats 1151
*Added partial support for Linux / Itanium architecture.
 ( Thanks to Sebastien Decugis ) Gnats #1340
*removed a number of warnings caused by #ifdef COMMENT. Gnats #1179
*LYNX: Added option to set timer/interrupt task priority. (Thanks to
 C. Rabourg, GACI.) Gnats #1344   
*VxWorks: Fixed bug in osif_delay() causing to long delays (low DMA
 perormance). GNATS #1346
*Added better support for cross compilation. Gnats #1317
*VxWorks: Fixed bug in interrupt handling for x86. Enhanced 
 create binary package scripts. Gnats #1317
*PSB66: Default number of map entries set to 8k ( up from 4k ). Gnats #1347
*Added prototype of new ISPtool for D33x base cards. Gnats #1351


IRM 1.10.17 ( 19th October 2001 )
DISsp_1_12
*PSB66: Fixed problem to use 16 MB prefetchspace. Introduced in IRM 1.10.16. 
 Gnats #1355
*Enhanced VxWorks create binary package scripts and documentation.
 Added info about how to cross compile. Gnats #1317
*PSB66: Added code to increase B-Link frequency to 80 MHz. 50 MHz is
 default using D33x PLD rev 02. Gnats #1354
*D338: Subsystem ID changed from 0x1200 to 0x0080. Gnats #1353
*Added support for user defined routing tables. Gnats #1337
*D33x: Added Unix make files for new isptool. Gnats #1351
*Fixed initialization problems of the IRM running 2D-mesh configuration on SPARC. Gnats #1356


IRM 1.10.18  ( 24th October 2001 ) 
DISsp_1_13
*Added proper implementation of nonblocking barrier function. (Not
 enabled by default). Gnats #1358
*Fixed bug in D320 support introduced in IRM 1.10.17. Gnats #1356
*Added property to enable/disable trid colorig for D32x and D33x. Gnats #1359
*fixed broken #endif <NAME> statements with gcc 2.96

IRM 1.10.18-1 ( 30th November 2001 )
*updated Linux 2.4.17 slab.h inclusion
*updated pci-sci-1.13 RPM build scripts
*fixed broken drv-install initialization scripts
*updated/tested to Linux kernels 2.4.17 and 2.5.1
*updated/tested to RedHat 7.1/7.2 
*fixed broken build_IRM script SMP auto-detection  code

SCI Kernel API Changes and Bug Fixes
-------------------------------------

SISCI 1.10.12 ( 3rd August 2001 )
*Added program to initialize a remote node over SCI.
*Added new flags to SCIMapRemoteSegment to cover all ATT options.
*Added new SISCI function SCIAttachPhysicalMemory(). 
*Solaris:Fixed SCIConnectSciSpace() implementation.
*Added SISCI query to get physical pci bus address of local segment.  

SISCI 1.10.13 ( 13th August 2001 )
*Added a number of new map attributes to SCIMapRemoteSegment()

SISCI 1.10.14 ( 29th August 2001 )
*Fixed bug in atomic lock operations introduced in SISCI 1.10.13
*Introduced new general timing functions for test applications.
*Added support for Intel 810/810E, 850 and 860  hostbridge.
*Added support for VIA KX133 and KT133 hostbridge.
*Added new SISCI utility to set remote prefetch memory space size.
*Fixed bug in SCIMapLocal/RemoteSegment with offset (Thanks to Joachim Worringen) 

SISCI 1.10.15 ( 13th Septermber 2001 )
*Removed check for processor speed > 1000 Mhz in the test timer library - Gnats #1312
*Linux:Fixed SCIConnectSciSpace implementation
*Added new query to get local ioaddress of remote segment.
*Added new sisci example (querysegmen) to demonstrate the use of 
 get ioaddress of both local and remote segments.
*Fixed -pull problem in scibench2.
*Fixed mapRemoteSegment problem handling new flags

SISCI 1.10.16 ( 12th October 2001 )
DISsp_1_11
*UNIX: Added check to make sure file descriptor resources are not
 reused. Gnats #1339 
*Fixed various Lynx compile, and runtime errors. Gnats #1330
*Added Lynx 3.1 support. Gnats #1151
*Added partial support for Linux / Itanium architecture.
 ( Thanks to Sebastien Decugis ) Gnats #1340
*Added optimized SCIMemCopy() function for LynxOS / PPC Gnats #1341
*removed a number of warnings caused by #ifdef COMMENT etc. Gnats #1179
*Added support for *.S files in make system. Gnats #1341
*Lynx: Fixed bug in wait_for_event(). (Thanks to C. Rabourg, GACI.)
 Gnats #1345
*Fixed bug in shmem SISCI example handling large segments. Gnats #1343
*Lynx: added proper getpid() 
*Fixed problem to clean up internal map resources causing an
 application to fail to reuse file descriptors. This problem applies to
 all non windows operating systems. Gnats #1348
  
SISCI 1.10.17 ( 19th October 2001 )
DISsp_1_12
*Added fix in dma_bench and scibench2 for multi VxWorks applications. Gnats #1357 

SISCI 1.10.18 ( 24th October 2001 )
DISsp_1_13
*Added support for multiple adapters in sisci example query.c.

SISCI 1.10.18-1 ( 30th November 2001 )
* fixed dmatest2.c localtime() type cast error
* fixed dma_bench.c localtime() type cast error
* fixed broken build_SISCI script SMP auto-detection code


--tKW2IUtsqtDRztdT--
