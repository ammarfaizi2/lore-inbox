Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293229AbSCFFJF>; Wed, 6 Mar 2002 00:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293234AbSCFFI4>; Wed, 6 Mar 2002 00:08:56 -0500
Received: from [198.16.16.39] ([198.16.16.39]:56988 "EHLO carthage")
	by vger.kernel.org with ESMTP id <S293229AbSCFFIu>;
	Wed, 6 Mar 2002 00:08:50 -0500
Date: Tue, 5 Mar 2002 23:03:49 -0600
From: James Curbo <jcurbo@acm.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: a couple of USB related Oopses
Message-ID: <20020306050349.GA1152@carthage>
Reply-To: James Curbo <jcurbo@acm.org>
In-Reply-To: <20020305184604.GA4590@carthage> <20020305192307.GB10151@kroah.com> <20020305193317.GA5339@carthage> <20020305193732.GC10151@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20020305193732.GC10151@kroah.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Debian GNU/Linux
Organization: Henderson State University, Arkadelphia, AR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ah, I tried it with 2.5.6-pre2 and usb-uhci.. still got a panic, when I
tried to print to the printer (which is what I was doing before too) 
Also, got these in my kernel log...

usb-uhci.c: ENXIO 80000200, flags 0, urb c1523ac0, burb c1523a40
usb-uhci.c: ENXIO 80000200, flags 0, urb d7983c40, burb d7983bc0
usb-uhci.c: ENXIO 80000200, flags 0, urb d7983c40, burb d7983bc0
usb-uhci.c: ENXIO 80000280, flags 0, urb d7831540, burb d7983bc0
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb d7831540, burb d7983bc0
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb d7831540, burb d7983bc0
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb d76b2840, burb d7983bc0
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb d76b2840, burb d7983bc0
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb d76b2840, burb d7983bc0
usbfs: USBDEVFS_CONTROL failed dev 2 rqt 128 rq 6 len 18 ret -6
usb-uhci.c: ENXIO 80000280, flags 0, urb d76b2ac0, burb d7983bc0
usb-uhci.c: ENXIO 80000280, flags 0, urb d76b2ac0, burb d7983bc0
usb-uhci.c: ENXIO 80000280, flags 0, urb d76b2ac0, burb d7983bc0
usb-uhci.c: ENXIO 80000280, flags 0, urb d76b2ac0, burb d7983bc0

Does that mean anything to you guys?

-- 
James Curbo <jcurbo@acm.org> <jc108788@rc.hsu.edu>
Undergraduate Computer Science, Henderson State University
PGP Keys at <http://reddie.henderson.edu/~curboj/>
Public Keys: PGP - 1024/0x76E2061B GNUPG - 1024D/0x3EEA7288

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops-output-4.txt"

ksymoops 2.4.3 on i686 2.5.6-pre2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.6-pre2/ (default)
     -m /boot/System.map-2.5.6-pre2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol idle_cpu_R__ver_idle_cpu not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Reading Oops report from the terminal
Unable to handle kernel paging request at virtual address 0100005e
c020a07f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c020a07f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00ffff92   ebx: d7b281c0   ecx: d7b281dc   edx: cff7a000
esi: 00000000   edi: d34391c0   ebp: ffffffed   esp: cff7bf00
ds: 0018   es: 0018   ss: 0018
Stack: c021ab5a d7b281dc 000001f0 c02de900 c02df100 d34391c0 c020bd98 d6cc90c0 
       d34391c0 cff7a000 d34391c0 00000000 d6cc90c0 c0136d2f d6cc90c0 d34391c0 
       d34391c0 d6cc90c0 00000000 c142e380 c0135761 d6cc90c0 d34391c0 00000000 
Call Trace: [<c021ab5a>] [<c020bd98>] [<c0136d2f>] [<c0135761>] [<c0135672>] 
   [<c0135a57>] [<c0108a1f>] 
Code: 8b 80 cc 00 00 00 85 c0 74 17 8b 50 18 85 d2 74 10 8b 44 24 

>>EIP; c020a07e <usb_submit_urb+e/40>   <=====
Trace; c021ab5a <usblp_open+ba/110>
Trace; c020bd98 <usb_open+68/d0>
Trace; c0136d2e <chrdev_open+5e/a0>
Trace; c0135760 <dentry_open+e0/190>
Trace; c0135672 <filp_open+52/60>
Trace; c0135a56 <sys_open+36/80>
Trace; c0108a1e <syscall_call+6/a>
Code;  c020a07e <usb_submit_urb+e/40>
00000000 <_EIP>:
Code;  c020a07e <usb_submit_urb+e/40>   <=====
   0:   8b 80 cc 00 00 00         mov    0xcc(%eax),%eax   <=====
Code;  c020a084 <usb_submit_urb+14/40>
   6:   85 c0                     test   %eax,%eax
Code;  c020a086 <usb_submit_urb+16/40>
   8:   74 17                     je     21 <_EIP+0x21> c020a09e <usb_submit_urb+2e/40>
Code;  c020a088 <usb_submit_urb+18/40>
   a:   8b 50 18                  mov    0x18(%eax),%edx
Code;  c020a08a <usb_submit_urb+1a/40>
   d:   85 d2                     test   %edx,%edx
Code;  c020a08c <usb_submit_urb+1c/40>
   f:   74 10                     je     21 <_EIP+0x21> c020a09e <usb_submit_urb+2e/40>
Code;  c020a08e <usb_submit_urb+1e/40>
  11:   8b 44 24 00               mov    0x0(%esp,1),%eax


3 warnings issued.  Results may not be reliable.

--SUOF0GtieIMvvwua--
