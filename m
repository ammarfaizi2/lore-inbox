Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRAZMAb>; Fri, 26 Jan 2001 07:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbRAZMAW>; Fri, 26 Jan 2001 07:00:22 -0500
Received: from Hermes.Mathematik.Uni-Dortmund.DE ([129.217.151.250]:62728 "EHLO
	hermes.Mathematik.Uni-Dortmund.DE") by vger.kernel.org with ESMTP
	id <S129143AbRAZMAE>; Fri, 26 Jan 2001 07:00:04 -0500
Message-ID: <3A7166BF.AFC96D4B@mathematik.uni-dortmund.de>
Date: Fri, 26 Jan 2001 12:59:59 +0100
From: Christian Becker <Christian.Becker@Math.Uni-Dortmund.DE>
Reply-To: Christian.Becker@Math.Uni-Dortmund.DE
Organization: Universitaet Dortmund, Lehrstuhl III
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.4.0 bug report
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel developers,

with my alpha machine I have the following problems:

Problem 1: 2.4.0 kernel hangs sporadically on AlphaServer ES40
Description: On the machine specified below kernel 2.4.0 hangs
completely from time to time. The machine has ECC correctable memory
errors and I suppose that the 2.4.0 kernel isn't able to handle these
faults correctly. Most of the time the kernel runs stable without any 
problems.

Problem 2: 2.4.0/2.2.16 network driver problem
Description: Under heavy load, e.g. NFS or scp transfers, the network driver
hangs for 2 seconds and produces the following error messages:

Jan 25 14:51:51 beta kernel: eth0: Transmit timed out: 
  status 0050  0c00 at 136316/136344 command 000c0000.
Jan 25 14:51:51 beta kernel: eth0: Tx ring dump,  
  Tx queue 136344 / 136316:
Jan 25 14:51:51 beta kernel: eth0:     0 200ca000.
[...]
Jan 25 14:51:51 beta kernel: eth0:    27 000ca000.
Jan 25 14:51:51 beta kernel: eth0:  * 28 000c0000.
Jan 25 14:51:51 beta kernel: eth0:    29 000ca000.
Jan 25 14:51:51 beta kernel: eth0:    30 000ca000.
Jan 25 14:51:51 beta kernel: eth0:    31 000ca000.
Jan 25 14:51:51 beta kernel: eth0: Printing Rx ring 
  (next to receive into 335164, dirty index 335164).
Jan 25 14:51:51 beta kernel: eth0:     0 00000001.
[...]
Jan 25 14:51:51 beta kernel: eth0: l  27 c0000001.
Jan 25 14:51:51 beta kernel: eth0:  *=28 00000001.
Jan 25 14:51:51 beta kernel: eth0:    29 00000001.
Jan 25 14:51:51 beta kernel: eth0:    30 00000001.
Jan 25 14:51:51 beta kernel: eth0:    31 00000001.


Yours sincerely,
Christian Becker

-------------------------------------------------------------------------
 

The machine configuration is the following:

Linux version 2.4.0 (gcc version egcs-2.91.66 19990314 
(egcs-1.1.2 release)) #1 SMP Wed Jan 24 10:08:44 CET 2001

Kernel modules         2.3.11
Gnu C                  2.95.2
Binutils               2.9.5.0.24
Linux C Library        so.6.1
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.6
Mount                  2.10m
Net-tools              1.56
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         


cpu                     : Alpha
cpu model               : EV67
cpu variation           : 7
cpu revision            : 0
system type             : Tsunami
system variation        : Clipper
system revision         : 0
cycle frequency [Hz]    : 666666666 
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 44
max. addr. space #      : 255
BogoMIPS                : 635.43
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : Compaq AlphaServer ES40
cpus detected           : 4


/proc/ioports 
0060-006f : keyboard
0070-007f : timer
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
a800-a807 : ide0
a808-a80f : ide1
10000b000-10000b07f : sym53c8xx
109002000-10900201f : Intel Speedo3 Ethernet


/proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: COMPAQ   Model: BD036635C5       Rev: B017
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: COMPAQ   Model: BD036635C5       Rev: B017
  Type:   Direct-Access                    ANSI SCSI revision: 02


/proc/pci 
PCI devices found:
  Bus  0, device   1, function  0:
    VGA compatible controller: Mitsubishi Unknown device (rev 0).
      Vendor id=10ba. Device id=304.
      Medium devsel.  Fast back-to-back capable.  IRQ 24.  Master Capable.  
      Latency=240.  
      Non-prefetchable 32 bit memory at 0x14000000 [0x14000000].
      Non-prefetchable 32 bit memory at 0x1a000000 [0x1a000000].
      I/O at 0x8000 [0x8001].
  Bus  0, device   7, function  0:
    ISA bridge: Acer Labs M1533 Aladdin IV (rev 195).
      Medium devsel.  Master Capable.  No bursts.  
  Bus  0, device  15, function  0:
    IDE interface: Acer Labs M5229 TXpro (rev 193).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  
      Latency=255.  Min Gnt=2.Max Lat=4.
      I/O at 0x8800 [0x8801].
      I/O at 0x9000 [0x9001].
      I/O at 0x9800 [0x9801].
      I/O at 0xa000 [0xa001].
      I/O at 0xa800 [0xa801].
  Bus  0, device  19, function  0:
    USB Controller: Acer Labs M5237 USB (rev 3).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  
      Latency=248.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0x1c000000 [0x1c000000].
  Bus  1, device   4, function  0:
    SCSI storage controller: NCR 53c895 (rev 2).
      Medium devsel.  IRQ 52.  Master Capable.  Latency=255.  
      Min Gnt=30.Max Lat=64.
      I/O at 0x10000b000 [0x10000b001].
      Non-prefetchable 32 bit memory at 0x109000000 [0x109000000].
      Non-prefetchable 32 bit memory at 0x109001000 [0x109001000].
  Bus  1, device   6, function  0:
    Ethernet controller: Intel 82557 (rev 8).
      Medium devsel.  Fast back-to-back capable.  IRQ 60.  Master Capable.  
      Latency=255.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0x109002000 [0x109002000].
      I/O at 0x10000b800 [0x10000b801].
      Non-prefetchable 32 bit memory at 0x109100000 [0x109100000].


-- 
         v          
      ..d8b..       Christian Becker 
  ..:::d888b:::..
 :::::d88888b:::::  Institut fuer Angewandte Mathematik & Numerik, LS3
:::::d8888888b::::: Universitaet Dortmund 
::::d888888888b:::: Vogelpothsweg 87, 44227 Dortmund, Germany 
 ::{8888P"::"V8,::  Voicemail: +49 231 755 5934 FAX: +49 231 755 5933 
  :D8P":::::::VD:   mailto:Christian.Becker@mathematik.uni-dortmund.de  
  dP  ```````   Y
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
