Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278261AbRJSBSY>; Thu, 18 Oct 2001 21:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278263AbRJSBSN>; Thu, 18 Oct 2001 21:18:13 -0400
Received: from web20202.mail.yahoo.com ([216.136.226.57]:22286 "HELO
	web20202.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S278261AbRJSBSA>; Thu, 18 Oct 2001 21:18:00 -0400
Message-ID: <20011019011833.65345.qmail@web20202.mail.yahoo.com>
Date: Thu, 18 Oct 2001 18:18:32 -0700 (PDT)
From: jimmy <x55k@yahoo.com>
Subject: Re: UNABLE TO BOOT WITH 2nd SCSI DRIVE
To: jroland@roland.net, linux-kernel@vger.kernel.org
In-Reply-To: <000a01c1583a$b503ff10$a000a8c0@gespl2k1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jim,

Yes, the IDs are unique and in the correct order (9.1
GB IBM drive (boot) at ID:0, 36 GB 15K Cheetah at
ID:1) as I have mentioned in the first mail. 

It might also be helpful to note that the following
error shows for both drives before kernel panic:

"parity error detected in Data-in phase"

Redhat 7.1 System with Adaptec Driver compiled into
the kernel.

Thanks,
Jimmy



--- Jim Roland <jroland@roland.net> wrote:
> Check to make sure the SCSI IDs assigned on the
> drives (see the jumpers on
> each drive) are all unique.  2 drives set with no
> jumpers to the same ID
> (SCSI #0) will not let your system boot...all drives
> must be unique.
> 
> 
>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Jim Roland, RHCE (RedHat Certified Engineer)
> Owner, Roland Internet Services
>      "The four surefire rules for success:  Show up,
> Pay attention, Ask
> questions, Don't quit."
>         --Rob Gilbert, PH.D.
>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> ----- Original Message -----
> From: "jimmy" <x55k@yahoo.com>
> To: <linux-kernel@vger.kernel.org>
> Sent: Thursday, October 18, 2001 6:33 PM
> Subject: UNABLE TO BOOT WITH 2nd SCSI DRIVE
> 
> 
> > Hello,
> >
> > I hope you can shed a light to my problem. The
> server
> > works just fine with a single SCSI drive.
> > Unfortunately, when we add the 2nd SCSI drive, the
> > system does not boot.
> >
> > VFS: Cannot open root dev "802" or 08:02
> > Please append correct "root=" boot option
> > Kernel panic: VFS: Unable to mount root fs on
> 08:02
> >
> > We have tried all SCSI ID combinations with no
> > success. LILO 'append="root=/dev/sda2"' command
> line
> > does not work. 802 above is our /dev/sda2 root
> > partition. We thought Adaptec driver is
> reshuffling
> > the drives however 'AIC7XXX=no_reset' LILO command
> > line does not work either.
> >
> > I would be forever grateful if someone can offer a
> > hand.
> >
> > Many thanks in advance for taking your time.
> >
> > Jimmy
> >
> > PS: Sorry if it looks like a cross-post. Server is
> > running out of disk space and we need to get the
> 2nd
> > drive added to the system. My apologies.
> >
> > Here is some diagnostic information:
> >
> > P3 866 MHz, BX M/b, 512 MB Ram, 9.1 GB SCSI IBM
> hd.
> > (works fine)
> > 2nd HD: Cheetah 15000 RPM 36 GB hd (gives problem
> when
> > added to the system)
> > Adaptec 29160 Ultra160 SCSI adapter
> >
> > Redhat 7.1, 2.4.2 Enterprise kernel (Adaptec
> Driver is
> > built into the kernel, not as module)
> >
> > Kernel command line:
> > auto BOOT_IMAGE=x ro root=802
> > BOOT_FILE=/boot/vmlinuz-2.4.2-2enterprise
> > root=/dev/sda2
> >
> > /proc/scsi/scsi:
> > Attached devices:
> > Host: scsi0 Channel: 00 Id: 06 Lun: 00
> >   Vendor: IBM      Model: DNES-309170W     Rev:
> SAH0
> >   Type:   Direct-Access                    ANSI
> SCSI
> > revision: 03
> >
> > /etc/lilo.conf:
> > boot=/dev/sda
> > map=/boot/map
> > install=/boot/boot.b
> > prompt
> > timeout=5
> > message=/boot/message
> > linear
> > default=x
> > append="root=/dev/sda2"
> >
> > image=/boot/vmlinuz-2.4.2-2
> >         label=linux
> >         initrd=/boot/initrd-2.4.2-2.img
> >         read-only
> >         root=/dev/sda2
> >
> > image=/boot/vmlinuz-2.4.2-2enterprise
> >         label=x5
> > #       initrd=/boot/initrd-2.4.2-2enterprise.img
> >         read-only
> >         root=/dev/sda2
> >
> >
> > DMESG:
> > Linux version 2.4.2-2enterprise (root@localhost)
> (gcc
> > version 2.96 20000731 (X Net 5.0 2.96-81)) #1 Sun
> May
> > 13 12:35:36 GM
> > T+4 2001
> > BIOS-provided physical RAM map:
> >  BIOS-e820: 000000000009fc00 @ 0000000000000000
> > (usable)
> >  BIOS-e820: 0000000000000400 @ 000000000009fc00
> > (usable)
> >  BIOS-e820: 0000000000010000 @ 00000000000f0000
> > (reserved)
> >  BIOS-e820: 0000000000500000 @ 00000000ffb00000
> > (reserved)
> >  BIOS-e820: 000000001fdf0000 @ 0000000000100000
> > (usable)
> >  BIOS-e820: 000000000000d000 @ 000000001fef3000
> (ACPI
> > data)
> >  BIOS-e820: 0000000000003000 @ 000000001fef0000
> (ACPI
> > NVS)
> > Scan SMP from 40000000 for 1024 bytes.
> > Scan SMP from 4009fc00 for 1024 bytes.
> > Scan SMP from 400f0000 for 65536 bytes.
> > Scan SMP from 40000000 for 4096 bytes.
> > On node 0 totalpages: 130800
> > zone(0): 4096 pages.
> > zone DMA has max 32 cached pages.
> > zone(1): 126704 pages.
> > zone Normal has max 989 cached pages.
> > zone(2): 0 pages.
> > zone HighMem has max 1 cached pages.
> > Local APIC disabled by BIOS -- reenabling.
> > Found and enabled local APIC!
> > mapped APIC to ffffe000 (fee00000)
> > Kernel command line: auto BOOT_IMAGE=x ro root=802
> > BOOT_FILE=/boot/vmlinuz-2.4.2-2enterprise
> > root=/dev/sda2
> > Initializing CPU#0
> > Detected 868.653 MHz processor.
> > Console: colour VGA+ 80x25
> > Calibrating delay loop... 1730.15 BogoMIPS
> > Memory: 512088k/523200k available (1451k kernel
> code,
> > 10724k reserved, 78k data, 180k init, 0k highmem)
> > Dentry-cache hash table entries: 65536 (order: 7,
> > 524288 bytes)
> > Buffer-cache hash table entries: 32768 (order: 5,
> > 131072 bytes)
> > Page-cache hash table entries: 131072 (order: 8,
> > 1048576 bytes)
> > Inode-cache hash table entries: 32768 (order: 6,
> > 262144 bytes)
> > VFS: Diskquotas version dquot_6.5.0 initialized
> > CPU: Before vendor init, caps: 0387fbff 00000000
> > 00000000, vendor = 0
> > CPU: L1 I cache: 16K, L1 D cache: 16K
> > CPU: L2 cache: 256K
> > Intel machine check architecture supported.
> > Intel machine check reporting enabled on CPU#0.
> > CPU: After vendor init, caps: 0387fbff 00000000
> > 00000000 00000000
> > CPU serial number disabled.
> > CPU: After generic, caps: 0383fbff 00000000
> 00000000
> > 00000000
> > CPU: Common caps: 0383fbff 00000000 00000000
> 00000000
> > CPU: Intel Pentium III (Coppermine) stepping 06
> > Enabling fast FPU save and restore... done.
> > Enabling unmasked SIMD FPU exception support...
> done.
> > Checking 'hlt' instruction... OK.
> > POSIX conformance testing by UNIFIX
> > Getting VERSION: 40011
> > Getting VERSION: 40011
> > Getting ID: 0
> > Getting ID: f000000
> > Getting LVT0: 700
> > Getting LVT1: 400
> > enabled ExtINT on CPU#0
> > ESR value before enabling vector: 00000040
> > ESR value after enabling vector: 00000000
> > calibrating APIC timer ...
> > ..... CPU clock speed is 868.6803 MHz.
> > ..... host bus clock speed is 133.6430 MHz.
> > cpu: 0, clocks: 1336430, slice: 668215
> > CPU0<T0:1336416,T1:668192,D:9,S:668215,C:1336430>
> 
=== message truncated ===


__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
