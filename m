Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbUAHGs0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 01:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbUAHGs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 01:48:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:57036 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263734AbUAHGsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 01:48:19 -0500
Date: Wed, 7 Jan 2004 22:48:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.1-rc3
Message-ID: <Pine.LNX.4.58.0401072245150.6823@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not a lot to say, the ChangeLog says it all (and I include the -rc2 log 
too, since I forgot to actually ever post it). Mostly random smaller stuff 
all over. The big merges were all in rc1 and do not seem to have caused 
any huge headaches.

		Linus

---

Summary of changes from v2.6.1-rc2 to v2.6.1-rc3
============================================

Adam Belay:
  o Fix PnP BIOS call

Andi Kleen:
  o Fix interrupt routing problem on x86-64
  o [COMPAT]: Handle SO_TIMESTAMP cmsgs

Andrew Morton:
  o MSI build fixes
  o fix sysfs oops
  o JFS fix for NFS on little-endian systems
  o dvb: firmware fixes
  o ia32 sched_clock() deadlock fix
  o /proc/ppc64 and /proc/iSeries fixes from Linas Vepstas
  o ppc64: Add missing section definition

Bartlomiej Zolnierkiewicz:
  o cmd640.c: fix PCI type1 access
  o ide-tape.c: stop abusing rq->flags
  o remove dead and broken DISK_RECOVERY_TIME support
  o fix oopses on rmmod in some OSS drivers

Ciaran McCreesh:
  o [SPARC64]: Fix CONFIG_DRM_FFB=y build

Dave Jones:
  o [AGPGART] printk level changes for amd64
  o [AGPGART] Add support for Radeon IGP345M to ATI GART driver

Dave Kleikamp:
  o don't clear i_sb

David Dillow:
  o [SUNZILOG]: Register the correct number of ports, ignore keyb/mouse
    lines

David S. Miller:
  o [NET]: In dev_kfree_skb_any() use dev_kfree_skb_irq() if
    irqs_disabled()
  o [NET]: Un-deprecate skb_linearize(), we can re-deprecate in 2.7.x

Hideaki Yoshifuji:
  o [IPV6]: Kill obsolete functions (ip6_frag_xmit() and
    ip6_build_xmit())

Ingo Molnar:
  o [NET]: Do type checking in {udp,inet6,raw6,inet}_sk()

James Morris:
  o [NETFILTER]: Add SELINUX priority values for ipv4/ipv6, approved by
    Harald Welte

Jean Tourrilhes:
  o [IRDA]: Fix locking in the ircomm-shutdown path

Keith M. Wesolowski:
  o [SPARC32]: Fix BUG on swapout on srmmu systems

Linus Torvalds:
  o Fix ttpci bogus use of floating point by casting the constant
    expression properly.
  o Fix silly mremap test
  o Don't relocate non-allocated regions in modules

Martin Devera:
  o [NET]: Make sure that class selected by priority is a leaf in HTB
    scheduler

Matthew Wilcox:
  o [SPARC64]: Use drivers/block/Kconfig
  o [SPARC32]: Use drivers/block/Kconfig

Mitsuru Kanda:
  o Fix my PGP fingerprint in the CREDITS file

Roman Zippel:
  o generate an error if writing of kernel config failed
  o fix gconf segfault problem
  o gconf compile warning fixes
  o gconf startup fixes
  o qconf fix

Stephen Hemminger:
  o [AF_PACKET]: Convert to seq_file
  o [DECNET]: Better way to prevent decnet module unload
  o [NET]: Fix multiple eth0 mixed PCI/ISA init

Tom 'spot' Callaway:
  o [SPARC]: Add missing MODULE_LICENSE tags to various Sparc driver
  o [SPARC64]: Fix sun_uflash MTD driver build
  o [SPARC]: Add placeholder asm-{sparc,sparc64}/setup.h so MTD builds
  o [SPARC64]: Export sys_close for solaris emulation

Ville Nuorvala:
  o [IPV6]: Autoconfig link-local address on ip6-ip6 tunnel device


Summary of changes from v2.6.1-rc1 to v2.6.1-rc2
============================================

Amit Gurdasani:
  o [SERIAL] EISA ID for PnP modem

Andi Kleen:
  o X86-64 merge
  o Fix memset on x86-64

Bart De Schuymer:
  o [BRIDGE NETFILTER]: Fix leaks and crashes in SKB handling
  o [BRIDGE NETFILTER]: IPV6 needs the skb->nf_bridge leak fix as well
  o [BRIDGE]: Fix build with vlan disabled, spurious ifdef

Ciaran McCreesh:
  o [SPARC64]: Fix broken _PAGE_SZHUGE defines for 512K and 64K

