Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135810AbREGJvR>; Mon, 7 May 2001 05:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136072AbREGJvH>; Mon, 7 May 2001 05:51:07 -0400
Received: from suhkur.cc.ioc.ee ([193.40.251.100]:10394 "EHLO cc.ioc.ee")
	by vger.kernel.org with ESMTP id <S136069AbREGJut>;
	Mon, 7 May 2001 05:50:49 -0400
Date: Mon, 7 May 2001 11:50:46 +0200 (GMT)
From: Juhan-Peep Ernits <juhan@cc.ioc.ee>
To: linux-kernel@vger.kernel.org
Subject: what causes Machine Check exception? revisited (2.2.18)
Message-ID: <Pine.GSO.4.21.0105071127100.20861-100000@suhkur.cc.ioc.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

After searching the archives of the list I found some similar reports
from September and December 2000 but as far as I understood the cause of
the error was blamed on the CPU. Is this the most probable case? 

Best regards,

Juhan Ernits

	-- /var/log/kern.log

May  6 06:47:25 market kernel: CPU 0: Machine Check 
Exception: 0000000000000004
May  6 06:47:25 market kernel: Bank 4: b200000000040151<0>Kernel
panic: CPU context corrupt


	-- /proc/cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 1
cpu MHz         : 551.259
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat pse36 mmx fxsr xmm
bogomips        : 1101.00



	-- /var/log/dmesg


Linux version 2.2.18 (root@market.equitygate.com) (gcc version 2.95.2
20000220 (Debian GNU/Linux)) #6 Mon Jan 15 15:52:09 EET 2001
Detected 551259 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1101.00 BogoMIPS
Memory: 517620k/524288k available (776k kernel code, 416k reserved, 5440k
data, 36k init)
Dentry hash table entries: 65536 (order 7, 512k)
Buffer cache hash table entries: 524288 (order 9, 2048k)
Page cache hash table entries: 131072 (order 7, 512k)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
256K L2 cache (8 way)
CPU: L2 Cache: 256K
CPU: Intel Pentium III (Coppermine) stepping 01
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xfb2a0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 524288 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5 
pty: 2048 Unix98 ptys configured
Real Time Clock Driver v1.09
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
scsi0 : IBM PCI ServeRAID 4.20.20  <ServeRAID 3L>
scsi : 1 host.
  Vendor:  IBM      Model:  SERVERAID        Rev:  1.0
  Type:   Direct-Access                      ANSI SCSI revision: 01
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor:  IBM      Model:  SERVERAID        Rev:  1.0
  Type:   Processor                          ANSI SCSI revision: 01
scsi : detected 1 SCSI disk total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 35860480 [17510 MB]
[17.5 GB]
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey
V. Savochkin <saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com>
2000/11/15
eth0: Intel PCI EtherExpress Pro100 82557, 00:D0:B7:16:9E:E2, IRQ 11.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 721383-008, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey
V. Savochkin <saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com>
2000/11/15
Partition check:
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 > sda4
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.13)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 36k freed
Adding Swap: 64004k swap-space (priority -1)
Adding Swap: 135976k swap-space (priority -2)
Adding Swap: 135976k swap-space (priority -3)
Adding Swap: 135976k swap-space (priority -4)
Adding Swap: 135976k swap-space (priority -5)




