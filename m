Return-Path: <linux-kernel-owner+w=401wt.eu-S965158AbXATIIw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbXATIIw (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 03:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbXATIIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 03:08:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:13281 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965158AbXATIIu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 03:08:50 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id:from;
        b=VErAS13xRr1vFYNIy8kzyM6njPMlGuVIcf5RCRrhSQCUMDh6gsHaPJcwfB5QrHxQi2Do9ADTO6RVu1Zqye5yF7Tjd/ZkNYx6WlTNRsFS6Pihg/tkm+2aNsIjs4Md0lXVRhfCDKxTOjndwLGa7wayPyzkPCHjPT8AI09pFJMRuY4=
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: KB->KiB, MB -> MiB, ... (IEC 60027-2)
Date: Sat, 20 Jan 2007 09:08:47 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701200908.47654.Michal.Kudla@gmail.com>
From: =?utf-8?q?Micha=C5=82_Kud=C5=82a?= <michal.kudla@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
according to  http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html
[1.] One line summary of the problem: 
KB->KiB, MB -> MiB, ... (IEC 60027-2 Letter symbols to be used in electrical 
technology – Part 2)
[2.] Full description of the problem/report:
kernel: 2.6.19
linux: gentoo

after 
#dmesg
I find somethings like it

Memory: 515992k/524224k available (1909k kernel code, 7684k reserved, 768k 
data, 172k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
    vmalloc : 0xe0800000 - 0xfffb5000   ( 503 MB)
    lowmem  : 0xc0000000 - 0xdfff0000   ( 511 MB)
      .init : 0xc03a0000 - 0xc03cb000   ( 172 kB)
      .data : 0xc02dd6d6 - 0xc039d8f4   ( 768 kB)
      .text : 0xc0100000 - 0xc02dd6d6   (1909 kB)
...
hdb: max request size: 512KiB
hdb: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63, 
UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(66)


Should be everywere KiB, MiB, GiB, ... according to IEC 60027-2 

http://www.iec.ch/zone/si/si_bytes.htm
http://en.wikipedia.org/wiki/Kibibyte

[3.] Keywords (i.e., modules, networking, kernel):
modules, networking, kernel,... everywere
[4.] Kernel version (from /proc/version):
Linux version 2.6.19-gentoo-r4 (root@athlonik) (gcc version 4.1.1 (Gentoo 
4.1.1-r3)) #1 Fri Jan 19 22:22:39 CET 2007
[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
none
[6.] A small shell script or example program which triggers the
     problem (if possible)
dmesg | grep -E '(KB)|(KiB)|(MB)'
[7.] Environment
linux
[7.1.] Software (add the output of the ver_linux script here)
[7.2.] Processor information (from /proc/cpuinfo):
cat  /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP
stepping        : 1
cpu MHz         : 1666.742
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow ts
bogomips        : 3335.02

[7.3.] Module information (from /proc/modules):
not important
[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
not important
[7.5.] PCI information ('lspci -vvv' as root)
not important
[7.6.] SCSI information (from /proc/scsi/scsi)
not important
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
not important
[X.] Other notes, patches, fixes, workarounds:
“That’s one small step for a man, one giant leap for mankind.”  - Neil 
Armstrong 


