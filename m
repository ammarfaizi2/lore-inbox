Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313923AbSDFCRJ>; Fri, 5 Apr 2002 21:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313924AbSDFCQ7>; Fri, 5 Apr 2002 21:16:59 -0500
Received: from 12-234-33-29.client.attbi.com ([12.234.33.29]:14404 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S313923AbSDFCQr>; Fri, 5 Apr 2002 21:16:47 -0500
From: brian@worldcontrol.com
Date: Fri, 5 Apr 2002 18:13:55 -0800
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre5-ac3 w/swsusp oops
Message-ID: <20020406021355.GA7553@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200204051945.g35JjnX23183@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-No-Archive: yes
X-Noarchive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 02:45:49PM -0500, Alan Cox wrote:
> Ok its fun time. This adds the software suspend code. Its not perfect yet and
> a lot of drivers need power management support to work nicely with it. This
> is one of the things we have to handle for future ACPI work so its good to
> give people a platform for checking their PM code.

I had to type it in my hand from a digital photograph.

The actually picture of the oops is available at

    http://www.litzinger.com/opps-swsusp.jpg (its large 464576 bytes)


ksymoops 2.4.0 on i686 2.4.19-pre5-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre5-ac3/ (default)
     -m /boot/System.map-2.4.19-pre5-ac3 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says d8833fb4, /lib/modules/2.4.19-pre5-ac3/kernel/drivers/usb/usbcore.o says d8833a74.  Ignoring /lib/modules/2.4.19-pre5-ac3/kernel/drivers/usb/usbcore.o entry
c013897b
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013897b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010293
eax: ffffffff    ebx: d5e32540   ecx: 00000000    edx: c14c4334
esi: 00000000    edi: 00001000   ebp: 00000001    esp: d7f77e14
ds: 0018    es: 0018    ss: 0018
Process bdflush (pid: 5, stackpage=d7f77000)
Stack: d5e32540 c0138a10 d5e23540 c14c4334 00000000 6e6d6c6b 7271706f 76757573
       7a797877 c14c4334 00000306 d7f77ea4 00001000 c0138bf6 c14c4334 00001000
       00000001 c14c4334 d7772000 c013a1b7 c14c4334 00000306 00001000 c14c4334
Call Trace: [<c0138a01>] [<c0138bf6>] [<c013a1b7>] [<c0130269>] [<c01167f6>]
   [<c0130357>] [<c0122ebe>] [<c0116ae4>] [<c012382f>] [<c0116ae4>] [<c0122cae>]
   [<c0123a0b>] [<c0123eb2>] [<c011a989>] [<c013a995>] [<c0105000>] [<c0105000>]
   [<c0106f66>] [<c013a910>]
Code: 2b 90 c8 00 00 00 69 d2 c5 4e ec c4 c1 fa 02 c1 e2 0c 03 90

>>EIP; c013897b <set_bh_page+2b/50>   <=====
Trace; c0138a01 <create_buffers+61/f0>
Trace; c0138bf6 <create_empty_buffers+16/60>
Trace; c013a1b7 <brw_page+37/d0>
Trace; c0130269 <rw_swap_page_base+f9/110>
Trace; c01167f6 <__call_console_drivers+46/60>
Trace; c0130357 <rw_swap_page_nolock+67/90>
Trace; c0122ebe <write_suspend_image+11e/360>
Trace; c0116ae4 <printk+104/110>
Trace; c012382f <suspend_save_image+16f/1a0>
Trace; c0116ae4 <printk+104/110>
Trace; c0122cae <read_swapfiles+6e/100>
Trace; c0123a0b <do_magic_suspend_2+b/b0>
Trace; c0123eb2 <do_software_suspend+62/c0>
Trace; c011a989 <__run_task_queue+49/60>
Trace; c013a995 <bdflush+85/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0106f66 <kernel_thread+26/30>
Trace; c013a910 <bdflush+0/c0>
Code;  c013897b <set_bh_page+2b/50>
00000000 <_EIP>:
Code;  c013897b <set_bh_page+2b/50>   <=====
   0:   2b 90 c8 00 00 00         sub    0xc8(%eax),%edx   <=====
Code;  c0138981 <set_bh_page+31/50>
   6:   69 d2 c5 4e ec c4         imul   $0xc4ec4ec5,%edx,%edx
Code;  c0138987 <set_bh_page+37/50>
   c:   c1 fa 02                  sar    $0x2,%edx
Code;  c013898a <set_bh_page+3a/50>
   f:   c1 e2 0c                  shl    $0xc,%edx
Code;  c013898d <set_bh_page+3d/50>
  12:   03 90 00 00 00 00         add    0x0(%eax),%edx


3 warnings issued.  Results may not be reliable.

Anything else you'd like to know?
