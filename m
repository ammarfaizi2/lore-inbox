Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265686AbSJSV6z>; Sat, 19 Oct 2002 17:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265687AbSJSV6z>; Sat, 19 Oct 2002 17:58:55 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:1804 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S265686AbSJSV6v>; Sat, 19 Oct 2002 17:58:51 -0400
Date: Sat, 19 Oct 2002 15:02:46 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Christian Borntraeger <linux@borntraeger.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ide-related kernel panic in 2.4.19 and 2.4.20-pre11
In-Reply-To: <E182zTn-0005zB-00@mrelayng3.kundenserver.de>
Message-ID: <Pine.LNX.4.10.10210191451530.24031-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So could you ask the question a little more blunt?

"Gee, I am trying to break a US Law on content protection, would you be my
enabler?  Don't worry, it only effects the US, and we are in a public
forum.  Also, do you prefer gray or black in your future pin stripped
suit?"

Now if it works in 2.4.18, use it.

If there is a technical issue like loading both ide-cd and ide-scsi on the
same device, that is a problem.  There have been no changes to ide-scsi in
2.4.19 by me directly.  Currently all updates to "stable" are released
through Alan Cox, come to think of it so are any releases to "unstable".

Have a little more sense about asking about "copy-protected" media in a
public forum, and DON'T !!  Regardless if I could answer the question, you
have placed me in a position where I can not now.

I should have ignored this and issued a reply.


On Sat, 19 Oct 2002, Christian Borntraeger wrote:

