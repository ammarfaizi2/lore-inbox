Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261726AbSI0WVq>; Fri, 27 Sep 2002 18:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262597AbSI0WVq>; Fri, 27 Sep 2002 18:21:46 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:48522 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S261726AbSI0WVp>; Fri, 27 Sep 2002 18:21:45 -0400
Date: Sat, 28 Sep 2002 00:27:03 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.39
Message-Id: <20020928002703.1ab4583b.us15@os.inf.tu-dresden.de>
In-Reply-To: <Pine.LNX.4.33.0209271459210.1807-100000@penguin.transmeta.com>
References: <Pine.LNX.4.33.0209271459210.1807-100000@penguin.transmeta.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.8.3claws (GTK+ 1.2.10; Linux 2.4.20-pre7 i686)
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.O/np8FJ6aBzEq'"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.O/np8FJ6aBzEq'
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Sep 2002 15:02:48 -0700 (PDT) Linus Torvalds (LT) wrote:

LT> Summary of changes from v2.5.38 to v2.5.39
LT> ============================================

Following compile error with 2.5.39 has been in 2.5.38, too.

gcc -Wp,-MD,./.sleep.o.d -D__KERNEL__ -I/usr/src/linux-2.5.39/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon 
-I/usr/src/linux-2.5.39/arch/i386/mach-generic -nostdinc -iwithprefix include 
-D_LINUX -I/usr/src/linux-2.5.39/drivers/acpi/include  -DKBUILD_BASENAME=sleep
-c -o sleep.o sleep.c

sleep.c: In function `acpi_system_restore_state':
sleep.c:63: warning: implicit declaration of function `acpi_restore_state_mem'
sleep.c: In function `acpi_system_save_state':
sleep.c:132: warning: implicit declaration of function `acpi_save_state_mem'
sleep.c:135: warning: implicit declaration of function `acpi_save_state_disk'
sleep.c: In function `acpi_system_suspend':
sleep.c:209: warning: implicit declaration of function `do_suspend_lowlevel'
sleep.c: In function `acpi_suspend':
sleep.c:237: `acpi_wakeup_address' undeclared (first use in this function)
sleep.c:237: (Each undeclared identifier is reported only once
sleep.c:237: for each function it appears in.)
sleep.c: In function `acpi_sleep_init':
sleep.c:707: `sysrq_acpi_poweroff_op' undeclared (first use in this function)
make[3]: *** [sleep.o] Error 1

-Udo.

--=.O/np8FJ6aBzEq'
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9lNs5nhRzXSM7nSkRAh/rAJkBS414AlsP3XZN/2rtbSucUE9+cwCeKWHR
F1EKQEit+t+X082AxP4Co6I=
=Dly2
-----END PGP SIGNATURE-----

--=.O/np8FJ6aBzEq'--