Dave Jones:
  o [CPUFREQ] Add support for 1GHz Centrino speedstep From: Youichi Aso
    <aso@granite.phys.s.u-tokyo.ac.jp>
  o [AGPGART] Handle multiple AMD64 AGP bridges correctly on UP
  o [AGPGART] Fix return check on request_mem_region() Do things the
    way every other user of this function does.
  o [CPUFREQ] Fix powernow-k8 policy usage
  o [CPUFREQ] Abort if there is a failure in aquiring "ownership" of
    the SMI speedstep interface
  o [AGPGART] Fix two nasty bugs in the K8 AGP support
  o [CPUFREQ] Use different attack with the Powernow-K7 bad bios
    problems
  o [AGPGART] Fix MAX_HAMMER_GARTS off by one
  o [CPUFREQ] Fix rounding in longhaul
  o [AGPGART] Mask memory after allocation We missed a few cases where
    we need to do this.
  o [AGPGART] Merge missing chunk of NVIDIA nForce agpgart driver
  o [AGPGART] Remove duplicate programming of AGP command register
  o [CPUFREQ] on P4s no TSC adjustment is necessary From Dominik
    Brodowski
  o [CPUFREQ] Disable debug output in speedstep-smi driver
  o [CPUFREQ] speedstep hcakers cnat spel
  o [CPUFREQ] Disable smi_detect_freqs() call on systems which do not
    support it [BUG #1422] Dominik Brodowski.
  o [CPUFREQ] Support for 533 MHz FSB in speedstep driver
  o [CPUFREQ] Detect CPU speed without relying on cpu_khz
  o [CPUFREQ] remove unneeded #ifdefs in include/linux/cpufreq.h
  o [CPUFREQ] use latency in nanoseconds sometimes nanoseconds are
    used, sometimes microseconds, sometimes even something else.
  o [CPUFREQ] Do something about "cpufreq: change failed"
  o [CPUFREQ] do not leak memory in powernow-k8 From Pavel Machek
  o [CPUFREQ] Typo fix in drivers/cpufreq/Kconfig
  o [CPUFREQ] Missing .owner entry in speedstep-smi driver

David Mosberger:
  o ia64: Fix a ptrace-bug that caused "strace -f" to crash the
    inferior process.  The root-cause of the problem was that ptrace()
    tried to copy the portion of the register backing store that landed
    on the kernel stack back to users-space, but the resulting state
    was inconsistent if the inferior process was in the middle of a
    system-call (as would always be the case for strace).
  o ia64: Rearrange ia64_do_signal() such that it is possible for a
    debugger to cancel system-call restart.
  o ia64: Allow system-call number to be changed during system-call
    tracing (both for native and x86 system call tracing).  This is
    needed by recent versions of strace and UML likes to do that, too.
  o ia64: Remove the old ia64_ni_syscall()/sys32_ni_syscall() routines
    which are overly verbose and replace them with calls to
    sys_ni_syscall().
  o ia64: fix perfmon bug causing lost samples
  o ia64: Merge patch by Arun Sharma: hook up lots of ia32 syscalls
  o ia64: Rename efi_get_time() in the simulator's firmware-emulator to
    avoid name-clash with declaration of routine of the same name in
    <linux/efi.h>.
  o ia64: Update defconfig

David S. Miller:
  o [TG3]: Do not drop existing GRC_MODE_HOST_STACKUP when writing to
    GRC_MODE
  o [TG3]: Do not set RX_MODE_KEEP_VLAN_TAG when ASF is enabled
  o [TG3]: Clear on-chip stats/status block after resetting
    flow-through queues
  o [TG3]: Update version and release date
  o [TG3]: Update to latest non-5705 TSO firmware
  o [TG3]: Update version and reldate
  o [MEDIA]: ttusb_dec.c needs linux/init.h
  o [SPARC64]: Update defconfig

François Romieu:
  o [TG3]: Fix bogus return value in tg3_init_one()

Hideaki Yoshifuji:
  o [NET]: Fix comment type in skbuff.h

James Bottomley:
  o MSI broke voyager build

Jeroen Vreeken:
  o [AX25]: Missing spin_unlock() and recvmsg reported dst instead of
    src

Linus Torvalds:
  o Remove generated files from revision control
  o Remove dead files
  o Fix IDE "PIO WRITE wait for ready" test under extreme interrupt
    load
  o Don't allow mremap of zero-sized areas

Michael Hunold:
  o DVB: Update documentation and credits
  o DVB: Fix feed list handling bugs in demux
  o DVB: Fixes for frontend drivers
  o DVB: Add static firmware compilation again
  o DVB: Revamp of the TTUSB-DEC driver
  o DVB: Fix memory usage of ttpci driver

Rene Herman:
  o [SERIAL] add PnP ID to 8250_pnp.c

Russell King:
  o Fix "echo -n 3 > /sys/.../power/state"
  o [SERIAL] Remove old RSA resource handlign
  o [ARM] Fix more gcc3 build errors
  o [ARM] Fix cachepolicy=<foo>
  o [ARM] Kill dma-isa.c warning
  o [ARM] Report more detail when unable to resolve module relocations

Xose Vazquez Perez:
  o [TG3]: Add new device IDs

