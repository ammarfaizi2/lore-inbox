Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSH0SwV>; Tue, 27 Aug 2002 14:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316775AbSH0SwV>; Tue, 27 Aug 2002 14:52:21 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:57077 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S316753AbSH0SwU>; Tue, 27 Aug 2002 14:52:20 -0400
Date: Tue, 27 Aug 2002 11:57:51 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: symbios 53c1010 problems 2.4.18/19/20prexxx
Message-ID: <Pine.LNX.4.44.0208271137350.10524-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a tekram dc390u3w (sym53c1010) when the sym53c8xx module gets loaded I 
see a lot of this:

sym53c1010-33-1: unable to abort current chip operation, ISTAT=0x00.
sym53c1010-33-1: restart (scsi reset).
sym53c1010-33-1: handling phase mismatch from SCRIPTS.
sym53c1010-33-1: Downloading SCSI SCRIPTS.
SCSI host 1 abort (pid 185) timed out - resetting
SCSI bus is being reset for host 1 channel 0.
sym53c8xx_reset: pid=185 reset_flags=2 serial_number=186 
serial_number_at_timeout=186

It repeats about 200 times before the machine continues... bootup time is 
about 15 minutes.

The funny thing is there isn't anything on the second channel. only on the 
first.

sym53c1010-33-0-<0,*>: FAST-80 WIDE SCSI 160.0 MB/s (12.5 ns, offset 62)
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
 sda: sda1
sym53c1010-33-0-<1,*>: FAST-80 WIDE SCSI 160.0 MB/s (12.5 ns, offset 62)
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
 sdb: sdb1
sym53c1010-33-0-<2,*>: FAST-80 WIDE SCSI 160.0 MB/s (12.5 ns, offset 62)
SCSI device sdc: 35843670 512-byte hdwr sectors (18352 MB)
 sdc: sdc1
sym53c1010-33-0-<3,*>: FAST-80 WIDE SCSI 160.0 MB/s (12.5 ns, offset 62)
SCSI device sdd: 35843670 512-byte hdwr sectors (18352 MB)
 sdd: sdd1

building kernel with the scsi driver built in generally results in a hang 
sometime during boot.

The system is an msi ms-6501 AMD 762 chipset with dual athlon MP 1900+ 
cpu's and 2GB of ram.

the tekram (64bit 66mhz) is in the second 64bit pci slot a tigon3 based 
syskonnect is in the first 64bit pci slot.

lspci output looks like this:

[root@proxy2 root]# lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
System Co
ntroller (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP 
Bridge
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 
04)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE 
(rev 04)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD]: Unknown 
devic
e 7445 (rev 03)
00:08.0 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 
53c101
0 Ultra3 SCSI Adapter (rev 01)
00:08.1 SCSI storage controller: LSI Logic / Symbios Logic (formerly NCR) 
53c101
0 Ultra3 SCSI Adapter (rev 01)
00:09.0 Ethernet controller: Syskonnect (Schneider & Koch): Unknown device 
4400 
(rev 11)
00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 
04)
02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB 
(rev 07)
02:05.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro 215GP 
(rev 5
c)


This particular output is from a redhat 2.4.18-3 i686up kernel, it doesn't
differ significantly from the output from 2.4.18up 2.4.19up/smp and
2.4.20pre4. any additional information that might be helpful to 
someone please contact me.

joelja

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
  In Dr. Johnson's famous dictionary patriotism is defined as the last
  resort of the scoundrel.  With all due respect to an enlightened but
  inferior lexicographer I beg to submit that it is the first.
	   	            -- Ambrose Bierce, "The Devil's Dictionary"


