Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311530AbSC1Cmc>; Wed, 27 Mar 2002 21:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311547AbSC1CmW>; Wed, 27 Mar 2002 21:42:22 -0500
Received: from ns.suse.de ([213.95.15.193]:11535 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311530AbSC1CmM>;
	Wed, 27 Mar 2002 21:42:12 -0500
Date: Thu, 28 Mar 2002 03:42:11 +0100
From: Andi Kleen <ak@suse.de>
To: linux-kernel@vger.kernel.org, announce@x86-64.org
Subject: [ANNOUNCEMENT] New x86-64 kernel snapshot based on 2.4.19pre4 
Message-ID: <20020328034211.A14622@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A new 2.4.19pre4 based x86-64 linux kernel snapshot has been released. This is
a port of the Linux kernel to the x86-64 architecture, as implemented by the AMD
Hammer family of CPUs and the Virtutech VirtuHammer simulator. For more 
information about x86-64 see http://www.x86-64.org 

This is a major update for the x86-64 kernel. It has so many bugs fixed over
previous kernels that I would recommend every x86-64 user to update to
this kernel version.

This release requires new binutils and a recent gcc to build. The changed
signal ABI requires a new glibc. Working versions of gcc, glibc and binutils can 
be downloaded from ftp://ftp.x86-64.org/pub/stable-tools/current/ 
It also requires an updated gdb. Documentation on how to build the toolchain
and glibc can be found at http://www.x86-64.org/documentation

This is a newer x86-64 codebase than the version in the 2.5 kernel with much
more testing. 2.5 will be synced with this tree soon. 

Please report any problems to bugs@x86-64.org.  The discussion list is 
discuss@x86-64.org. See http://www.x86-64.org/mailinglists for archives
and subscribe/unsubscribe options.

You can download the x86-64 kernel source as a full tarball at: 

ftp://ftp.x86-64.org/pub/linux-x86_64/v2.4/linux-x86_64-2.4.19pre4-1.tar.bz2

MD5: 
e90765227be6956ffd002e18aa2a9e3a  linux-x86_64-2.4.19pre4-1.tar.bz2

or as a patch against plain Linux 2.4.19pre4 as released by Marcelo: 

ftp://ftp.x86-64.org/pub/linux-x86_64/v2.4/x86_64-2.4.19pre4-1.bz2

MD5: 
807df0308052b4065df2089cc9a49499  x86_64-2.4.19pre4-1.bz2

This is a snapshot of the CVS tree at cvs.x86-64.org. The current CVS tree can be 
accessed anonymously, for details see http://www.x86-64.org/cvs 
Note that the code in the CVS tree HEAD can be unstable sometimes.

Known problems: 
- MTRR breaks on SMP and can oops at booting. It is disabled ATM. 
- Still some problems in 64bit LTP runs, which could be partly kernel bugs.
- 32bit lspci breaks on the 64bit kernel because the /proc/pci structures
are not compatible.
- 32bit personality setting ("linux32") doesn't work. 
- NMI watchdog doesn't work.
- String/memory functions unoptimized and use a lot of CPU time. 
- 32bit setserial crashes.

Changes:
- Merge to 2.4.19pre4. This has a reduced struct page which saves several
MB of memory in a 64bit build.
- SMP and APIC code functional now
- 8257 timer is now accurate
- Some signal handling bugs fixed.
- modify_ldt for 32bit and 64bit implemented
- IA32 emulation enhanced with a few new calls and ioctls and various bugs 
fixed.
- 32bit ptrace support.
- Some driver support for AMD 8111: Sound card, IDE, USB 2.0 (Vojtech Pavlik) 
- AMD 8111 Random Generator based on the AMD768 RNG driver.
- Audited on all inline assembly: this found and fixed various bugs. 
- New struct user and signal frame formats.  This is an ABI change.
- Doesn't require 32bit tools for building anymore.
- New kernel mapping that in theory supports ~120TB of physical memory per
system. 
- Kernel modules functional now. Fixed some vmalloc/ioremap bugs.
- More efficient signal handling. Does FXSAVE directly into and out 
of user space now.
- WCHAN support added.
- Various other bug fixes.

-Andi Kleen, SuSE Labs.
