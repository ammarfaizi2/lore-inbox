Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290028AbSBFE4c>; Tue, 5 Feb 2002 23:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290047AbSBFE4M>; Tue, 5 Feb 2002 23:56:12 -0500
Received: from fc.capaccess.org ([151.200.199.53]:40210 "EHLO fc.Capaccess.org")
	by vger.kernel.org with ESMTP id <S290028AbSBFE4F>;
	Tue, 5 Feb 2002 23:56:05 -0500
Message-id: <fc.00858412002d5eac00858412002d5eac.2d606a@Capaccess.org>
Date: Tue, 05 Feb 2002 23:55:10 -0500
Subject: Re: How to check the kernel compile options ?
To: linux-kernel@vger.kernel.org
From: "Rick A. Hohensee" <rickh@Capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is my original post on "make appendage" and some other
goodies you'll find in cLIeNUX, assuming you can find cLIeNUX. Perhaps it
would have recieved more play at the time if the subject line had been 

make state relink Linux appendage

The real reason I repeat posts like this though is I look at them later
and *I* can't readily see what I'm talking about. Oops.

make state   snags the state of the shell and make environment for the
build. You need a hook in the makefile to get it.

Make relink   allows a quick rebuild after one small source file edit
somewhere by zapping all the per-dir lib.o's and other rebuild snaggers.

make Linux   saves newbies (We are all newbies) from having the
arch/bla/compressed/actual.img    "learning" experience and not trying to
boot vmlinuz.

make appendage   is the part that this thread resembles.

