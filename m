Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267987AbUHEU4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267987AbUHEU4k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267972AbUHEUwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:52:40 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:9856 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S267964AbUHEUtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:49:19 -0400
Subject: Re: [PATCH] Fix x86_64 build of mmconfig.c
From: Tom Duffy <Tom.Duffy@Sun.COM>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040805223205.3dd2ee1a.ak@suse.de>
References: <1091728096.10131.16.camel@duffman>
	 <20040805223205.3dd2ee1a.ak@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sVOexEFTDzb8aIHEyD3U"
Date: Thu, 05 Aug 2004 13:49:16 -0700
Message-Id: <1091738956.3214.6.camel@duffman>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 (1.5.91-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sVOexEFTDzb8aIHEyD3U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-08-05 at 22:32 +0200, Andi Kleen wrote:
> It never failed this way for me in hundreds of builds. Why is it failing =
for you?

I don't know.

> What gcc version do you use?=20

$ gcc -v
Reading specs from /usr/lib/gcc-lib/x86_64-redhat-linux/3.3.3/specs
Configured with: ../configure --prefix=3D/usr --mandir=3D/usr/share/man --
infodir=3D/usr/share/info --enable-shared --enable-threads=3Dposix --
disable-checking --disable-libunwind-exceptions --with-system-zlib --
enable-__cxa_atexit --host=3Dx86_64-redhat-linux
Thread model: posix
gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)

> Normally -Ifoo and -I foo should be really equivalent.

You'd think.  It seems that everywhere else in the kernel, there is no
space in between -I and dir.

