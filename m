Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277156AbRJHVyp>; Mon, 8 Oct 2001 17:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277164AbRJHVyg>; Mon, 8 Oct 2001 17:54:36 -0400
Received: from [216.163.180.10] ([216.163.180.10]:26999 "EHLO
	c0mailgw06.prontomail.com") by vger.kernel.org with ESMTP
	id <S277162AbRJHVyX>; Mon, 8 Oct 2001 17:54:23 -0400
Message-ID: <3BC22084.22061F19@starband.net>
Date: Mon, 08 Oct 2001 17:54:12 -0400
From: war <war@starband.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.11-5 Compile Error AIC7XXX_OLD.C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am want to try out emu10k1-2.4.11-pre5.patch to fix the static problem
in kernels > 2.4.7, and I came across this while trying to upgrade:

System information is below the error:

make -C scsi
make[2]: Entering directory `/usr/src/linux-2.4.10/drivers/scsi'
make all_targets
make[3]: Entering directory `/usr/src/linux-2.4.10/drivers/scsi'
ld -m elf_i386 -r -o scsi_mod.o scsi.o hosts.o scsi_ioctl.o constants.o
scsicam.
o scsi_proc.o scsi_error.o scsi_obsolete.o scsi_queue.o scsi_lib.o
scsi_merge.o
scsi_dma.o scsi_scan.o scsi_syms.o
gcc -D__KERNEL__ -I/usr/src/linux-2.4.10/include -Wall
-Wstrict-prototypes -Wno-
trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpref
erred-stack-boundary=2 -march=i686    -c -o aic7xxx_old.o aic7xxx_old.c
aic7xxx_old.c:11966: parse error before string constant
aic7xxx_old.c:11966: warning: type defaults to `int' in declaration of
`MODULE_LICENSE'
aic7xxx_old.c:11966: warning: function declaration isn't a prototype
aic7xxx_old.c:11966: warning: data definition has no type or storage
class
make[3]: *** [aic7xxx_old.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.10/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.10/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.10/drivers'
make: *** [_dir_drivers] Error 2
[root@war linux]#

It makes MODULE_LICENSE an int, need to make it a string, not sure how
though, know very little about C.
Line 11966: MODULE_LICENSE("Dual BSD/GPL");



System Software:
Distribution: Red Hat Linux release 7.1 (Seawolf)
    autoconf: 2.52
     autogen: 5.2.9
    automake: 1.5
    binutils: 2.11.2
      esound: 0.2.23
         gcc: 2.95.3
     gettext: 0.10.40
       glibc: 2.2.2
        glib: 1.2.10
  gnome-libs: 1.2.8
         gtk: 1.2.10
       imlib: 1.9.11
     kdelibs: 2.2.1
      kernel: 2.4.7
     libtool: 1.4.2
     openssl: 0.9.6b
       orbit: 0.5.7
   orbit-idl: 0.6.8
        perl: 5.6.1
          qt: 2.3.1
         rpm: 4.0.2
         sdl: 1.2.2
     xfree86: 4.0.99.2
        xml2: 2.4.5
         xml: 1.8.16


