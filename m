Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129798AbQKTRzK>; Mon, 20 Nov 2000 12:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129792AbQKTRzA>; Mon, 20 Nov 2000 12:55:00 -0500
Received: from chimaera.uunet.be ([194.7.16.7]:53764 "EHLO chimaera.uunet.be")
	by vger.kernel.org with ESMTP id <S129780AbQKTRyw>;
	Mon, 20 Nov 2000 12:54:52 -0500
From: "Jan Gyselinck" <jan.gyselinck@be.uu.net>
Date: Mon, 20 Nov 2000 18:12:31 +0100
To: John Folkers <john_folkers@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.5 more stable than 2.2.12 or later.
Message-ID: <20001120181231.A27900@dhcp194-7-17-95.uunet.be>
In-Reply-To: <20001120152543.28696.qmail@web9606.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001120152543.28696.qmail@web9606.mail.yahoo.com>; from john_folkers@yahoo.com on Mon, Nov 20, 2000 at 07:25:43AM -0800
Organization: UUNET
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I too run linux on a Compaq Deskpro EN PII 350.  It never crashed.  It runned 2.2.9 -> 2.2.15, without any oops.  But I must say, I only run official kernels from kernel.org that I compiled myself.  I'm not interested in the pre-compiled redhat thingies.

Did you compile your kernel yourself?
When you compiled the kernel yourself, did you got it from ftp.<countrycode>.kernel.org ?

If not, I think you should contact RedHat support.

Regards


Jan Gyselinck