[linux-2.6.8-rc3]$ find -name Makefile -exec grep -H \\-I {} \;
./arch/i386/mach-generic/Makefile:EXTRA_CFLAGS  +=3D -I../kernel
./arch/i386/Makefile:mflags-$(CONFIG_X86_VOYAGER)       :=3D -Iinclude/asm-=
i386/mach-voyager
./arch/i386/Makefile:mflags-$(CONFIG_X86_VISWS) :=3D -Iinclude/asm-i386/mac=
h-visws./arch/i386/Makefile:mflags-$(CONFIG_X86_NUMAQ) :=3D -Iinclude/asm-i=
386/mach-numaq./arch/i386/Makefile:mflags-$(CONFIG_X86_BIGSMP)        :=3D =
-Iinclude/asm-i386/mach-bigsmp
./arch/i386/Makefile:mflags-$(CONFIG_X86_SUMMIT) :=3D -Iinclude/asm-i386/ma=
ch-summit
./arch/i386/Makefile:mflags-$(CONFIG_X86_GENERICARCH) :=3D -Iinclude/asm-i3=
86/mach-generic
./arch/i386/Makefile:mflags-$(CONFIG_X86_ES7000)        :=3D -Iinclude/asm-=
i386/mach-es7000
./arch/i386/Makefile:mflags-y +=3D -Iinclude/asm-i386/mach-default
./arch/i386/mach-voyager/Makefile:EXTRA_CFLAGS  +=3D -I../kernel
./arch/i386/boot/Makefile:HOSTCFLAGS_build.o :=3D -Iinclude
./arch/sparc64/kernel/Makefile:CFLAGS_ioctl32.o +=3D -Ifs/
./arch/sparc64/math-emu/Makefile:EXTRA_CFLAGS =3D -I. -Iinclude/math-emu -w
./arch/ppc/boot/lib/Makefile:CFLAGS_kbd.o       +=3D -Idrivers/char
./arch/ppc/boot/Makefile:CFLAGS         +=3D -fno-builtin -D__BOOTER__ -Iar=
ch/$(ARCH)/boot/include
./arch/ppc/boot/Makefile:HOSTCFLAGS     +=3D -Iarch/$(ARCH)/boot/include
./arch/ppc/platforms/Makefile:CFLAGS_pmac_setup.o       +=3D -Iarch/$(ARCH)=
/mm
./arch/ppc/Makefile:CPPFLAGS    +=3D -Iarch/$(ARCH)
./arch/ppc/Makefile:aflags-y    +=3D -Iarch/$(ARCH)
./arch/ppc/Makefile:cflags-y    +=3D -Iarch/$(ARCH) -msoft-float -pipe \
./arch/mips/lasat/image/Makefile:       $(CC) -fno-pic $(HEAD_DEFINES) -I$(=
TOPDIR)/include -c -o $@ $<
./arch/mips/kernel/Makefile:CFLAGS_ioctl32.o    +=3D -Ifs/
./arch/mips/Makefile:cflags-y                   :=3D -I $(TOPDIR)/include/a=
sm/gcc
./arch/mips/Makefile:cflags-$(CONFIG_MACH_JAZZ) +=3D -Iinclude/asm-mips/mac=
h-jazz
./arch/mips/Makefile:cflags-$(CONFIG_SOC_AU1X00)        +=3D -Iinclude/asm-=
mips/mach-au1x00
./arch/mips/Makefile:cflags-$(CONFIG_MIPS_PB1000)       +=3D -Iinclude/asm-=
mips/mach-pb1x00
./arch/mips/Makefile:cflags-$(CONFIG_MIPS_PB1100)       +=3D -Iinclude/asm-=
mips/mach-pb1x00
./arch/mips/Makefile:cflags-$(CONFIG_MIPS_PB1500)       +=3D -Iinclude/asm-=
mips/mach-pb1x00
./arch/mips/Makefile:cflags-$(CONFIG_MIPS_PB1550)       +=3D -Iinclude/asm-=
mips/mach-pb1x00
./arch/mips/Makefile:cflags-$(CONFIG_MIPS_DB1000)       +=3D -Iinclude/asm-=
mips/mach-db1x00
./arch/mips/Makefile:cflags-$(CONFIG_MIPS_DB1100)       +=3D -Iinclude/asm-=
mips/mach-db1x00
./arch/mips/Makefile:cflags-$(CONFIG_MIPS_DB1500)       +=3D -Iinclude/asm-=
mips/mach-db1x00
./arch/mips/Makefile:cflags-$(CONFIG_MIPS_BOSPORUS)     +=3D -Iinclude/asm-=
mips/mach-db1x00
./arch/mips/Makefile:cflags-$(CONFIG_MIPS_MIRAGE)       +=3D -Iinclude/asm-=
mips/mach-db1x00
./arch/mips/Makefile:cflags-$(CONFIG_MACH_DECSTATION)+=3D -Iinclude/asm-mip=
s/mach-dec
./arch/mips/Makefile:cflags-$(CONFIG_MIPS_EV64120)      +=3D -Iinclude/asm-=
mips/mach-ev64120
./arch/mips/Makefile:cflags-$(CONFIG_MIPS_EV96100)      +=3D -Iinclude/asm-=
mips/mach-ev96100
./arch/mips/Makefile:cflags-$(CONFIG_MIPS_ATLAS)        +=3D -Iinclude/asm-=
mips/mach-atlas
./arch/mips/Makefile:cflags-$(CONFIG_MIPS_ATLAS)        +=3D -Iinclude/asm-=
mips/mach-mips
./arch/mips/Makefile:cflags-$(CONFIG_MIPS_MALTA)        +=3D -Iinclude/asm-=
mips/mach-mips
./arch/mips/Makefile:cflags-$(CONFIG_MOMENCO_OCELOT)    +=3D -Iinclude/asm-=
mips/mach-ocelot
./arch/mips/Makefile:cflags-$(CONFIG_PMC_YOSEMITE)      +=3D -Iinclude/asm-=
mips/mach-yosemite
./arch/mips/Makefile:cflags-$(CONFIG_MOMENCO_JAGUAR_ATX)        +=3D -Iincl=
ude/asm-mips/mach-ja
./arch/mips/Makefile:cflags-$(CONFIG_LASAT)             +=3D -Iinclude/asm-=
mips/mach-lasat
./arch/mips/Makefile:cflags-$(CONFIG_MACH_VR41XX)       +=3D -Iinclude/asm-=
mips/mach-vr41xx
./arch/mips/Makefile:cflags-$(CONFIG_SGI_IP22)  +=3D -Iinclude/asm-mips/mac=
h-ip22
./arch/mips/Makefile:# SGI-IP27 (Origin200/2000)
./arch/mips/Makefile:cflags-$(CONFIG_SGI_IP27)  +=3D -Iinclude/asm-mips/mac=
h-ip27
./arch/mips/Makefile:# SGI-IP32 (O2)
./arch/mips/Makefile:cflags-$(CONFIG_SGI_IP32)  +=3D -Iinclude/asm-mips/mac=
h-ip32
./arch/mips/Makefile:cflags-$(CONFIG_SNI_RM200_PCI)     +=3D -Iinclude/asm-=
mips/mach-rm200
./arch/mips/Makefile:cflags-y                   +=3D -Iinclude/asm-mips/mac=
h-generic
./arch/sparc/math-emu/Makefile:EXTRA_CFLAGS =3D -I. -I$(TOPDIR)/include/mat=
h-emu -w
./arch/um/kernel/Makefile:      -I/usr/include -I../include
./arch/um/sys-ppc/Makefile:EXTRA_AFLAGS :=3D -DCONFIG_PPC32 -I. -I$(TOPDIR)=
/arch/ppc/kernel
./arch/um/Makefile:ARCH_INCLUDE =3D -I$(ARCH_DIR)/include
./arch/um/Makefile:USER_CFLAGS :=3D $(patsubst -I%,,$(CFLAGS))
./arch/cris/arch-v10/boot/compressed/Makefile:CC =3D gcc-cris -melf -I $(TO=
PDIR)/include
./arch/cris/arch-v10/boot/rescue/Makefile:CC =3D gcc-cris -mlinux -I $(TOPD=
IR)/include
./arch/m68k/Makefile:CHECK :=3D $(CHECK) -D__mc68000__=3D1 -I$(shell $(CC) =
-print-file-name=3Dinclude)
./arch/ia64/ia32/Makefile:CFLAGS_ia32_ioctl.o +=3D -Ifs/
./arch/ppc64/kernel/Makefile:CFLAGS_ioctl32.o +=3D -Ifs/
./arch/ppc64/boot/Makefile:BOOTCFLAGS   :=3D $(HOSTCFLAGS) -Iinclude -fno-b=
uiltin
./arch/parisc/kernel/Makefile:CFLAGS_ioctl32.o :=3D -Ifs/
./arch/v850/Makefile:OBJCOPY_FLAGS_BLOB :=3D -I binary -O elf32-little -B v=
850e
./arch/x86_64/ia32/Makefile:CFLAGS_ia32_ioctl.o +=3D -Ifs/
./arch/x86_64/boot/compressed/Makefile:CFLAGS :=3D -m32 -D__KERNEL__ -Iincl=
ude -O2                                                                    =
           =20