> PROBLEM: ide-related kernel panic in 2.4.19 and 2.4.20-pre11
> 
> Trying to read a copy-protected audio CD (I think Cactus Data Shield 200) with
> readcd I get a reproduceable kernel panic in 2.4.19 and 2.4.20-pre11.
> As I can reproduce the bug feel free to ask me any further question, if possible
> cc me. (Otherwise it will take a little longer)
> The information I gathered is below.
> some more files (system.map etc) are on 
> http://www.cborntraeger.de/linux/panic.tgz
> 
> cheers
> 
> Christian
>  
> -------------------------------------------------
> I send the panic through ksymoops:
> -------------------------------------------------
> 
> ksymoops 2.4.5 on i686 2.4.20-pre11.  Options used
>      -V (default)
>      -k ksyms (specified)
>      -l modules (specified)
>      -o /lib/modules/2.4.20-pre11/ (default)
>      -m System.map (specified)
> 
> Warning (compare_maps): ksyms_base symbol __io_virt_debug_R__ver___io_virt_debug not found in System.map.  Ignoring ksyms_base entry
> Unable to handle Kernel Null pointer dereference at virtual address 00000018
> f08968f8
> CPU 0
> EFLAGS: 00010286
> eax: ee88e1c4 ebx: c0322f24 ecx: ebedcb64 edx: 0000005a
> esi: 00000000 edi: 00000040 ebp: c02a9e74 esp: c02a9e50
> 00000000 c01da5dc 000003e8 00000046 00000082 ee88e1c4 00000000 c0322f24
> 00000040 c02a9eac c01da999 c0322f24 00000000 00000000 00000000 000001f4
> c02a9ec0 00000000 c0322da4 00000001 c0322f24 c18f218c c0322da4 c02a9ed0
> Call Trace: [<c01da5dc>] [<c01dab78>] [<c01dae54>] [<c01dad60>] [<c0124ba3>] 
>             [<c012432d>] [<c0120c0f>] [<c0120b26>] [<c0120957>] [<c010a74d>]
>             [<c010cc18>] [<c01070c3>] [<c01145e6>] [<c0114530>] [<c0107132>]
>             [<c0105000>]
> Code: 8b 56 18 c7 45 ec 00 00 00 00 89 70 04 8b 7e 0c 8b 46 1c c7
> Using defaults from ksymoops -t elf32-i386 -a i386
> 
> 
> >>eax; ee88e1c4 <_end+2e55d100/304e7fbc>
> >>ebx; c0322f24 <ide_hwifs+4c4/20a8>
> >>ecx; ebedcb64 <_end+2bbabaa0/304e7fbc>
> >>ebp; c02a9e74 <init_task_union+1e74/2000>
> >>esp; c02a9e50 <init_task_union+1e50/2000>
> 
> Trace; c01da5dc <ide_wait_stat+bc/120>
> Trace; c01dab78 <ide_do_request+c8/1b0>
> Trace; c01dae54 <ide_timer_expiry+f4/1c0>
> Trace; c01dad60 <ide_timer_expiry+0/1c0>
> Trace; c0124ba3 <run_timer_list+f3/160>
> Trace; c012432d <update_wall_time+d/40>
> Trace; c0120c0f <bh_action+1f/40>
> Trace; c0120b26 <tasklet_hi_action+46/70>
> Trace; c0120957 <do_softirq+97/a0>
> Trace; c010a74d <do_IRQ+bd/f0>
> Trace; c010cc18 <call_do_IRQ+5/d>
> Trace; c01070c3 <default_idle+23/30>
> Trace; c01145e6 <apm_cpu_idle+b6/150>
> Trace; c0114530 <apm_cpu_idle+0/150>
> Trace; c0107132 <cpu_idle+42/60>
> Trace; c0105000 <_stext+0/0>
> 
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
> Code;  00000000 Before first symbol
>    0:   8b 56 18                  mov    0x18(%esi),%edx
> Code;  00000003 Before first symbol
>    3:   c7 45 ec 00 00 00 00      movl   $0x0,0xffffffec(%ebp)
> Code;  0000000a Before first symbol
>    a:   89 70 04                  mov    %esi,0x4(%eax)
> Code;  0000000d Before first symbol
>    d:   8b 7e 0c                  mov    0xc(%esi),%edi
> Code;  00000010 Before first symbol
>   10:   8b 46 1c                  mov    0x1c(%esi),%eax
> Code;  00000013 Before first symbol
>   13:   c7 00 00 00 00 00         movl   $0x0,(%eax)
> 
> Kernel Panic, Aiee..
> 
> 1 warning issued.  Results may not be reliable.
> ---------------------------------------------------
> /proc/modules:
> ---------------------------------------------------
> 
> usbmouse                2264   0 (unused)
> keybdev                 2080   0 (unused)
> mousedev                4244   1
> hid                    19300   0 (unused)
> input                   3584   0 [usbmouse keybdev mousedev hid]
> ide-scsi                8816   0
> scsi_mod               56276   1 [ide-scsi]
> ide-cd                 30148   0
> cdrom                  28608   0 [ide-cd]
> usb-uhci               23020   0 (unused)
> usbcore                60960   1 [usbmouse hid usb-uhci]
> rtc                     6940   0 (autoclean)
> 
> -----------------------------------------------
> ver-linux
> ----------------------------------------------- 
> Linux cubus.mynet 2.4.20-pre11 #3 Sat Oct 19 18:50:52 BST 2002 i686 unknown unknown GNU/Linux
>  
> Gnu C                  3.2
> Gnu make               3.79.1
> util-linux             2.11u
> mount                  2.11u
> modutils               2.4.19
> e2fsprogs              1.27ea
> reiserfsprogs          3.6.3
> PPP                    2.4.1
> Linux C Library        2.2.5
> Dynamic linker (ldd)   2.2.5
> Procps                 2.0.7
> Net-tools              1.60
> Console-tools          0.2.3
> Sh-utils               2.0.15
> Modules Loaded         usbmouse keybdev mousedev hid input ide-scsi scsi_mod ide-cd cdrom usb-uhci usbcore rtc
> 
> -------------------------------------------------
> /proc/scsi/scsi
> -------------------------------------------------
> Attached devices: 
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: SONY     Model: CD-RW  CRX140E   Rev: 1.0p
>   Type:   CD-ROM                           ANSI SCSI revision: 02
> 

Andre Hedrick
LAD Storage Consulting Group