On Mon, Nov 20, 2000 at 07:25:43AM -0800, John Folkers wrote:
> Hello.
> 
> I subscribed to this list expressly to tell you guys about a bug in the kernel that
> is being carried forward.  I am not a kernel master, all I do is install stuff.
> 
> First, before I begin, PLEASE reference linux-kernel posting entitled:
> 
> Subject "kswapd related oopses in 2.2.13"
> From: Arthur Pedyczak (arthur-p@home.com)
> Date: Sun Nov 28 1999 - 10:59:02 AKST
> 
> In there, he posted a solution to the problem (see problem definition below) which I
> tried and worked... which was to basically roll back to kernel 2.2.5 after many
> kernel Oopses.
> 
> Problem Description:
> I would get a LOT of kernel Oopses randomly.  It could be any process.  bash, gawk,
> grep, whatnot.  The request for paging at a virtual address kind.  I would boot up
> and within 5 minutes or 10 minutes, I'd get the oops.  I have a Deskpro Pentium II,
> and also a Deskpro Pentium III, both from Compaq.
> 
> I am posting this to follow with up Arthur's original posting, which largely went
> ignored.  I think the kernel has a big problem right now that's going undetected.
> 
> First, let me describe what I tried to do to fix it.  I tried RedHat 7.0.  I tried
> RedHat 6.2 release 3.  I tried RedHat 6.2.  I tried RedHat 6.1.  I upgraded the bios
> on my NIC to the latest.  I upgraded bios of the motherboard to the latest.  I
> swapped out many memory sticks from 3 other machines.  I swapped out the HD from a
> working linux computer.  None of these fixed the problem.  I even removed the NIC.
> 
> Additionally, I turned on APMD to see if maybe that was it.  (See
> http://www.bitwizard.nl/sig11/ for the page I got this idea from).  I tried forcing
> the HD to be all different kinds of modes via bios and also via hdparm.  (PIO mode 0
> didn't work, but ALL the other modes the HD was able to be read/write just fine). 
> Still, the problem persisted.
> 
> I tried not only different memory sticks (they are DIMMs) but also tried in
> different DIMM slots and order.  I tried all combinations.  Still, the problem would
> not go away.  Did I mention I even tried three HDs, with one being less than 2GB to
> see if that was the problem?
> 
> I even told the kernel at boot what CHS geometry the HD had.  I tried changing the
> AGP aperature (you can see I was desperate).  Even tried turning off the USB port in
> the bios.  Problem would not go away.
> 
> I worked on this for 3 straight weeks until finally I came across Arthur's post on
> the kernel list.  I tried compiled kernel 2.2.5 and presto.  Not a single fault,
> failure of any kind, I was IMMENSELY PLEASED that I could go on to other projects. 
> 2.2.5 has not bombed even once.  In my book, this one had been solved by rolling
> back the kernel to 2.2.5.
> 
> Someone needs to pay attention to this.  You too can reproduce this with any Compaq
> Deskpro EN series box (I used both a Pentium II 350mhz and a Pentium III 500mhz from
> Compaq.  Both exhibited the same results.)  Only Kernel 2.2.5 fixes it.  The latest
> kernels just bomb all the time on it.  Ergo, this is a kernel software problem.
> 
> Hardware:
> Motherboard: Compaq Deskpro EN series.
> CPU: PIII-500 (and also PII-350)
> 64MB DIMM RAM 
> 6GB HDD (EIDE - primary master) 
> EIDE-ATAPI CDROM (primary slave) 
> FDD
> 
> Kernel Ooops output:
> Nov 16 00:39:10 A23 kernel: Unable to handle kernel paging request at virtual
> address 44504849
> Nov 16 00:39:10 A23 kernel: current->tss.cr3 = 03a11000, %cr3 = 03a11000
> Nov 16 00:39:10 A23 kernel: *pde = 00000000
> Nov 16 00:39:10 A23 kernel: Oops: 0002
> Nov 16 00:39:10 A23 kernel: CPU:    0
> Nov 16 00:39:10 A23 kernel: EIP:    0010:[sys_read+48/196]
> Nov 16 00:39:10 A23 kernel: EFLAGS: 00010206
> Nov 16 00:39:10 A23 kernel: eax: c3ff7400   ebx: 4450482d   ecx: bffff46f   edx:
> 00000000
> Nov 16 00:39:10 A23 kernel: esi: fffffff7   edi: 0807c630   ebp: 00000001   esp:
> c2f8ffb8
> Nov 16 00:39:10 A23 kernel: ds: 0018   es: 0018   ss: 0018
> Nov 16 00:39:10 A23 kernel: Process bash (pid: 577, process nr: 31,
> stackpage=c2f8f000)
> Nov 16 00:39:10 A23 kernel: Stack: 0807c630 bffff478 c0109f58 00000000 bffff46f
> 00000001 401436c0 0807c630 
> Nov 16 00:39:10 A23 kernel:        bffff478 00000003 c010002b 0000002b 00000003
> 400f6c34 00000023 00000246 
> Nov 16 00:39:10 A23 kernel:        bffff448 0000002b 
> Nov 16 00:39:10 A23 kernel: Call Trace: [system_call+52/56] [startup_32+43/285] 
> Nov 16 00:39:10 A23 kernel: Code: ff 43 1c 85 db 0f 84 81 00 00 00 f6 43 10 01 74 72
> 8b 43 08 
> Nov 16 00:39:10 A23 kernel: Unable to handle kernel paging request at virtual
> address 44504835
> Nov 16 00:39:10 A23 kernel: current->tss.cr3 = 00101000, %cr3 = 00101000
> Nov 16 00:39:10 A23 kernel: *pde = 00000000
> Nov 16 00:39:10 A23 kernel: Oops: 0000
> Nov 16 00:39:10 A23 kernel: CPU:    0
> Nov 16 00:39:10 A23 kernel: EIP:    0010:[filp_close+7/92]
> Nov 16 00:39:10 A23 kernel: EFLAGS: 00010206
> Nov 16 00:39:10 A23 kernel: eax: c3ff7400   ebx: 4450482d   ecx: 00000000   edx:
> 4450482d
> Nov 16 00:39:10 A23 kernel: esi: 00000000   edi: c3282e00   ebp: 00000001   esp:
> c2f8ff04
> Nov 16 00:39:10 A23 kernel: ds: 0018   es: 0018   ss: 0018
> Nov 16 00:39:10 A23 kernel: Process bash (pid: 577, process nr: 31,
> stackpage=c2f8f000)
> Nov 16 00:39:10 A23 kernel: Stack: c3282e00 c0117821 4450482d c3282e00 c2f8ff7c
> c2f8e000 44504849 7baf6000 
> Nov 16 00:39:10 A23 kernel:        00000000 c2f8e000 c010a478 0000000b c2f8ff7c
> c01d91a7 c01daace 00000002 
> Nov 16 00:39:10 A23 kernel:        00000000 c010f4b8 c01daace c2f8ff7c 00000002
> c2f8e000 fffffff7 0807c630 
> Nov 16 00:39:10 A23 kernel: Call Trace: [do_exit+297/628] [die_if_no_fixup+0/64]
> [error_table+2631/9344] [error_table+9070/9344] [do_page_fault+708/944]
> [error_table+9070/9344] [error_code+45/56] 
> Nov 16 00:39:10 A23 kernel:        [sys_read+48/196] [system_call+52/56]
> [startup_32+43/285] 
> Nov 16 00:39:10 A23 kernel: Code: 8b 7b 08 83 7b 1c 00 75 10 68 02 d5 1d c0 e8 16 ea
> fe ff 31 
> 
> 
> I've had MANY fresh, clean installs.  Here's the bootup after a fresh one:
> Bootup Part of Syslog:
> Nov 15 05:57:30 localhost kernel: Detected 348210 kHz processor.
> Nov 15 05:57:30 localhost kernel: Console: colour VGA+ 80x25
> Nov 15 05:57:30 localhost kernel: Calibrating delay loop... 694.68 BogoMIPS
> Nov 15 05:57:30 localhost kernel: Memory: 62932k/65536k available (1048k kernel
> code, 412k reserved, 1080k data, 64k init, 0k bigmem)
> Nov 15 05:57:30 localhost kernel: Dentry hash table entries: 262144 (order 9, 2048k)
> Nov 15 05:57:30 localhost kernel: Buffer cache hash table entries: 65536 (order 6,
> 256k)
> Nov 15 05:57:30 localhost kernel: Page cache hash table entries: 16384 (order 4,
> 64k)
> Nov 15 05:57:30 localhost kernel: VFS: Diskquotas version dquot_6.4.0 initialized
> Nov 15 05:57:30 localhost kernel: CPU: Intel Pentium II (Deschutes) stepping 01
> Nov 15 05:57:30 localhost kernel: Checking 386/387 coupling... OK, FPU using
> exception 16 error reporting.
> Nov 15 05:57:30 localhost kernel: Checking 'hlt' instruction... OK.
> Nov 15 05:57:30 localhost kernel: POSIX conformance testing by UNIFIX
> Nov 15 05:57:30 localhost kernel: mtrr: v1.35a (19990819) Richard Gooch
> (rgooch@atnf.csiro.au)
> Nov 15 05:57:30 localhost kernel: PCI: PCI BIOS revision 2.10 entry at 0xed9a0
> Nov 15 05:57:30 localhost kernel: PCI: Using configuration type 1
> Nov 15 05:57:30 localhost kernel: PCI: Probing PCI hardware
> Nov 15 05:57:30 localhost kernel: Linux NET4.0 for Linux 2.2
> Nov 15 05:57:30 localhost kernel: Based upon Swansea University Computer Society
> NET3.039
> Nov 15 05:57:30 localhost kernel: NET4: Unix domain sockets 1.0 for Linux NET4.0.
> Nov 15 05:57:30 localhost kernel: NET4: Linux TCP/IP 1.0 for NET4.0
> Nov 15 05:57:30 localhost kernel: IP Protocols: ICMP, UDP, TCP, IGMP
> Nov 15 05:57:30 localhost kernel: TCP: Hash tables configured (ehash 65536 bhash
> 65536)
> Nov 15 05:57:30 localhost kernel: Linux IP multicast router 0.06 plus PIM-SM
> Nov 15 05:57:30 localhost kernel: Initializing RT netlink socket
> Nov 15 05:57:30 localhost kernel: Starting kswapd v 1.5 
> Nov 15 05:57:30 localhost kernel: Detected PS/2 Mouse Port.
> Nov 15 05:57:30 localhost kernel: Serial driver version 4.27 with MANY_PORTS
> MULTIPORT SHARE_IRQ enabled
> Nov 15 05:57:30 localhost kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
> Nov 15 05:57:30 localhost kernel: pty: 256 Unix98 ptys configured
> Nov 15 05:57:30 localhost kernel: apm: BIOS not found.
> Nov 15 05:57:30 localhost kernel: Real Time Clock Driver v1.09
> Nov 15 05:57:30 localhost kernel: RAM disk driver initialized:  16 RAM disks of
> 4096K size
> Nov 15 05:57:30 localhost kernel: PIIX4: IDE controller on PCI bus 00 dev a1
> Nov 15 05:57:30 localhost kernel: PIIX4: not 100% native mode: will probe irqs later
> Nov 15 05:57:30 localhost kernel:     ide0: BM-DMA at 0x2020-0x2027, BIOS settings:
> hda:DMA, hdb:pio
> Nov 15 05:57:30 localhost kernel:     ide1: BM-DMA at 0x2028-0x202f, BIOS settings:
> hdc:DMA, hdd:pio
> Nov 15 05:57:30 localhost kernel: hda: Maxtor 90640D4, ATA DISK drive
> Nov 15 05:57:30 localhost kernel: hdc: Compaq CRD-8322B, ATAPI CDROM drive
> Nov 15 05:57:30 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Nov 15 05:57:30 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
> Nov 15 05:57:30 localhost kernel: hda: Maxtor 90640D4, 6149MB w/256kB Cache,
> CHS=833/240/63
> Nov 15 05:57:30 localhost kernel: Floppy drive(s): fd0 is 1.44M
> Nov 15 05:57:30 localhost kernel: FDC 0 is a National Semiconductor PC87306
> Nov 15 05:57:30 localhost kernel: md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12
> Nov 15 05:57:30 localhost kernel: raid5: measuring checksumming speed
> Nov 15 05:57:30 localhost kernel: raid5: MMX detected, trying high-speed MMX
> checksum routines
> Nov 15 05:57:30 localhost kernel:    pII_mmx   :   774.192 MB/sec
> Nov 15 05:57:30 localhost kernel:    p5_mmx    :   813.054 MB/sec
> Nov 15 05:57:30 localhost kernel:    8regs     :   597.789 MB/sec
> Nov 15 05:57:30 localhost kernel:    32regs    :   335.280 MB/sec
> Nov 15 05:57:30 localhost kernel: using fastest function: p5_mmx (813.054 MB/sec)
> Nov 15 05:57:30 localhost kernel: scsi : 0 hosts.
> Nov 15 05:57:30 localhost kernel: scsi : detected total.
> Nov 15 05:57:30 localhost kernel: md.c: sizeof(mdp_super_t) = 4096
> Nov 15 05:57:30 localhost kernel: Partition check:
> Nov 15 05:57:30 localhost kernel:  hda: hda1 hda2 < hda5 >
> Nov 15 05:57:30 localhost kernel: autodetecting RAID arrays
> Nov 15 05:57:30 localhost kernel: autorun ...
> Nov 15 05:57:30 localhost kernel: ... autorun DONE.
> Nov 15 05:57:30 localhost kernel: VFS: Mounted root (ext2 filesystem) readonly.
> Nov 15 05:57:30 localhost kernel: Freeing unused kernel memory: 64k freed
> Nov 15 05:57:30 localhost kernel: Adding Swap: 105800k swap-space (priority -1)
> Nov 15 05:57:30 localhost kernel: usb.c: registered new driver usbdevfs
> Nov 15 05:57:30 localhost kernel: usb.c: registered new driver hub
> Nov 15 05:57:30 localhost kernel: usb-uhci.c: $Revision: 1.232 $ time 16:53:56 Aug
> 22 2000
> Nov 15 05:57:30 localhost kernel: usb-uhci.c: High bandwidth mode enabled
> Nov 15 05:57:30 localhost kernel: usb-uhci.c: Intel USB controller: setting latency
> timer to 0
> Nov 15 05:57:30 localhost kernel: usb-uhci.c: USB UHCI at I/O 0x2000, IRQ 11
> Nov 15 05:57:30 localhost kernel: usb-uhci.c: Detected 2 ports
> Nov 15 05:57:30 localhost kernel: usb.c: new USB bus registered, assigned bus number
> 1
> Nov 15 05:57:30 localhost kernel: usb.c: USB new device connect, assigned device
> number 1
> Nov 15 05:57:30 localhost kernel: hub.c: USB hub found
> Nov 15 05:57:30 localhost kernel: hub.c: 2 ports detected
> Nov 15 05:57:30 localhost kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
> Nov 15 05:57:30 localhost kernel: agpgart: Maximum main memory to use for agp
> memory: 28M
> Nov 15 05:57:30 localhost kernel: agpgart: Detected Intel 440BX chipset
> Nov 15 05:57:30 localhost kernel: agpgart: AGP aperture is 64M @ 0x44000000
> Nov 15 05:57:30 localhost portmap: portmap startup succeeded
> Nov 15 05:57:30 localhost nfslock: rpc.lockd startup succeeded
> Nov 15 05:57:30 localhost nfslock: rpc.statd startup succeeded
> Nov 15 05:57:30 localhost random: Initializing random number generator:  succeeded
> Nov 15 05:57:31 localhost netfs: Mounting other filesystems:  succeeded
> Nov 15 05:57:19 localhost rc.sysinit: Mounting proc filesystem:  succeeded 
> Nov 15 05:57:19 localhost sysctl: net.ipv4.ip_forward = 0 
> Nov 15 05:57:19 localhost sysctl: net.ipv4.conf.all.rp_filter = 1 
> Nov 15 05:57:19 localhost sysctl: net.ipv4.ip_always_defrag = 0 
> Nov 15 05:57:19 localhost sysctl: kernel.sysrq = 0 
> Nov 15 05:57:19 localhost rc.sysinit: Configuring kernel parameters:  succeeded 
> Nov 15 05:57:19 localhost date: Wed Nov 15 05:57:11 EST 2000 
> Nov 15 05:57:19 localhost rc.sysinit: Setting clock  (localtime): Wed Nov 15
> 05:57:11 EST 2000 succeeded 
> Nov 15 05:57:19 localhost rc.sysinit: Loading default keymap succeeded 
> Nov 15 05:57:19 localhost rc.sysinit: Activating swap partitions:  succeeded 
> Nov 15 05:57:19 localhost rc.sysinit: Setting hostname localhost.localdomain: 
> succeeded 
> Nov 15 05:57:19 localhost rc.sysinit: Initializing USB controller (usb-uhci): 
> succeeded 
> Nov 15 05:57:19 localhost rc.sysinit: Mounting USB filesystem:  succeeded 
> Nov 15 05:57:19 localhost fsck: /: clean, 76701/774144 files, 248078/1547902 blocks 
> Nov 15 05:57:19 localhost rc.sysinit: Checking root filesystem succeeded 
> Nov 15 05:57:19 localhost rc.sysinit: Remounting root filesystem in read-write mode:
>  succeeded 
> Nov 15 05:57:19 localhost rc.sysinit: Finding module dependencies:  succeeded 
> Nov 15 05:57:20 localhost rc.sysinit: Checking filesystems succeeded 
> Nov 15 05:57:20 localhost rc.sysinit: Mounting local filesystems:  succeeded 
> Nov 15 05:57:20 localhost rc.sysinit: Turning on user and group quotas for local
> filesystems:  succeeded 
> Nov 15 05:57:21 localhost rc.sysinit: Enabling swap space:  succeeded 
> Nov 15 05:57:22 localhost init: Entering runlevel: 3 
> Nov 15 05:57:28 localhost kudzu:  succeeded 
> Nov 15 05:57:29 localhost sysctl: net.ipv4.ip_forward = 0 
> Nov 15 05:57:29 localhost sysctl: net.ipv4.conf.all.rp_filter = 1 
> Nov 15 05:57:29 localhost sysctl: net.ipv4.ip_always_defrag = 0 
> Nov 15 05:57:29 localhost sysctl: kernel.sysrq = 0 
> Nov 15 05:57:29 localhost network: Setting network parameters:  succeeded 
> Nov 15 05:57:29 localhost network: Bringing up interface lo:  succeeded 
> Nov 15 05:57:31 localhost identd: identd startup succeeded
> Nov 15 05:57:31 localhost atd: atd startup succeeded
> Nov 15 05:57:31 localhost rc: Starting pcmcia:  succeeded
> Nov 15 05:57:32 localhost lpd: lpd startup succeeded
> Nov 15 05:57:32 localhost keytable: Loading keymap: 
> Nov 15 05:57:32 localhost keytable: Loading
> /usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz
> Nov 15 05:57:33 localhost keytable: Loading system font: 
> Nov 15 05:57:33 localhost rc: Starting keytable:  succeeded
> Nov 15 05:57:34 localhost sendmail: sendmail startup succeeded
> Nov 15 05:57:34 localhost gpm: gpm startup succeeded
> Nov 15 05:57:34 localhost crond[506]: (CRON) STARTUP (fork ok) 
> Nov 15 05:57:35 localhost crond: crond startup succeeded
> Nov 15 05:57:35 localhost xfs: xfs startup succeeded
> Nov 15 05:57:36 localhost anacron: anacron startup succeeded
> Nov 15 05:57:36 localhost anacron[554]: Anacron 2.3 started on 2000-11-15
> Nov 15 05:57:36 localhost anacron[554]: Will run job `cron.daily' in 5 min.
> Nov 15 05:57:36 localhost anacron[554]: Will run job `cron.weekly' in 10 min.
> Nov 15 05:57:36 localhost anacron[554]: Will run job `cron.monthly' in 15 min.
> Nov 15 05:57:36 localhost rhnsd: rhnsd startup succeeded
> Nov 15 05:57:36 localhost rhnsd[571]: Red Hat Network Services Daemon starting up.
> Nov 15 05:57:37 localhost linuxconf: Running Linuxconf hooks: succeeded
> 
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Calendar - Get organized for the holidays!
> http://calendar.yahoo.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