./arch/x86_64/pci/Makefile:CFLAGS +=3D -Iarch/i386/pci
./arch/s390/math-emu/Makefile:EXTRA_CFLAGS :=3D -I$(src) -Iinclude/math-emu=
 -w
./arch/s390/boot/Makefile:EXTRA_CFLAGS  :=3D -DCOMPILE_VERSION=3D$(COMPILE_=
VERSION) -gstabs -I.
./drivers/net/sk98lin/Makefile:EXTRA_CFLAGS +=3D -Idrivers/net/sk98lin -DSK=
_DIAG_SUPPORT -DSK_USE_CSUM -DGENESIS -DYUKON $(DBGDEF) $(SKPARAM)
./drivers/net/wireless/prism54/Makefile:EXTRA_CFLAGS =3D -I$(PWD) #-DCONFIG=
_PRISM54_WDS
./drivers/net/skfp/Makefile:EXTRA_CFLAGS +=3D -Idrivers/net/skfp -DPCI -DME=
M_MAPPED_IO -Wno-strict-prototypes
./drivers/net/wan/lmc/Makefile:EXTRA_CFLAGS +=3D -I. $(DBGDEF)
./drivers/net/wan/Makefile:     $(CPP) -Wp,-MD,$(depfile) -I$(srctree)/incl=
ude $< | $(AS68K) -m68360 -o $(obj)/wanxlfw.o; \
./drivers/media/video/saa7134/Makefile:EXTRA_CFLAGS =3D -I$(src)/..
./drivers/media/video/cx88/Makefile:EXTRA_CFLAGS =3D -I$(src)/..
./drivers/media/dvb/frontends/Makefile:EXTRA_CFLAGS =3D -Idrivers/media/dvb=
/dvb-core/
./drivers/media/dvb/ttusb-budget/Makefile:EXTRA_CFLAGS =3D -Idrivers/media/=
dvb/dvb-core/
./drivers/media/dvb/bt8xx/Makefile:EXTRA_CFLAGS =3D -Idrivers/media/dvb/dvb=
-core/ -Idrivers/media/video -Idrivers/media/dvb/frontends
./drivers/media/dvb/ttpci/Makefile:EXTRA_CFLAGS =3D -Idrivers/media/dvb/dvb=
-core/
./drivers/media/dvb/b2c2/Makefile:EXTRA_CFLAGS =3D -Idrivers/media/dvb/dvb-=
core/
./drivers/media/dvb/ttusb-dec/Makefile:EXTRA_CFLAGS =3D -Idrivers/media/dvb=
/dvb-core/
./drivers/usb/storage/Makefile:EXTRA_CFLAGS     :=3D -Idrivers/scsi
./drivers/scsi/aic7xxx/aicasm/Makefile:AICASM_CFLAGS:=3D -I/usr/include -I.
./drivers/scsi/aic7xxx/Makefile:EXTRA_CFLAGS +=3D -Idrivers/scsi
./drivers/scsi/aic7xxx/Makefile:        $(obj)/aicasm/aicasm -I$(src) -r $(=
obj)/aic7xxx_reg.h \
./drivers/scsi/aic7xxx/Makefile:        $(obj)/aicasm/aicasm -I$(src) -r $(=
obj)/aic79xx_reg.h \
./drivers/scsi/pcmcia/Makefile:EXTRA_CFLAGS             +=3D -Idrivers/scsi
./drivers/scsi/aacraid/Makefile:EXTRA_CFLAGS    :=3D -Idrivers/scsi
./drivers/ide/pci/Makefile:EXTRA_CFLAGS :=3D -Idrivers/ide
./drivers/ide/legacy/Makefile:EXTRA_CFLAGS      :=3D -Idrivers/ide
./drivers/ide/arm/Makefile:EXTRA_CFLAGS :=3D -Idrivers/ide
./drivers/ide/Makefile:EXTRA_CFLAGS                             +=3D -Idriv=
ers/ide./drivers/atm/Makefile: objcopy -Iihex $< -Obinary $@.gz
./drivers/md/raid6test/Makefile:CFLAGS   =3D -I.. -g $(OPTFLAGS)
./fs/xfs/Makefile:EXTRA_CFLAGS +=3D        -Ifs/xfs -Ifs/xfs/linux-2.6 -fun=
signed-char
./fs/smbfs/Makefile:    cproto -E "gcc -E" -e -v -I $(TOPDIR)/include -DMAK=
ING_PROTO -D__KERNEL__ $(SRC) >> proto2.h
./scripts/kconfig/Makefile:HOSTCFLAGS_lex.zconf.o       :=3D -I$(src)
./scripts/kconfig/Makefile:HOSTCFLAGS_zconf.tab.o       :=3D -I$(src)
./scripts/kconfig/Makefile:HOSTCXXFLAGS_qconf.o =3D -I$(QTDIR)/include
./scripts/lxdialog/Makefile:        HOST_EXTRACFLAGS +=3D -I/usr/include/nc=
urses -DCURSES_LOC=3D"<ncurses.h>"
./scripts/lxdialog/Makefile:        HOST_EXTRACFLAGS +=3D -I/usr/include/nc=
urses -DCURSES_LOC=3D"<ncurses/curses.h>"
./scripts/genksyms/Makefile:# -I needed for generated C source (shipped sou=
rce)
./scripts/genksyms/Makefile:HOSTCFLAGS_parse.o :=3D -Wno-uninitialized -I$(=
src)
./scripts/genksyms/Makefile:# -I needed for generated C source (shipped sou=
rce)
./scripts/genksyms/Makefile:HOSTCFLAGS_lex.o :=3D -I$(src)
./security/selinux/Makefile:EXTRA_CFLAGS +=3D -Isecurity/selinux/include
./security/selinux/ss/Makefile:EXTRA_CFLAGS +=3D -Isecurity/selinux/include
./Makefile:CPPFLAGS        :=3D -D__KERNEL__ -Iinclude \
./Makefile:                $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/inclu=
de)
./Makefile:#    Exuberant ctags works better with -I
./Makefile:     CTAGSF=3D`ctags --version | grep -i exuberant >/dev/null &&=
 echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_NOVERS"`; \


-tduffy

--=-sVOexEFTDzb8aIHEyD3U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBEp1MdY502zjzwbwRApIXAJwOJrbIaWAd+nGt47tBsLmjOKcU5wCfWV9K
QZsGn8droSZNmEeaDChWxnE=
=nWDY
-----END PGP SIGNATURE-----

--=-sVOexEFTDzb8aIHEyD3U--