Other cLIeNUXisms are the 2-line Bash prompt, here in tawdry monochrome, 
and the DISTRO shell variable.


            make state ; make relink ; make Linux ; make appendage

   From: Rick Hohensee ([1]humbubba@smarty.smart.net)
   Date: Mon Apr 10 2000 - 01:00:10 EST

     * Next message: [2]Web Administrator: "Re: /proc/net/dev reporting
       on virtual interfaces"
     * Previous message: [3]Eric W. Biederman: "Re: Suggested dual
       human/binary interface for proc/devfs"
     * Messages sorted by: [4][ date ] [5][ thread ] [6][ subject ] [7][
       author ]
     _________________________________________________________________

   cd linux

   The next 2 lines are an occurance of my Bash prompt...
   :; cLIeNUX0 /dev/tty4 r 20:08:30 /source/core/KERNEL/linux
   :;<cursor here>

   step-wise demo. Elapsed times per $PS1 are not quite realistic.
   ..................................................................
   :; cLIeNUX0 /dev/tty4 r 20:08:30 /source/core/KERNEL/linux
   :;make state
   set > .make_state
   :; cLIeNUX0 /dev/tty4 r 20:10:39 /source/core/KERNEL/linux
   :;cat .make_state
   AR=ar
   ARCH=i386
   AS=as
   AWKPATH=/source/script/awk
   BASH=/.bi/sh
   BASH_VERSINFO=([0]="2" [1]="02" [2]="0" [3]="1" [4]="release"
   [5]="i4<snip>
   BASH_VERSION='2.02.0(1)-release'
   CC='gcc -D__KERNEL__ -I/source/core/KERNEL/linux/include'
   CFLAGS='-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -pipe
   -fno-s<snip>
   CFLAGS_NSR=-fno-strength-reduce
   CFLAGS_PIPE=-pipe
   COMPILER_PATH='~:/.roo/command:/.bi:/.sbi:/.bi/unix/:.:/.bi/background
   /C/'
   CONFIG_1GB=y
   CONFIG_M386=y
   CONFIG_SHELL=/.bi/sh
   CORE_FILES='arch/i386/kernel/kernel.o arch/i386/mm/mm.o
   kernel/kerne<snip>
   fs/fs.o ipc/ipc.o'
   CPP='gcc -D__KERNEL__ -I/source/core/KERNEL/linux/include -E'
   CROSS_COMPILE=
   C_INCLUDE_PATH=/.bi/background/C/include:/source/C/include/:/suit<snip
   >
   DIRSTACK=()
   DISTRO=cLIeNUX
   <snip>

   :; cLIeNUX0 /dev/tty4 r 20:10:39 /source/core/KERNEL/linux
   :;make relink

   rm -v /source/core/KERNEL/linux/arch/i386/boot/bzImage
   /source/core/KERNEL/linux/arch/i386/boot/zImage
   /source/core/KERNEL/linux/vmlinux
   /source/core/KERNEL/linux/arch/i386/boot/compressed/bvmlinux
   /source/core/KERNEL/linux/arch/i386/boot/compressed/bvmlinux.out
   /source/core/KERNEL/linux/arch/i386/boot/compressed/piggy.o
   /source/core/KERNEL/linux/Linux arch/i386/kernel/kernel.o
   arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o
   fs/filesystems.a net/network.a \
           drivers/block/block.a drivers/char/char.a drivers/misc/misc.a
   drivers/net/net.a /source/core/KERNEL/linux/arch/i386/lib/lib.a
   /source/core/KERNEL/linux/lib/lib.a
   /source/core/KERNEL/linux/arch/i386/lib/lib.a
   /source/core/KERNEL/linux/arch/i386/boot/bzImage
   /source/core/KERNEL/linux/arch/i386/boot/zImage
   /source/core/KERNEL/linux/vmlinux
   /source/core/KERNEL/linux/arch/i386/boot/compressed/bvmlinux
   /source/core/KERNEL/linux/arch/i386/boot/compressed/bvmlinux.out
   /source/core/KERNEL/linux/arch/i386/boot/compressed/piggy.o
   /source/core/KERNEL/linux/Linux
   rm: /source/core/KERNEL/linux/arch/i386/boot/bzImage: No such file or
   directory
   rm: /source/core/KERNEL/linux/arch/i386/boot/zImage: No such file or
   directory
   /source/core/KERNEL/linux/vmlinux
   /source/core/KERNEL/linux/arch/i386/boot/compressed/bvmlinux
   /source/core/KERNEL/linux/arch/i386/boot/compressed/bvmlinux.out
   /source/core/KERNEL/linux/arch/i386/boot/compressed/piggy.o
   /source/core/KERNEL/linux/Linux
   arch/i386/kernel/kernel.o
   arch/i386/mm/mm.o
   kernel/kernel.o
   mm/mm.o
   fs/fs.o
   ipc/ipc.o
   fs/filesystems.a
   net/network.a
   drivers/block/block.a
   drivers/char/char.a
   drivers/misc/misc.a
   drivers/net/net.a
   /source/core/KERNEL/linux/arch/i386/lib/lib.a
   /source/core/KERNEL/linux/lib/lib.a
   make: [relink] Error 1 (ignored)
   :; cLIeNUX0 /dev/tty4 r 20:10:39 /source/core/KERNEL/linux
   :;make Linux
   make -C kernel
   make[1]: Entering directory `/source/core/KERNEL/linux/kernel'
   make all_targets
   make[2]: Entering directory `/source/core/KERNEL/linux/kernel'
   rm -f kernel.o
   ld -m elf_i386 -r -o kernel.o signal.o sched.o dma.o fork.o exe<snip>
   make[2]: Leaving directory `/source/core/KERNEL/linux/kernel'
   make[1]: Leaving directory `/source/core/KERNEL/linux/kernel'
   make -C drivers
   make[1]: Entering directory `/source/core/KERNEL/linux/drivers'
   make -C block
   make[2]: Entering directory `/source/core/KERNEL/linux/drivers/block'
   make all_targets
   make[3]: Entering directory `/source/core/KERNEL/linux/drivers/block'
   rm -f block.a
   ar rcs block.a ll_rw_blk.o genhd.o
   make[3]: Leaving directory `/source/core/KERNEL/linux/drivers/block'

   < ... much more re-linking and no actual compiling snipped...>

   Root device is (8, 1)
   Boot sector 512 bytes.
   Setup is 1288 bytes.
   System is 154 kB
   make[1]: Leaving directory `/source/core/KERNEL/linux/arch/i386/boot'
   mv /source/core/KERNEL/linux/arch/i386/boot/bzImage
   /source/core/<snip>
   :; cLIeNUX0 /dev/tty4 r 20:20:19 /source/core/KERNEL/linux
   :;make appendage
   set > .make_state
   echo -e "\n\nCONFIG_>> .config appendage..." >> /source/c
   grep -v "^#" /source/core/KERNEL/linux/.config >> /source/core/K<snip>
   echo -e "\nCONFIG_>> .make_state appendage..." >>
   /source/core/KERNE<snip>
   cat /source/core/KERNEL/linux/.make_state >>
   /source/core/KERNEL/linux/Linux
   :; cLIeNUX0 /dev/tty4 r 20:22:09 /source/core/KERNEL/linux
   :;grep CONFIG Linux
   Binary file Linux matches
   :; cLIeNUX0 /dev/tty4 r 20:22:25 /source/core/KERNEL/linux
   :;grep -a CONFIG Linux
   CONFIG_>> .config appendage...
   CONFIG_M386=y
   CONFIG_1GB=y
   CONFIG_>> .make_state appendage...
   CONFIG_1GB=y
   CONFIG_M386=y
   CONFIG_SHELL=/.bi/sh
   :; cLIeNUX0 /dev/tty4 r 20:22:32 /source/core/KERNEL/linux
   :;
   ....................................................................

   caused by...
           in linux/Makefile...
                   ..................................................
   relink:
           -rm -v $(IMAGES) $(CORE_FILES) $(FILESYSTEMS) $(NETWORKS) \
                   $(DRIVERS) $(LIBS)

   state:
           set > .make_state

   ................................................................
           In linux/arch/i386/Makefile...

                   ................................................

   IMAGES =$(TOPDIR)/arch/$(ARCH)/boot/bzImage \
                    $(TOPDIR)/arch/$(ARCH)/boot/zImage \
                    $(TOPDIR)/vmlinux \
                    $(TOPDIR)/arch/$(ARCH)/boot/compressed/bvmlinux \
                    $(TOPDIR)/arch/$(ARCH)/boot/compressed/bvmlinux.out \
                    $(TOPDIR)/arch/$(ARCH)/boot/compressed/piggy.o \
                    $(TOPDIR)/Linux

   Linux: bzImage
           mv $(TOPDIR)/arch/$(ARCH)/boot/bzImage $(TOPDIR)/Linux

   append appendage: state
           -echo -e "\n\nCONFIG_>> .config appendage..." >>
   $(TOPDIR)/Linux
           -grep -v "^#" $(TOPDIR)/.config >> $(TOPDIR)/Linux
           -echo -e "\nCONFIG_>> .make_state appendage..." >>
   $(TOPDIR)/Linux
           -cat $(TOPDIR)/.make_state >> $(TOPDIR)/Linux

   ......................................................................
   .

   I wasn't going to bother with make targets for these, not being real
   fond
   of make anyway, until I saw that the variables in the relink: target
   except for IMAGES already exist.

                           Cordially,

                                   Rick Hohensee

r

