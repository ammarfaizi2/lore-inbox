Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268061AbTBNVLD>; Fri, 14 Feb 2003 16:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268140AbTBNVKj>; Fri, 14 Feb 2003 16:10:39 -0500
Received: from adsl-67-123-8-233.dsl.pltn13.pacbell.net ([67.123.8.233]:5600
	"EHLO influx.triplehelix.org") by vger.kernel.org with ESMTP
	id <S268061AbTBNVIq>; Fri, 14 Feb 2003 16:08:46 -0500
Date: Fri, 14 Feb 2003 13:18:26 -0800
To: Core <core@enodev.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, akpm@digeo.com
Subject: Re: compile fail: 2.5.60-mm2
Message-ID: <20030214211826.GA8302@triplehelix.org>
References: <20030214013144.2d94a9c5.akpm@digeo.com> <1045256371.16964.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <1045256371.16964.18.camel@localhost.localdomain>
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I received the same exact failure message. I tried enabling APIC support=20
but the same file failed to compile. I use gcc-3.2, though.

-Josh

On Fri, Feb 14, 2003 at 02:59:33PM -0600, Core wrote:
> Compile fail.
>=20
> config and make log attached.
[...]
> make -f scripts/Makefile.build obj=3Darch/i386/kernel/acpi
>   gcc296 -Wp,-MD,arch/i386/kernel/acpi/.boot.o.d -D__KERNEL__ -Iinclude -=
Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-commo=
n -pipe -mpreferred-stack-boundary=3D2 -march=3Dathlon -Iinclude/asm-i386/m=
ach-default -fomit-frame-pointer -nostdinc -iwithprefix include    -DKBUILD=
_BASENAME=3Dboot -DKBUILD_MODNAME=3Dboot -c -o arch/i386/kernel/acpi/.tmp_b=
oot.o arch/i386/kernel/acpi/boot.c
> In file included from arch/i386/kernel/acpi/boot.c:30:
> include/asm-i386/mach-default/mach_apic.h: In function `apic_id_registere=
d':
> include/asm-i386/mach-default/mach_apic.h:24: warning: implicit declarati=
on of function `apic_read'
> include/asm-i386/mach-default/mach_apic.h:24: `phys_cpu_present_map' unde=
clared (first use in this function)
> include/asm-i386/mach-default/mach_apic.h:24: (Each undeclared identifier=
 is reported only once
> include/asm-i386/mach-default/mach_apic.h:24: for each function it appear=
s in.)
> include/asm-i386/mach-default/mach_apic.h: In function `init_apic_ldr':
> include/asm-i386/mach-default/mach_apic.h:39: warning: implicit declarati=
on of function `apic_write_around'
> include/asm-i386/mach-default/mach_apic.h: In function `clustered_apic_ch=
eck':
> include/asm-i386/mach-default/mach_apic.h:53: `nr_ioapics' undeclared (fi=
rst use in this function)
> include/asm-i386/mach-default/mach_apic.h: At top level:
> include/asm-i386/mach-default/mach_apic.h:82: warning: `struct mpc_config=
_processor' declared inside parameter list
> include/asm-i386/mach-default/mach_apic.h:82: warning: its scope is only =
this definition or declaration, which is probably not what you want.
> include/asm-i386/mach-default/mach_apic.h: In function `mpc_apic_id':
> include/asm-i386/mach-default/mach_apic.h:85: dereferencing pointer to in=
complete type
> include/asm-i386/mach-default/mach_apic.h:86: dereferencing pointer to in=
complete type
> include/asm-i386/mach-default/mach_apic.h:86: `CPU_FAMILY_MASK' undeclare=
d (first use in this function)
> include/asm-i386/mach-default/mach_apic.h:87: dereferencing pointer to in=
complete type
> include/asm-i386/mach-default/mach_apic.h:87: `CPU_MODEL_MASK' undeclared=
 (first use in this function)
> include/asm-i386/mach-default/mach_apic.h:88: dereferencing pointer to in=
complete type
> include/asm-i386/mach-default/mach_apic.h:89: dereferencing pointer to in=
complete type
> include/asm-i386/mach-default/mach_apic.h:90: warning: control reaches en=
d of non-void function
> include/asm-i386/mach-default/mach_apic.h: In function `check_phys_apicid=
_present':
> include/asm-i386/mach-default/mach_apic.h:98: `phys_cpu_present_map' unde=
clared (first use in this function)
> In file included from arch/i386/kernel/acpi/boot.c:31:
> include/asm-i386/mach-default/mach_mpparse.h: At top level:
> include/asm-i386/mach-default/mach_mpparse.h:5: warning: `struct mpc_conf=
ig_translation' declared inside parameter list
> include/asm-i386/mach-default/mach_mpparse.h:5: warning: `struct mpc_conf=
ig_bus' declared inside parameter list
> include/asm-i386/mach-default/mach_mpparse.h: In function `mpc_oem_bus_in=
fo':
> include/asm-i386/mach-default/mach_mpparse.h:7: warning: implicit declara=
tion of function `Dprintk'
> include/asm-i386/mach-default/mach_mpparse.h:7: dereferencing pointer to =
incomplete type
> include/asm-i386/mach-default/mach_mpparse.h: At top level:
> include/asm-i386/mach-default/mach_mpparse.h:11: warning: `struct mpc_con=
fig_translation' declared inside parameter list
> include/asm-i386/mach-default/mach_mpparse.h:11: warning: `struct mpc_con=
fig_bus' declared inside parameter list
> include/asm-i386/mach-default/mach_mpparse.h:16: warning: `struct mp_conf=
ig_table' declared inside parameter list
> arch/i386/kernel/acpi/boot.c: In function `acpi_parse_lapic':
> arch/i386/kernel/acpi/boot.c:131: warning: implicit declaration of functi=
on `mp_register_lapic'
> arch/i386/kernel/acpi/boot.c: In function `acpi_parse_ioapic':
> arch/i386/kernel/acpi/boot.c:196: warning: implicit declaration of functi=
on `mp_register_ioapic'
> arch/i386/kernel/acpi/boot.c: In function `acpi_parse_int_src_ovr':
> arch/i386/kernel/acpi/boot.c:217: warning: implicit declaration of functi=
on `mp_override_legacy_irq'
> arch/i386/kernel/acpi/boot.c: In function `acpi_boot_init':
> arch/i386/kernel/acpi/boot.c:348: warning: implicit declaration of functi=
on `mp_register_lapic_address'
> arch/i386/kernel/acpi/boot.c:394: warning: implicit declaration of functi=
on `mp_config_acpi_legacy_irqs'
> arch/i386/kernel/acpi/boot.c:419: `smp_found_config' undeclared (first us=
e in this function)
> make[2]: *** [arch/i386/kernel/acpi/boot.o] Error 1
> make[1]: *** [arch/i386/kernel/acpi] Error 2
> make: *** [arch/i386/kernel] Error 2


--=20
New PGP public key: 0x27AFC3EE

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+TV0iT2bz5yevw+4RAjS8AJ9iVghY1I61N+tU1QCAzK+UMhcqEACg32NW
PDuLjOH+WKzOKrYkIlcKQbA=
=WsRj
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
