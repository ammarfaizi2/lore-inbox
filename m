Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262068AbREQRXy>; Thu, 17 May 2001 13:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262090AbREQRXo>; Thu, 17 May 2001 13:23:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:12928 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262068AbREQRX3>; Thu, 17 May 2001 13:23:29 -0400
Date: Thu, 17 May 2001 13:23:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Linux-2.4.4 failure to compile
Message-ID: <Pine.LNX.3.95.1010517132052.14991A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello;

I downloaded linux-2.4.4. The basic kernel compiles but the aic7xxx
SCSI module that I require on some machines, doesn't. 


[SNIPPED `make modules`]

make -C scsi modules
make[2]: Entering directory `/usr/src/linux-2.4.4/drivers/scsi'
ld -m elf_i386 -r -o scsi_mod.o scsi.o hosts.o scsi_ioctl.o constants.o scsicam.o scsi_proc.o scsi_error.o scsi_obsolete.o scsi_queue.o scsi_lib.o scsi_merge.o scsi_dma.o scsi_scan.o scsi_syms.o
ld -m elf_i386 -r -o initio.o ini9100u.o i91uscsi.o
ld -m elf_i386 -r -o a100u2w.o inia100.o i60uscsi.o
ld -m elf_i386 -r -o sd_mod.o sd.o
ld -m elf_i386 -r -o sr_mod.o sr.o sr_ioctl.o sr_vendor.o
make -C aic7xxx modules
make[3]: Entering directory `/usr/src/linux-2.4.4/drivers/scsi/aic7xxx'
make -C aicasm
make[4]: Entering directory `/usr/src/linux-2.4.4/drivers/scsi/aic7xxx/aicasm'
gcc -I/usr/include -ldb1 aicasm_gram.c aicasm_scan.c aicasm.c aicasm_symbol.c -o aicasm
aicasm_gram.y:37: inttypes.h: No such file or directory
aicasm.c:39: inttypes.h: No such file or directory
aicasm_symbol.c:39: db1/db.h: No such file or directory
make[4]: *** [aicasm] Error 1
make[4]: Leaving directory `/usr/src/linux-2.4.4/drivers/scsi/aic7xxx/aicasm'
make[3]: *** [aicasm/aicasm] Error 2
make[3]: Leaving directory `/usr/src/linux-2.4.4/drivers/scsi/aic7xxx'
make[2]: *** [_modsubdir_aic7xxx] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.4/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.4/drivers'
make: *** [_mod_drivers] Error 2a


Something broke.
A check of ../linux/Documentation/Changes doesn't show that I should
install anything new.


`sh ver_linux`

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux chaos 2.4.1 #10 SMP Fri Feb 23 10:38:40 EST 2001 i686
 
Gnu C                  egcs-2.91.66
Gnu make               3.79.1
binutils               2.9.5.0.16
mount                  2.10o
modutils               2.3.15
e2fsprogs              1.19
PPP                    2.3.10
Linux C Library        > /usr/lib/libc.so.6
Dynamic linker (ldd)   2.0.6
Linux C++ Library      27.1.0
Procps                 1.2
Net-tools              1.50
Kbd                    0.89
Sh-utils               1.12
Modules Loaded         loop ipx 3c59x nls_cp437 BusLogic sd_mod scsi_mod


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


