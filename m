Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263370AbUAYFCL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 00:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUAYFCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 00:02:11 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:26116 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263370AbUAYFB7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 00:01:59 -0500
X-Envelope-From: foton2@post.cz
From: David =?iso-8859-2?q?Posp=ED=B9il?= <foton2@post.cz>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1 Unable to handle kernel paging request
Date: Sun, 25 Jan 2004 06:01:41 +0100
User-Agent: KMail/1.5.4
References: <200401250424.21533.foton2@post.cz> <20040124203400.6dde63d0.akpm@osdl.org>
In-Reply-To: <20040124203400.6dde63d0.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200401250601.48095.foton2@post.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dne ne 25. ledna 2004 05:34 jste napsal(a):
> David Pospí__il <foton2@post.cz> wrote:
> > I was only listening the radio via internet, when computer totaly
> > crashed. I had to restart (my uptime was 9 days :-(  )
>
> This is ugly.
>
> >  Xfree, KDE, KMail, Mozilla, mplayer (radio),XMMS,mc and karamba were
> > running. This is my syslog :
> >  Jan 25 03:51:02 foton2 kernel: Unable to handle kernel paging request at
> >  virtual address 00200204
> >  Jan 25 03:51:02 foton2 kernel:  printing eip:
> >  Jan 25 03:51:02 foton2 kernel: c013bb35
> >  Jan 25 03:51:02 foton2 kernel: *pde = 00000000
> >  Jan 25 03:51:02 foton2 kernel: Oops: 0000 [#1]
> >  Jan 25 03:51:02 foton2 kernel: CPU:    0
> >  Jan 25 03:51:02 foton2 kernel: EIP:    0060:[<c013bb35>]    Tainted: P
> >  Jan 25 03:51:02 foton2 kernel: EFLAGS: 00010006
> >  Jan 25 03:51:02 foton2 kernel: EIP is at free_block+0x43/0xcb
> >  Jan 25 03:51:02 foton2 kernel: eax: 00672c30   ebx: 00200200   ecx:
> > e944e20c edx: c1000000
> >  Jan 25 03:51:02 foton2 kernel: esi: eff3f840   edi: 00000002   ebp:
> > eff3f84c esp: e21e5e98
> >  Jan 25 03:51:02 foton2 kernel: ds: 007b   es: 007b   ss: 0068
> >  Jan 25 03:51:02 foton2 kernel: Process karamba (pid: 844,
> > threadinfo=e21e4000 task=e29d2cc0)
> >  Jan 25 03:51:02 foton2 kernel: Stack: 00000200 e21e5fc4 eff3f85c
> > eff3d350 d6128000 00000286 eff3e3e0 c013bcb2
> >  Jan 25 03:51:02 foton2 kernel:        eff3f840 eff3d350 00000004
> > 00000001 00000001 e21e5ee0 00000004 eff3d340
> >  Jan 25 03:51:02 foton2 kernel:        d6128000 00000286 00000000
> > c013be10 eff3f840 eff3d340 c7362080 c7362080
> >  Jan 25 03:51:02 foton2 kernel: Call Trace:
> >  Jan 25 03:51:02 foton2 kernel:  [<c013bcb2>] cache_flusharray+0xf5/0xfa
> >  Jan 25 03:51:02 foton2 kernel:  [<c013be10>] kfree+0x5e/0x62
> >  Jan 25 03:51:02 foton2 kernel:  [<c011a6c4>] free_task+0x16/0x2f
> >  Jan 25 03:51:02 foton2 kernel:  [<c011d8a9>] release_task+0x18c/0x1f3
> >  Jan 25 03:51:02 foton2 kernel:  [<c011f161>]
> > wait_task_zombie+0x151/0x1e4 Jan 25 03:51:02 foton2 kernel:  [<c011f5ca>]
> > sys_wait4+0x237/0x27e Jan 25 03:51:02 foton2 kernel:  [<c0119411>]
> > default_wake_function+0x0/0x12 Jan 25 03:51:02 foton2 kernel: 
> > [<c0119411>] default_wake_function+0x0/0x12 Jan 25 03:51:02 foton2
> > kernel:  [<c0108fef>] syscall_call+0x7/0xb
>
> Looks like a double-free of a kernel stack.  Do you have slab debugging
> enabled?  Preempt?  SMP?

There are some important parts of my config : 
CONFIG_MPENTIUM4=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_PM_DISK is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
# CONFIG_ACPI_FAN is not set
# CONFIG_ACPI_PROCESSOR is not set
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_RELAXED_AML is not set

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set


So preempt yes, SMP no.

And there is quite interesting (for me) part of dmesg :

00000030000000 (ACPI NVS)
767MB LOWMEM available.
found SMP MP-table at 000ff780
hm, page 000ff000 reserved twice.
hm, page 00100000 reserved twice.
hm, page 000fd000 reserved twice.
hm, page 000fe000 reserved twice.
On node 0 totalpages: 196416
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 192320 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
 
I had the same problem (if it is problem :-) also with 2.4
I don't know if it is problem because "everything" works fine, but maybe it 
will help you(me :-).    David
                   

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAE0254RoNZR5PGMkRArhdAJ9oVnWYK3icIQ+JYuhYsrbDJuC3uwCePSgs
tYup9R93ZahkimZLppPsgpo=
=8yKG
-----END PGP SIGNATURE-----

