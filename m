Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030237AbWJRLpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWJRLpB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 07:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWJRLpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 07:45:01 -0400
Received: from metis.extern.pengutronix.de ([83.236.181.26]:45249 "EHLO
	metis.extern.pengutronix.de") by vger.kernel.org with ESMTP
	id S1030237AbWJRLpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 07:45:00 -0400
Date: Wed, 18 Oct 2006 13:46:54 +0200
From: Luotao Fu <l.fu@pengutronix.de>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, ag-automation@www.osadl.org
Subject: [PATCH] arm fix for kernel with Realtime Preempt patch
Message-ID: <20061018114654.GA679@localhost.localdomain>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	ag-automation@lists.osadl.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
X-PGP-Key-ID: 0xE5325261
X-URL: http://www.pengutronix.de
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
Here is a patch to fix Compliation error while compling the kernel with
the Realtime Preemption patch for arm with the latency tracer turned on.

The Errormessage (compiled with gcc4.2.0) is also attached to this mail.=20

The patch attachs __sched to the function calls compat_sem_is_locked()
and __compat_down_trylock() for arm. So that the calls will be put in
the section .sched.text, as declared later in the asm code.

Regards
Luotao Fu
--=20
     Dipl.-Ing. Luotao Fu | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="error.log"


arm-v4t-linux-gnueabi-gcc -Wp,-MD,arch/arm/kernel/.semaphore.o.d  -nostdinc -isystem /opt/OSELAS.Toolchain-trunk/arm-v4t-linux-gnueabi/gcc-4.2-20061014-glibc-2.5/lib/gcc/arm-v4t-linux-gnueabi/4.2.0/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -mlittle-endian -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Os -fno-omit-frame-pointer -mapcs -mno-sched-prolog -mabi=aapcs-linux -mno-thumb-interwork -D__LINUX_ARM_ARCH__=4 -march=armv4t -mtune=arm9tdmi  -msoft-float -Uarm -pg -fno-omit-frame-pointer -fno-optimize-sibling-calls -g  -fno-stack-protector -Wdeclaration-after-statement -Wno-pointer-sign    -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(semaphore)"  -D"KBUILD_MODNAME=KBUILD_STR(semaphore)" -c -o arch/arm/kernel/semaphore.o arch/arm/kernel/semaphore.c
Using built-in specs.
Target: arm-v4t-linux-gnueabi
Configured with: /home/mkl/pengutronix/ptxdist/build/OSELAS.Toolchain-trunk-gcc-4.2/build-cross/gcc-4.2-20061014/configure --host=i686-host-linux-gnu --target=arm-v4t-linux-gnueabi --prefix=/opt/OSELAS.Toolchain-trunk/arm-v4t-linux-gnueabi/gcc-4.2-20061014-glibc-2.5 --with-sysroot=/opt/OSELAS.Toolchain-trunk/arm-v4t-linux-gnueabi/gcc-4.2-20061014-glibc-2.5/sysroot-arm-v4t-linux-gnueabi --with-arch=armv4t --with-float=soft --with-fpu=vfp --disable-nls --enable-symvers=gnu --enable-__cxa_atexit --disable-multilib --disable-shared --enable-threads=no --enable-languages=c
Thread model: single
gcc version 4.2.0 20061014 (experimental)
 /opt/OSELAS.Toolchain-trunk/arm-v4t-linux-gnueabi/gcc-4.2-20061014-glibc-2.5/libexec/gcc/arm-v4t-linux-gnueabi/4.2.0/cc1 -E -quiet -nostdinc -v -Iinclude -D__KERNEL__ -D__LINUX_ARM_ARCH__=4 -Uarm -DKBUILD_STR(s)=#s -DKBUILD_BASENAME=KBUILD_STR(semaphore) -DKBUILD_MODNAME=KBUILD_STR(semaphore) -isystem /opt/OSELAS.Toolchain-trunk/arm-v4t-linux-gnueabi/gcc-4.2-20061014-glibc-2.5/lib/gcc/arm-v4t-linux-gnueabi/4.2.0/include -include include/linux/autoconf.h -MD arch/arm/kernel/.semaphore.o.d arch/arm/kernel/semaphore.c -mlittle-endian -mapcs -mno-sched-prolog -mabi=aapcs-linux -mno-thumb-interwork -march=armv4t -mtune=arm9tdmi -msoft-float -mfpu=vfp -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-aliasing -fno-common -fno-omit-frame-pointer -fno-optimize-sibling-calls -fno-stack-protector -fworking-directory -Os -fpch-preprocess -o semaphore.i
#include "..." search starts here:
#include <...> search starts here:
 include
 /opt/OSELAS.Toolchain-trunk/arm-v4t-linux-gnueabi/gcc-4.2-20061014-glibc-2.5/lib/gcc/arm-v4t-linux-gnueabi/4.2.0/include
End of search list.
 /opt/OSELAS.Toolchain-trunk/arm-v4t-linux-gnueabi/gcc-4.2-20061014-glibc-2.5/libexec/gcc/arm-v4t-linux-gnueabi/4.2.0/cc1 -fpreprocessed semaphore.i -quiet -dumpbase semaphore.c -mlittle-endian -mapcs -mno-sched-prolog -mabi=aapcs-linux -mno-thumb-interwork -march=armv4t -mtune=arm9tdmi -msoft-float -mfpu=vfp -auxbase-strip arch/arm/kernel/semaphore.o -g -Os -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -Wdeclaration-after-statement -Wno-pointer-sign -version -p -fno-strict-aliasing -fno-common -fno-omit-frame-pointer -fno-optimize-sibling-calls -fno-stack-protector -o semaphore.s
GNU C version 4.2.0 20061014 (experimental) (arm-v4t-linux-gnueabi)
	compiled by GNU C version 4.1.2 20060901 (prerelease) (Debian 4.1.1-13).
GGC heuristics: --param ggc-min-expand=30 --param ggc-min-heapsize=4096
Compiler executable checksum: f57ff329f13f8db743e62d0546825ac4
 /opt/OSELAS.Toolchain-trunk/arm-v4t-linux-gnueabi/gcc-4.2-20061014-glibc-2.5/lib/gcc/arm-v4t-linux-gnueabi/4.2.0/../../../../arm-v4t-linux-gnueabi/bin/as -EL -march=armv4t -mfloat-abi=soft -mfpu=vfp -meabi=4 -o arch/arm/kernel/semaphore.o semaphore.s
semaphore.s: Assembler messages:
semaphore.s:733: Error: can't resolve `.text' {.text section} - `.LFB403' {.sched.text section}
















--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="arch_arm_kernel_semaphore_c-LATENCY_TRACE_sched-fix.diff"
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Luotao Fu <lfu@pengutronix.de>

--- linux-2.6.18-rt5/arch/arm/kernel/semaphore.c	2006-10-16 19:40:16.000000=
000 +0200
+++ linux-2.6.18-rt5-fix/arch/arm/kernel/semaphore.c	2006-10-16 19:33:48.00=
0000000 +0200
@@ -154,7 +154,7 @@
  * single "cmpxchg" without failure cases,
  * but then it wouldn't work on a 386.
  */
-fastcall int __attribute_used__ __compat_down_trylock(struct compat_semaph=
ore * sem)
+fastcall int __attribute_used__ __sched __compat_down_trylock(struct compa=
t_semaphore * sem)
 {
 	int sleepers;
 	unsigned long flags;
@@ -176,7 +176,7 @@
=20
 EXPORT_SYMBOL(__compat_down_trylock);
=20
-fastcall int compat_sem_is_locked(struct compat_semaphore *sem)
+fastcall int __sched compat_sem_is_locked(struct compat_semaphore *sem)
 {
 	return (int) atomic_read(&sem->count) < 0;
 }

--AhhlLboLdkugWU4S--

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFNhQuiruQY+UyUmERAuoeAKDPijRSDimXdprJ0D7sMX3RY4j1QwCgzmR/
ohUbc+4xWMgnfpuMvXplWG4=
=p3iH
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
