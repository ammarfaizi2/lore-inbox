Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272246AbTHBItu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 04:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272404AbTHBItu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 04:49:50 -0400
Received: from ns1.greycloaklabs.ca ([216.232.118.71]:1805 "EHLO
	gateway.greycloaklabs.ca") by vger.kernel.org with ESMTP
	id S272557AbTHBIto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 04:49:44 -0400
Date: Sat, 2 Aug 2003 01:53:24 -0700 (PDT)
From: Matthew Peters <matthew@greycloaklabs.ca>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kswapd and toshiba libretto 50ct
In-Reply-To: <20030802063755.GA679@alpha.home.local>
Message-ID: <Pine.LNX.4.44.0308020140130.1115-100000@gateway.greycloaklabs.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it's not possible to change the laptop back to 75mhz... the process to
overclock it was to clip one of it's pins on the clock chip itself...

I have done many things on the laptop. I often compile things for GBA and
MSP430, i would've found any problem in those quite quickly. I have also
used povray on the CPU, also something that would show any problems with
the processor.

As for the database corruption; When talking with my brother, who's much
more knowledgable in linux, he pointed to a bug in the 2.2 kernels that
would corrupt or loose files when the system crashed.

I highly doubt the cpu would be at fault with this... there are no other
glitches past the problems with the database.

Now, one other problem that i have been having, and i thought it best to
go to a 2.4 kernel to try and fix it, is a second-long delay before
sending serial data... this has been seen with all programs i've tested on
the hardware, and is never around on other hardware.

thanks
    Matthew


On Sat, 2 Aug 2003, Willy Tarreau wrote:

> Matthew,
>
> perhaps kernel 2.4 puts more stress on your _overclocked_ CPU than 2.2 did,
> rendering it unusable. BTW, you said you got a database corruption and you
> felt it was kernel 2.2's fault... I guess there are more people who get
> problems with excessive overclocking than those getting problems with kernel
> 2.2 !
>
> I _have_ already overclocked several pentiums 75 in the past, some of them
> could even run at 120 MHz. The least I could say is that this processor is the
> worst reliable overclocker because it _seems_ to work but you still get a few
> glitches in very specific applications. I had people tell me that they were
> used to set it back to 75 to run photoshop, but "everything else runs just
> fine" ! And it doesn't support aging very well, and must be set back to its
> original speed after several months (or you need to considerably raise the
> voltage).
>
> So I would say : please set this CPU to 75 MHz and test 2.4 again on it. IF
> you still have problems, THEN you can get back here to seek some help. But
> don't hope for much help under these stupid conditions.
>
> Willy
>
> On Fri, Aug 01, 2003 at 05:50:47PM -0700, Matthew Peters wrote:
> > there are a few problems with 2.4 and 2.5 kernels that make them unusable
> > on a Toshiba Libretto. If i select a kernel made for Pentium Classic, it
> > unpacks the kernel, then just sits there. If i use a 386 kernel, it works
> > till it gets to kswapd. Now, i haven't accually checked with other kernels
> > on if this is in fact where it crashes, but i seem to remember it being
> > this.
> >
> > the kernel version that this oops message came from was the 2.4.21 for 386
> > with debian patches. This is one of the kernel packages in unstable
> > debian. I also have the pcmcia package installed.
> >
> > The hardware that i'm trying to get this to run on is a Toshiba Libretto
> > 50CT. This is a Pentium 75(over clocked to 100) with 16 megs of ram. The
> > sound chip is an OPL3-SA2, with a CT-65550 graphics chip. The hd is a
> > toshiba MK2018GAS(upgraded). It has non-cardbus PCMCIA.
> >
> > The 2.2 kernels work fine, and i've been using them for a year or so... i
> > just had to re-install because of my package database getting corrupted,
> > and figured it was because of the 2.2 kernel... i have no proof of this.
> >
> > It was not possible to use ksymoops on the libretto because it did not
> > compleate loading, so the info in the output might be incorrect.
> >
> > Currently, the install is working on a P3 system.
> >
> > i can go back to a 2.2 kernel and get the cpu info and any other info that
> > might be required.
> >
> > Thanks in advance
> >     Matthew Peters
>
> > ksymoops 2.4.8 on i686 2.4.21-3-386.  Options used
> >      -V (default)
> >      -k /proc/ksyms (default)
> >      -l /proc/modules (default)
> >      -o /lib/modules/2.4.21-3-386/ (default)
> >      -m /boot/System.map-2.4.21-3-386 (default)
> >
> > Warning: You did not tell me where to find symbol information.  I will
> > assume that the log matches the kernel and modules that are running
> > right now and I'll use the default options above for symbol resolution.
> > If the current kernel and/or modules do not match the log, you can get
> > more accurate output by telling me the kernel version and where to find
> > map, modules, ksyms etc.  ksymoops -h explains the options.
> >
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/fs/ext3/ext3.o for module ext3 has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/fs/jbd/jbd.o for module jbd has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/ide-probe-mod.o for module ide-probe-mod has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/via82cxxx.o for module via82cxxx has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/trm290.o for module trm290 has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/triflex.o for module triflex has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/slc90e66.o for module slc90e66 has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/sis5513.o for module sis5513 has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/siimage.o for module siimage has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/serverworks.o for module serverworks has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/sc1200.o for module sc1200 has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/rz1000.o for module rz1000 has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/piix.o for module piix has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/pdc202xx_old.o for module pdc202xx_old has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/opti621.o for module opti621 has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/ns87415.o for module ns87415 has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/hpt366.o for module hpt366 has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/ide-disk.o for module ide-disk has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/hpt34x.o for module hpt34x has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/generic.o for module generic has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/cy82c693.o for module cy82c693 has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/cs5530.o for module cs5530 has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/cmd64x.o for module cmd64x has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/cmd640.o for module cmd640 has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/amd74xx.o for module amd74xx has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/alim15x3.o for module alim15x3 has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/aec62xx.o for module aec62xx has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/adma100.o for module adma100 has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/pci/pdc202xx_new.o for module pdc202xx_new has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/drivers/ide/ide-mod.o for module ide-mod has changed since load
> > Warning (expand_objects): object /lib/modules/2.4.21-3-386/kernel/net/unix/unix.o for module unix has changed since load
> >  <1>Unable to handle kernel paging request at virtual address 61d707f0
> > c0125056
> > *pde = 00000000
> > Oops: 0000
> > CPU:    0
> > EIP:    0010:[<c0125056>]    Not tainted
> > Using defaults from ksymoops -t elf32-i386 -a i386
> > EFLAGS: 00010086
> > eax: c002e0a8   ebx: c021c030   ecx: 00000020   edx: ffffffff
> > esi: 61d707f0   edi: 00000008   edp: 00000001   esp: c02b5eb8
> > Warning (Oops_set_regs): garbage 'edp: 00000001   esp: c02b5eb8' at end of register line ignored
> > ds: 0018  es: 0018  ss: 0018
> > Process kswapd (pid: 4, stackpage=c02b5000)
> > Stack: c0474570 c0dad850 c017ef3f c0474570 00000001 c0dad850 c2024af0 00000046
> >        00000001 c2045c14 c0dad850 00000001 c2024af0 c0dad850 00000008 00000000
> >        00000008 c204525f c2024af0 00000001 c0033160 c2024af0 00000002 c2024a40
> > Call Trace:    [<c017ef3f>] [<c2024af0>] [<c2045c15>] [<c2024af0>] [<c204525f>]
> >   [<c2024af0>] [<c2024af0>] [<c2024a40>] [<c201b036>] [<c2024af0>] [<c2045170>]
> >   [<c0109834>] [<c0109974>] [<c010bcc0>] [<c2024b00>] [<c017e074>] [<c01197c0>]
> >   [<c2024b00>] [<c2024b58>] [<c2024b58>] [<c012af3e>] [<c0105000>] [<c0106ff7>]
> >   [<c012ae9c>]
> > Code: 39 36 75 06 5b 5e c3 8d 76 00 5b 89 f0 31 c9 ba 03 00 00 00
> >
> >
> > >>EIP; c0125056 <unlock_page+56/70>   <=====
> >
> > >>ebx; c021c030 <contig_page_data+b0/340>
> >
> > Trace; c017ef3f <end_that_request_first+3b/bc>
> > Trace; c2024af0 <_end+1d835c4/1856bb34>
> > Trace; c2045c15 <_end+1da46e9/1856bb34>
> > Trace; c2024af0 <_end+1d835c4/1856bb34>
> > Trace; c204525f <_end+1da3d33/1856bb34>
> > Trace; c2024af0 <_end+1d835c4/1856bb34>
> > Trace; c2024af0 <_end+1d835c4/1856bb34>
> > Trace; c2024a40 <_end+1d83514/1856bb34>
> > Trace; c201b036 <_end+1d79b0a/1856bb34>
> > Trace; c2024af0 <_end+1d835c4/1856bb34>
> > Trace; c2045170 <_end+1da3c44/1856bb34>
> > Trace; c0109834 <handle_IRQ_event+34/60>
> > Trace; c0109974 <do_IRQ+54/8c>
> > Trace; c010bcc0 <call_do_IRQ+5/d>
> > Trace; c2024b00 <_end+1d835d4/1856bb34>
> > Trace; c017e074 <generic_unplug_device+1c/28>
> > Trace; c01197c0 <__run_task_queue+48/54>
> > Trace; c2024b00 <_end+1d835d4/1856bb34>
> > Trace; c2024b58 <_end+1d8362c/1856bb34>
> > Trace; c2024b58 <_end+1d8362c/1856bb34>
> > Trace; c012af3e <kswapd+a2/b0>
> > Trace; c0105000 <_stext+0/0>
> > Trace; c0106ff7 <arch_kernel_thread+23/30>
> > Trace; c012ae9c <kswapd+0/b0>
> >
> > Code;  c0125056 <unlock_page+56/70>
> > 00000000 <_EIP>:
> > Code;  c0125056 <unlock_page+56/70>   <=====
> >    0:   39 36                     cmp    %esi,(%esi)   <=====
> > Code;  c0125058 <unlock_page+58/70>
> >    2:   75 06                     jne    a <_EIP+0xa>
> > Code;  c012505a <unlock_page+5a/70>
> >    4:   5b                        pop    %ebx
> > Code;  c012505b <unlock_page+5b/70>
> >    5:   5e                        pop    %esi
> > Code;  c012505c <unlock_page+5c/70>
> >    6:   c3                        ret
> > Code;  c012505d <unlock_page+5d/70>
> >    7:   8d 76 00                  lea    0x0(%esi),%esi
> > Code;  c0125060 <unlock_page+60/70>
> >    a:   5b                        pop    %ebx
> > Code;  c0125061 <unlock_page+61/70>
> >    b:   89 f0                     mov    %esi,%eax
> > Code;  c0125063 <unlock_page+63/70>
> >    d:   31 c9                     xor    %ecx,%ecx
> > Code;  c0125065 <unlock_page+65/70>
> >    f:   ba 03 00 00 00            mov    $0x3,%edx
> >
> >  <0>Kernel panic: Aiee, killing interrupt handler!
> >
> > 33 warnings issued.  Results may not be reliable.
>
>
>

