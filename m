Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTJSJ3l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 05:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTJSJ3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 05:29:41 -0400
Received: from herald.cc.purdue.edu ([128.210.11.29]:27027 "EHLO
	herald.cc.purdue.edu") by vger.kernel.org with ESMTP
	id S262095AbTJSJ3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 05:29:38 -0400
Subject: PROBLEM: cd writing
From: Jake <zero@purdue.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1066555778.813.13.camel@stanley.physics.purdue.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 19 Oct 2003 04:29:38 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1)  When I burn a CD with kernel 2.6.0-test6 using cdrecord it locks up
my machine at various times during the write.

2)  When using kernel version 2.4.22(and previous 2.4 kernels) I have
had no trouble burning CDs.  When I started using 2.6.0 I began to have
problems with cdburning.  It seems to be a problem when I burn data
CD's.  When I start cdrecord it goes through the basic beginning steps
as I will show, then it hangs the machine.  It can occur before the
write starts or sometime during the middle of the write.  After it locks
up I am forced to reset.  The configuration for the 2.6.0 kernel is the
same as the 2.4.22 kernel.  I have the same configuration(minus of
course the alsa drivers in 2.6).

3)  the command I use is . . .
	cdrecord -v dev=0,0,0 -data name.iso
	again, this works fine in 2.4.22

the program output before freezing is ..  .
Cdrecord-Clone 2.01a19 (i686-pc-linux-gnu) Copyright (C) 1995-2003 Jörg
Schilling
TOC Type: 1 = CD-ROM
Using libscg version 'schily-0.7'
atapi: 1
Device type    : Removable CD-ROM
Version        : 2
Response Format: 2
Capabilities   : 
Vendor_info    : 'LITE-ON '
Identifikation : 'LTR-12101B      '
Revision       : 'LS3B'
Device seems to be: Generic mmc CD-RW.
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC SWABAUDIO BURNFREE 
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R96P RAW/R96R
Drive buf size : 1658880 = 1620 KB
FIFO size      : 4194304 = 4096 KB
Track 01: data   624 MB        
Total size:      717 MB (71:03.54) = 319766 sectors
Lout start:      717 MB (71:05/41) = 319766 sectors
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 5
  Reference speed: 2
  Is not unrestricted
  Is erasable
  ATIP start of lead in:  -12900 (97:10/00)
  ATIP start of lead out: 359849 (79:59/74)
  1T speed low:  0 (reserved val  0) 1T speed high:  4
  2T speed low:  0 (reserved val  5) 2T speed high:  0 (reserved val 12)
  power mult factor: 4 5
  recommended erase/write power: 3
  A1 values: 02 4A B0
  A2 values: 5C C6 26
Disk type:    unknown dye (reserved id code)
Manuf. index: -1
Manufacturer: unknown (not in table)
Manufacturer is unknown because of the orange forum embargo.
As the orange forum likes to get money for recent information,
it may be that this media does not use illegal manufacturer coding.
Blocks total: 359849 Blocks current: 359480 Blocks remaining: 39714
Starting to write CD/DVD at speed 4 in real TAO mode for single session.
Last chance to quit, starting real write    0 seconds. Operation starts.
Waiting for reader process to fill input buffer ... input buffer ready.
BURN-Free is OFF.
Performing OPC...
Starting new track at sector: 369
Track 01:   15 of  624 MB written (fifo 100%) [buf  98%]   4.2x

cat cpuinfo >>>
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) processor
stepping        : 4
cpu MHz         : 1000.358
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1970.17

cat version >>>>
Linux version 2.6.0-test6 (root@stanley) (gcc version 3.3.2 20031005
(Debian prerelease)) #1 SMP Sat Oct 18 21:22:59 EST 2003

alsa driver >>
ALSA device list:
  #0: VIA 82C686A/B rev50 at 0xcc00, irq 5


Let me know if there is anything else I can let you know

Thanks
Jacob M
zero@purdue.edu

