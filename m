Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132525AbQKXJ7Z>; Fri, 24 Nov 2000 04:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132608AbQKXJ7Q>; Fri, 24 Nov 2000 04:59:16 -0500
Received: from kendy.up.ac.za ([137.215.101.101]:16142 "EHLO kendy.up.ac.za")
        by vger.kernel.org with ESMTP id <S132525AbQKXJ7A>;
        Fri, 24 Nov 2000 04:59:00 -0500
Message-ID: <3A1E3206.114A8A9@suntiger.ee.up.ac.za>
Date: Fri, 24 Nov 2000 11:16:54 +0200
From: Justin Schoeman <justin@suntiger.ee.up.ac.za>
Reply-To: justin@suntiger.ee.up.ac.za
Organization: University of Pretoria
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Freitag <macrotron@president.eu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: bttv crashes kernel 2.4.0testX on a Vodoo3 2000
In-Reply-To: <20001124112338.A523@BOFH.president.eu.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the VIA chipset you should use the "triton1=1" module option.
(Well, at least it worked for me!)

-justin

Hans Freitag wrote:
> 
> Hi,
> 
> [1.] One line summary of the problem:
>         bttv crashes kernel 2.4.0testX on a Vodoo3 2000
> 
> [2.] Full description of the problem/report:
>         If I use 24bit Color depth my system crashes on Displaying
>         fullscreen TV, on my Vodoo3 2000. I use a Terratec/Vobis
>         TV Boostar BT848 Framegrabber Card.
> 
> [3.] Keywords (i.e., modules, networking, kernel):
>         bttv, Vodoo3, crash
> 
> [4.] Kernel version (from /proc/version):
>         Linux version 2.4.0-test10 (root@BOFH) (gcc version egcs-2.91.66\
>         19990314/Linux (egcs-1.1.2 release)) #2 Sat Nov 11 10:25:41 \
>         /etc/localtime 2000
> 
> [5.] Output of Oops.. message (if applicable) with symbolic information
>      resolved (see Documentation/oops-tracing.txt)
> [6.] A small shell script or example program which triggers the
>      problem (if possible)
>         xawtv -f
> 
> [7.] Environment
> [7.1.] Software (add the output of the ver_linux script here)
>         Framebuffer with 24 bpp
>         or
>         X11 with 24 bpp
> 
> [7.2.] Processor information (from /proc/cpuinfo):
>         processor       : 0
>         vendor_id       : AuthenticAMD
>         cpu family      : 5
>         model           : 8
>         model name      : AMD-K6(tm) 3D processor
>         stepping        : 12
>         cpu MHz         : 350.000805
>         cache size      : 64 KB
>         fdiv_bug        : no
>         hlt_bug         : no
>         sep_bug         : no
>         f00f_bug        : no
>         coma_bug        : no
>         fpu             : yes
>         fpu_exception   : yes
>         cpuid level     : 1
>         wp              : yes
>         flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mmx 3dnow
>         bogomips        : 699.60
> 
> 
> [7.3.] Module information (from /proc/modules):
>         cs4232                  3024  15
>         ad1848                 17216   0 [cs4232]
>         uart401                 6448   0 [cs4232]
>         sound                  57552   1 [cs4232 ad1848 uart401]
>         soundcore               3952   4 [sound]
>         bttv                   54192   0
>         msp3400                12624   0 (unused)
>         tuner                   3024   1
>         i2c-algo-bit            7232   1 [bttv]
>         i2c-dev                 3648   0 (unused)
>         i2c-core               12464   0 [bttv msp3400 tuner i2c-algo-bit i2c-dev]
>         videodev                4576   2 [bttv]
> 
> 
> [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
>         0000-001f : dma1
>         0020-003f : pic1
>         0040-005f : timer
>         0060-006f : keyboard
>         0070-007f : rtc
>         0080-008f : dma page reg
>         00a0-00bf : pic2
>         00c0-00df : dma2
>         00f0-00ff : fpu
>         0170-0177 : ide1
>         01f0-01f7 : ide0
>         0213-0213 : isapnp read
>         02f8-02ff : serial(auto)
>         0340-035f : NE2000
>         0376-0376 : ide1
>         0378-037a : parport0
>         03c0-03df : vesafb
>         03f6-03f6 : ide0
>         03f8-03ff : serial(auto)
>         0530-0533 : Crystal audio controller
>         0a79-0a79 : isapnp write
>         0cf8-0cff : PCI conf1
>         5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
>         d000-dfff : PCI Bus #01
>           d000-d0ff : 3Dfx Interactive, Inc. Voodoo 3
>         e000-e00f : VIA Technologies, Inc. Bus Master IDE
>           e000-e007 : ide0
>           e008-e00f : ide1
>         e800-e8ff : Macronix, Inc. [MXIC] MX987x5
>           e800-e8ff : eth0
> 
> 
> 00000000-0009fbff : System RAM
> 0009fc00-0009ffff : System RAM
> 000a0000-000bffff : Video RAM area
> 000c0000-000c7fff : Video ROM
> 000f0000-000fffff : System ROM
> 00100000-07feffff : System RAM
> 00100000-002fd5b7 : Kernel code
>   002fd5b8-0031b7a3 : Kernel data
>   07ff0000-07ff2fff : ACPI Non-volatile Storage
>   07ff3000-07ffffff : ACPI Tables
> e0000000-e3ffffff : VIA Technologies, Inc. VT82C597 [Apollo VP3]
>   e4000000-e7ffffff : PCI Bus #01
> e4000000-e5ffffff : 3Dfx Interactive, Inc. Voodoo 3
>   e8000000-e9ffffff : PCI Bus #01
> e8000000-e9ffffff : 3Dfx Interactive, Inc. Voodoo 3
>    e8000000-e8ffffff : vesafb
> eb000000-eb0000ff : Macronix, Inc. [MXIC] MX987x5
>    eb000000-eb0000ff : eth0
> eb001000-eb001fff : Brooktree Corporation Bt848 TV with DMA push
>    eb001000-eb001fff : bttv
> ffff0000-ffffffff : reserved
> 
> 
> [7.5.] PCI information ('lspci -vvv' as root)
> 
> PCI devices found:
>   Bus  0, device   0, function  0:
>     Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 4).
>       Master Capable.  Latency=16.
>       Prefetchable 32 bit memory at 0xe0000000 [0xe3ffffff].
>   Bus  0, device   1, function  0:
>     PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (rev 0).
>       Master Capable.  No bursts.  Min Gnt=12.
>   Bus  0, device   7, function  0:
>     ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 71).
>   Bus  0, device   7, function  1:
>     IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
>       Master Capable.  Latency=64.
>       I/O at 0xe000 [0xe00f].
>   Bus  0, device   7, function  3:
>     Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 16).
>   Bus  0, device   9, function  0:
>     Ethernet controller: Macronix, Inc. [MXIC] MX987x5 (rev 37).
>       IRQ 10.
>       Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
>       I/O at 0xe800 [0xe8ff].
>       Non-prefetchable 32 bit memory at 0xeb000000 [0xeb0000ff].
>   Bus  0, device  10, function  0:
>     Multimedia video controller: Brooktree Corporation Bt848 TV with DMA push (rev 18).
>       IRQ 12.
>       Master Capable.  Latency=64.  Min Gnt=16.Max Lat=40.
>       Prefetchable 32 bit memory at 0xeb001000 [0xeb001fff].
>   Bus  1, device   0, function  0:
>     VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 1).
>       IRQ 11.
>       Non-prefetchable 32 bit memory at 0xe4000000 [0xe5ffffff].
>       Prefetchable 32 bit memory at 0xe8000000 [0xe9ffffff].
>       I/O at 0xd000 [0xd0ff].
> 
> [7.6.] SCSI information (from /proc/scsi/scsi)
> [7.7.] Other information that might be relevant to the problem
>        (please look in /proc and include all information that you
>        think to be relevant):
> [X.] Other notes, patches, fixes, workarounds:
> 
>         It works on kernel 2.2x with 24bpp.
>         If I use 16bpp, it runs stable.
> 
> 
> --
> W.O.R.L.D.: Worker Optimized for Repair and Logical Destruction
> ******** PGP/GPG keys available at wwwkeys.eu.pgp.net *********
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
