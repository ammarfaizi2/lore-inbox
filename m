Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313258AbSC1UhI>; Thu, 28 Mar 2002 15:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313255AbSC1Ug7>; Thu, 28 Mar 2002 15:36:59 -0500
Received: from h0060b0b5251c.ne.client2.attbi.com ([66.31.34.217]:8432 "HELO
	tau.local") by vger.kernel.org with SMTP id <S313254AbSC1Ugu>;
	Thu, 28 Mar 2002 15:36:50 -0500
Date: Thu, 28 Mar 2002 15:32:09 -0500
From: Maarten Ballintijn <maartenb@mit.edu>
To: Adam D Scislowicz <adams@fourelle.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CPU Model IDs(string) inconsistant on SMP AMD System (2.4.18-rc4)
Message-ID: <20020328153209.A6047@tau.local>
Reply-To: Maarten Ballintijn <maartenb@xs4all.nl>
In-Reply-To: <3CA37778.9090009@fourelle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The same thing is happening on our Tyan S2460 motherboards, running 
2.4.19-pre4-ac2.  IIRC it is the BIOS that sets these strings.
Maybe it is fixed in the latest BIOS update ? (I have not been
brave enough to upgrade them)

	Regards,

	Maarten Ballintijn.

On Thu, Mar 28, 2002 at 12:05:12PM -0800, Adam D Scislowicz wrote:
> I am working with several SMP Athlon machines, and they are all 
> reporting the first CPUs
> model ID(*** called 'model name' in /proc/cpuinfo) as 'AMD Athlon(tm) MP 
> 1800+' and the
> second CPUs model ID as 'AMD Athlon(tm) Processor'.
> 
>  From looking at the code it seems that the model IDs are obtained using 
> cpuid calls. Does
> anyone have insight into this?
> 
> Some Info:
>     Motherboard: Tyan S2462NG
>     CPUs: 2 Athlon MP 1800+
>     Kernel Version: 2.4.18-rc4
> 
> Adam Scislowicz
> Soft. Engineer
> Fourelle Systems, Inc.
> P.S: Please CC me in response.
> 
> *** Extra Info ***
> ---------------------------------------------
> - bash-2.04# cat /proc/cpuinfo -
> --------------------------------
> processor    : 0
> vendor_id    : AuthenticAMD
> cpu family    : 6
> model        : 6
> model name    : AMD Athlon(tm) MP 1800+
> stepping    : 2
> cpu MHz        : 1526.541
> cache size    : 256 KB
> fdiv_bug    : no
> hlt_bug        : no
> f00f_bug    : no
> coma_bug    : no
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 1
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
> cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> bogomips    : 3047.42
> 
> processor    : 1
> vendor_id    : AuthenticAMD
> cpu family    : 6
> model        : 6
> model name    : AMD Athlon(tm) Processor
> stepping    : 2
> cpu MHz        : 1526.541
> cache size    : 256 KB
> fdiv_bug    : no
> hlt_bug        : no
> f00f_bug    : no
> coma_bug    : no
> fpu        : yes
> fpu_exception    : yes
> cpuid level    : 1
> wp        : yes
> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
> cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
> bogomips    : 3047.42
> 
> -----------------------
> - bash-2.04# dmesg -
> --------------------
> Linux version 2.4.18-rc4 (root@r2bm.fourelle.com) (gcc version 2.96 
> 20000731 (Red Hat Linux 7.1 2.96-85)) #6 SMP Mon Mar 18 12:04:07 PST 2002
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
>  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e4800 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 0000000040000000 (usable)
>  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> 128MB HIGHMEM available.
> found SMP MP-table at 000f74d0
> hm, page 000f7000 reserved twice.
> hm, page 000f8000 reserved twice.
> hm, page 0009f000 reserved twice.
> hm, page 000a0000 reserved twice.
> On node 0 totalpages: 262144
> zone(0): 4096 pages.
> zone(1): 225280 pages.
> zone(2): 32768 pages.
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
> OEM ID: TYAN     Product ID: GUINNESS     APIC at: 0xFEE00000
> Processor #1 Pentium(tm) Pro APIC version 16
> Processor #0 Pentium(tm) Pro APIC version 16
> I/O APIC #2 Version 17 at 0xFEC00000.
> Processors: 2
> Kernel command line: root=/dev/rd/0 rd_size=98304  mem=1048576K
> Initializing CPU#0
> Detected 1526.541 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 3047.42 BogoMIPS
> Memory: 1005116k/1048576k available (1236k kernel code, 43072k reserved, 
> 340k data, 228k init, 131072k highmem)
> Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
> Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
> Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
> CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 256K (64 bytes/line)
> CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
> CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> mtrr: detected mtrr type: Intel
> CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 256K (64 bytes/line)
> CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
> Intel machine check reporting enabled on CPU#0.
> CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
> CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
> CPU0: AMD Athlon(tm) MP 1800+ stepping 02
> per-CPU timeslice cutoff: 731.31 usecs.
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Booting processor 1/0 eip 2000
> Initializing CPU#1
> masked ExtINT on CPU#1
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Calibrating delay loop... 3047.42 BogoMIPS
> CPU: Before vendor init, caps: 0383fbff c1cbfbff 00000000, vendor = 2
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 256K (64 bytes/line)
> CPU: After vendor init, caps: 0383fbff c1cbfbff 00000000 00000000
> Intel machine check reporting enabled on CPU#1.
> CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
> CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
> CPU1: AMD Athlon(tm) Processor stepping 02
> Total of 2 processors activated (6094.84 BogoMIPS).
> ...
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
