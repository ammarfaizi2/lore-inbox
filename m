Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285013AbRLFM5l>; Thu, 6 Dec 2001 07:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285124AbRLFM5c>; Thu, 6 Dec 2001 07:57:32 -0500
Received: from web13907.mail.yahoo.com ([216.136.175.70]:6667 "HELO
	web13907.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S285013AbRLFM5V>; Thu, 6 Dec 2001 07:57:21 -0500
Message-ID: <20011206125719.49725.qmail@web13907.mail.yahoo.com>
Date: Thu, 6 Dec 2001 04:57:19 -0800 (PST)
From: Jorge Carminati <jcarminati@yahoo.com>
Subject: Re: Kernel freezing....
To: linux-kernel@vger.kernel.org
In-Reply-To: <20011206031210.A11885@qfire.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jaswinder:

Ok, but per default Red Hat 7.2 comes optimized for i386 and anyway
it´s freezing. The second test I made was just to discard a possible
problem related to the CPU optimization, which unfortunately did not
worked.

Understood the other problems, thanks.

Jorge Carminati.

P.S: Please for any answer cc to jcarminati@yahoo.com

--- jcassidy@cs.kent.edu wrote:
> 
> On Wed, Dec 05, 2001 at 11:20:36PM -0300, Jorge Carminati wrote:
> > Hi !
> > 
> > The problem is that after a couple of minutes of use it starts to 
> > dump kernel messages, and it ends freezing completely. Almost all
> the 
> > time I ran in init 1 mode (single user).
> 
> 	There is a problem with the athlon optimizations, if you compile
> for a PPro or lower your kernel should run stable, although probably
> a little
> bit slower.
> 
> > 
> > If someone needs more information I'll send it.
> > 
> > The notebook is a Compaq Presario 701LA (700 series) with 256 Mb
> RAM 
> > and an Ext3 partition of 4Gb with a 100Mb swap partition.
> 
> Have a 705US here, some other problems you might run into:
> 	* Compiling IO-APIC into the kernel will cause ACPI to hang on boot.
> 	* Sound will not work, both OSS and Alsa drivers load fine,
> 	  the sound even appears to be decoded fine, it just won't
> 	  reach the speakers. Seen several posts from people having
> 	  the same problem, haven't seen any solutions yet.
> 	* The X-windows drivers don't seem to like shared memory much,
> 	  programs like ogle or mtv appear to crash X, also managed to
> 	  get LyX to reliable crash X too.
> 	* If you ruin the keyboard by spilling something on it, lie and
> 	  and say it just stopped working ;) Telling the truth got me
> 	  nothing but aggravation trying to find a replacement part, and
> 	  I wasn't paying anyone $100 to take two screws out and pop the
> 	  keyboard out in less than 5 minutes.
> 
> 
> > 
> > *** If someone can help me please CC to jcarminati@yahoo.com as I'm
> 
> > not subscribed to this list ***. 
> > 
> > Thanks !
> > 
> > P.S.: The notebook works fine under Windows XP, just to discard a
> HW 
> > failure.
> > 
> > 
> > *** proc/cpuinfo shows: 
> > 
> > processor	: 0
> > vendor_id	: AuthenticAMD
> > cpu family	: 6
> > model		: 7
> > model name	: Mobile AMD Duron(tm) Processor
> > stepping	: 0
> > cpu MHz		: 946.750
> > cache size	: 64 KB
> > fdiv_bug	: no
> > hlt_bug		: no
> > f00f_bug	: no
> > coma_bug	: no
> > fpu		: yes
> > fpu_exception	: yes
> > cpuid level	: 1
> > wp		: yes
> > flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
> pat 
> > pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> > bogomips	: 1887.43
> > 
> > *************************************************
> > /proc/interrupts
> > 
> >            CPU0
> >   0:      37092          XT-PIC  timer
> >   1:       1259          XT-PIC  keyboard
> >   2:          0          XT-PIC  cascade
> >   8:          1          XT-PIC  rtc
> >  11:        112          XT-PIC  eth0
> >  14:       1790          XT-PIC  ide0
> >  15:          4          XT-PIC  ide1
> > NMI:          0
> > ERR:          0
> > 
> > ***************************************************
> > 
> > /proc/ioports
> > 
> > 0000-001f : dma1
> > 0020-003f : pic1
> > 0040-005f : timer
> > 0060-006f : keyboard
> > 0070-007f : rtc
> > 0080-008f : dma page reg
> > 00a0-00bf : pic2
> > 00c0-00df : dma2
> > 00f0-00ff : fpu
> > 0170-0177 : ide1
> > 01f0-01f7 : ide0
> > 0376-0376 : ide1
> > 03c0-03df : vga+
> > 03f6-03f6 : ide0
> > 0cf8-0cff : PCI conf1
> > 1000-10ff : VIA Technologies, Inc. AC97 Audio Controller
> > 1400-14ff : Realtek Semiconductor Co., Ltd. RTL-8139
> >   1400-14ff : 8139too
> > 1800-181f : VIA Technologies, Inc. UHCI USB
> > 1840-184f : VIA Technologies, Inc. Bus Master IDE
> >   1840-1847 : ide0
> >   1848-184f : ide1
> > 1850-1853 : VIA Technologies, Inc. AC97 Audio Controller
> > 1854-1857 : VIA Technologies, Inc. AC97 Audio Controller
> > 1858-185f : Conexant HSF 56k HSFi Modem
> > 8100-810f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
> > 
> > **********************************************************
> > * SYSLOG 
> > **********************************************************
> > 
> > Dec  5 19:20:48 notebook syslogd 1.4.1: restart.
> > Dec  5 19:20:48 notebook syslog: syslogd startup succeeded
> > Dec  5 19:20:48 notebook syslog: klogd startup succeeded
> > Dec  5 19:20:48 notebook kernel: klogd 1.4.1, log source =
> /proc/kmsg 
> > started.
> > Dec  5 19:20:48 notebook kernel: Inspecting
> /boot/System.map-2.4.7-10
> > Dec  5 19:20:48 notebook portmap: portmap startup succeeded
> > Dec  5 19:20:48 notebook kernel: Loaded 15331 symbols from 
> > /boot/System.map-2.4.7-10.
> > Dec  5 19:20:48 notebook kernel: Symbols match kernel version
> 2.4.7.
> > Dec  5 20:06:48 notebook syslogd 1.4.1: restart.
> > Dec  5 20:06:48 notebook syslog: syslogd startup succeeded
> > Dec  5 20:06:48 notebook kernel: klogd 1.4.1, log source =
> /proc/kmsg 
> > started.
> > Dec  5 20:06:48 notebook kernel: Inspecting
> /boot/System.map-2.4.7-10
> > Dec  5 20:06:48 notebook syslog: klogd startup succeeded
> > Dec  5 20:06:48 notebook kernel: Loaded 15331 symbols from 
> > /boot/System.map-2.4.7-10.
> > Dec  5 20:06:48 notebook kernel: Symbols match kernel version
> 2.4.7.
> > Dec  5 20:06:48 notebook kernel: Loaded 175 symbols from 4 modules.
> > Dec  5 20:06:48 notebook kernel: Linux version 2.4.7-10 
> > (bhcompile@stripples.devel.redhat.com) (gcc version 2.96 20000731 
> > (Red Hat Linux 7.1 2.96-98)) #1 Thu Sep 6 16:46:36 EDT 2001
> > Dec  5 20:06:48 notebook kernel: BIOS-provided physical RAM map:
> > Dec  5 20:06:48 notebook kernel:  BIOS-e820: 0000000000000000 - 
> > 000000000009e800 (usable)
> > Dec  5 20:06:48 notebook kernel:  BIOS-e820: 000000000009e800 - 
> > 00000000000a0000 (reserved)
> > Dec  5 20:06:48 notebook kernel:  BIOS-e820: 00000000000c0000 - 
> > 00000000000cc000 (reserved)
> > Dec  5 20:06:48 notebook kernel:  BIOS-e820: 00000000000dc000 - 
> > 0000000000100000 (reserved)
> > Dec  5 20:06:48 notebook kernel:  BIOS-e820: 0000000000100000 - 
> > 000000000eef0000 (usable)
> > Dec  5 20:06:48 notebook kernel:  BIOS-e820: 000000000eef0000 - 
> > 000000000eeff000 (ACPI data)
> > Dec  5 20:06:48 notebook kernel:  BIOS-e820: 000000000eeff000 - 
> > 000000000ef00000 (ACPI NVS)
> > Dec  5 20:06:48 notebook kernel:  BIOS-e820: 000000000ef00000 - 
> > 000000000f000000 (usable)
> > Dec  5 20:06:48 notebook kernel:  BIOS-e820: 00000000fff80000 - 
> > 0000000100000000 (reserved)
> > Dec  5 20:06:48 notebook kernel: On node 0 totalpages: 61440
> > Dec  5 20:06:48 notebook kernel: zone(0): 4096 pages.
> > Dec  5 20:06:48 notebook kernel: zone(1): 57344 pages.
> > Dec  5 20:06:48 notebook kernel: zone(2): 0 pages.
> > Dec  5 20:06:48 notebook kernel: Local APIC disabled by BIOS -- 
> > reenabling.
> > Dec  5 20:06:48 notebook kernel: Found and enabled local APIC!
> > Dec  5 20:06:48 notebook kernel: Kernel command line: 
> > BOOT_IMAGE=linux ro root=302 BOOT_FILE=/boot/vmlinuz-2.4.7-10
> single
> > Dec  5 20:06:48 notebook kernel: Initializing CPU#0
> > Dec  5 20:06:48 notebook kernel: Detected 946.722 MHz processor.
> > Dec  5 20:06:48 notebook kernel: Console: colour VGA+ 80x25
> > Dec  5 20:06:48 notebook kernel: Calibrating delay loop... 1887.43 
> > BogoMIPS
> > Dec  5 20:06:49 notebook kernel: Memory: 237056k/245760k available 
> > (1279k kernel code, 6448k reserved, 91k data, 232k init, 0k
> highmem)
> > Dec  5 20:06:49 notebook kernel: Dentry-cache hash table entries: 
> > 32768 (order: 6, 262144 bytes)
> > Dec  5 20:06:49 notebook kernel: Inode-cache hash table entries: 
> > 16384 (order: 5, 131072 bytes)
> > Dec  5 20:06:49 notebook kernel: Mount-cache hash table entries:
> 4096 
> > (order: 3, 32768 bytes)
> > Dec  5 20:06:49 notebook kernel: Buffer-cache hash table entries: 
> > 16384 (order: 4, 65536 bytes)
> > Dec  5 20:06:49 notebook kernel: Page-cache hash table entries:
> 65536 
> > (order: 7, 524288 bytes)
> > Dec  5 20:06:49 notebook kernel: Intel machine check architecture 
> > supported.
> 
=== message truncated ===


__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
