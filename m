Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTITUus (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 16:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbTITUus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 16:50:48 -0400
Received: from ns2.len.rkcom.net ([80.148.32.9]:47528 "EHLO ns2.len.rkcom.net")
	by vger.kernel.org with ESMTP id S261965AbTITUu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 16:50:29 -0400
From: Florian Schanda <ma1flfs@bath.ac.uk>
Reply-To: ma1flfs@bath.ac.uk
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.0-test5 compile and/or link problem
Date: Sat, 20 Sep 2003 22:51:14 +0000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_inNb/m9sHOS2PTb"
Message-Id: <200309202251.35053.ma1flfs@bath.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_inNb/m9sHOS2PTb
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

scripts/ver_linux is

Linux omoikane 2.4.22-xfs #3 SMP Wed Sep 17 18:13:33 Local time zone must b=
e=20
set--see zic  i686 unknown
=20
Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11w
mount                  2.11w
e2fsprogs              1.29
xfsprogs               2.5.4
nfs-utils              1.0.3
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 3.0.4
Net-tools              1.60
Kbd                    1.08
Sh-utils               2.0
Modules Loaded         sr_mod snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-pcm=
=20
snd-page-alloc snd-timer snd-ac97-codec snd-rawmidi snd-seq-device=20
snd-util-mem snd-hwdep snd soundcore nvidia keybdev hid mousedev input=20
usb-uhci usbcore e100 rtc ext2 raid0 md ide-cd cdrom ide-scsi ide-disk piix=
=20
ide-detect ide-core unix

with the attached .config file I get a linking error (during `make V=3D1`):

make -f scripts/Makefile.build obj=3Darch/i386/lib
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall=20
=2D -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common=
=20
=2D -pipe -mpreferred-stack-boundary=3D2 -march=3Dpentium4 -mcpu=3Dpentium4=
 -Iinclude/
asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwi
thprefix include    -DKBUILD_BASENAME=3Dversion -DKBUILD_MODNAME=3Dversion =
=2Dc -o=20
init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/
mounts.o init/initramfs.o
        ld -m elf_i386  -T arch/i386/kernel/vmlinux.lds.s arch/i386/kernel/
head.o arch/i386/kernel/init_task.o   init/built-in.o --st
art-group  usr/built-in.o  arch/i386/kernel/built-in.o  arch/i386/mm/
built-in.o  arch/i386/mach-default/built-in.o  kernel/built-in.o
  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/
built-in.o  lib/lib.a  arch/i386/lib/lib.a  lib/built-in.
o  arch/i386/lib/built-in.o  drivers/built-in.o  sound/built-in.o  arch/i38=
6/
pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmli
nux1
drivers/built-in.o(.text+0x29e8a): In function `ide_match_hwif':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x29e8f): In function `ide_match_hwif':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x29eb9): In function `ide_match_hwif':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x29ed8): In function `ide_match_hwif':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x29edd): In function `ide_match_hwif':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x29ee2): more undefined references to `ide_hwifs'=
=20
follow
drivers/built-in.o(.text+0x2a7a0): In function `ide_setup_pci_controller':
: undefined reference to `noautodma'
drivers/built-in.o(.text+0x2acc1): In function `ide_setup_pci_device':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x2acc9): In function `ide_setup_pci_device':
: undefined reference to `probe_hwif_init'
drivers/built-in.o(.text+0x2ace6): In function `ide_setup_pci_device':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x2acee): In function `ide_setup_pci_device':
: undefined reference to `probe_hwif_init'
drivers/built-in.o(.text+0x2ad6a): In function `ide_setup_pci_devices':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x2ad72): In function `ide_setup_pci_devices':
: undefined reference to `probe_hwif_init'
drivers/built-in.o(.text+0x2ad8f): In function `ide_setup_pci_devices':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x2ad97): In function `ide_setup_pci_devices':
: undefined reference to `probe_hwif_init'
drivers/built-in.o(.text+0x2adb6): In function `ide_setup_pci_devices':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x2adbe): In function `ide_setup_pci_devices':
: undefined reference to `probe_hwif_init'
drivers/built-in.o(.text+0x2addd): In function `ide_setup_pci_devices':
: undefined reference to `ide_hwifs'
drivers/built-in.o(.text+0x2ade5): In function `ide_setup_pci_devices':
: undefined reference to `probe_hwif_init'
drivers/built-in.o(.text+0x2b4f8): In function `__ide_dma_off_quietly':
: undefined reference to `ide_toggle_bounce'
drivers/built-in.o(.text+0x2b5e9): In function `__ide_dma_on':
: undefined reference to `ide_toggle_bounce'
drivers/built-in.o(.text+0x2b765): In function `__ide_dma_read':
: undefined reference to `ide_execute_command'
drivers/built-in.o(.text+0x2b82e): In function `__ide_dma_write':
: undefined reference to `ide_execute_command'
drivers/built-in.o(.text+0x2bac0): In function `__ide_dma_verbose':
: undefined reference to `eighty_ninty_three'
drivers/built-in.o(.init.text+0x3c3e): In function `init_hwif_generic':
: undefined reference to `noautodma'
make: *** [.tmp_vmlinux1] Error 1


Is this a known problem?

BTW, by setting CONFIG_IDE to M instead to Y, the kernel & modules compiles=
=2E=20
(Although there are some warnings such as:)

  Building modules, stage 2.
  AS      arch/i386/boot/bootsect.o
  AS      arch/i386/boot/setup.o
  HOSTCC  arch/i386/boot/tools/build
  MODPOST
  AS      arch/i386/boot/compressed/head.o
  CC      arch/i386/boot/compressed/misc.o
  LD      arch/i386/boot/bootsect
  OBJCOPY arch/i386/boot/compressed/vmlinux.bin
*** Warning: "ide_pci_unregister_driver" [drivers/ide/pci/piix.ko] undefine=
d!
*** Warning: "ide_pci_register_driver" [drivers/ide/pci/piix.ko] undefined!
*** Warning: "ide_setup_pci_device" [drivers/ide/pci/piix.ko] undefined!
*** Warning: "ide_setup_dma" [drivers/ide/pci/piix.ko] undefined!
*** Warning: "ide_pci_register_host_proc" [drivers/ide/pci/piix.ko] undefin=
ed!
  LD      arch/i386/boot/setup
*** Warning: "proc_ide_destroy" [drivers/ide/ide.ko] undefined!
*** Warning: "ide_remove_proc_entries" [drivers/ide/ide.ko] undefined!
*** Warning: "ide_add_proc_entries" [drivers/ide/ide.ko] undefined!
*** Warning: "proc_ide_create" [drivers/ide/ide.ko] undefined!
*** Warning: "ide_scan_pcibus" [drivers/ide/ide.ko] undefined!
*** Warning: "create_proc_ide_interfaces" [drivers/ide/ide.ko] undefined!
*** Warning: "ide_release_dma" [drivers/ide/ide.ko] undefined!
*** Warning: "destroy_proc_ide_drives" [drivers/ide/ide.ko] undefined!
*** Warning: "proc_ide_read_capacity" [drivers/ide/ide.ko] undefined!
*** Warning: "idedefault_driver" [drivers/ide/ide.ko] undefined!
*** Warning: "create_proc_ide_interfaces" [drivers/ide/ide-probe.ko]=20
undefined!
*** Warning: "ide_bus_type" [drivers/ide/ide-probe.ko] undefined!
*** Warning: "ide_add_generic_settings" [drivers/ide/ide-probe.ko] undefine=
d!
*** Warning: "idedefault_driver" [drivers/ide/ide-probe.ko] undefined!
*** Warning: "ide_cfg_sem" [drivers/ide/ide-probe.ko] undefined!
*** Warning: "blk_queue_activity_fn" [drivers/ide/ide-probe.ko] undefined!
*** Warning: "do_ide_request" [drivers/ide/ide-probe.ko] undefined!
*** Warning: "proc_ide_read_geometry" [drivers/ide/ide-disk.ko] undefined!
*** Warning: "blk_rq_prep_restart" [drivers/ide/ide-disk.ko] undefined!


but module_install fails with this:


WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/pci/piix.ko needs unkn=
own=20
symbol ide_setup_pci_device
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/pci/piix.ko needs unkn=
own=20
symbol ide_pci_register_host_proc
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/pci/piix.ko needs unkn=
own=20
symbol ide_setup_dma
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/pci/piix.ko needs unkn=
own=20
symbol ide_pci_unregister_driver
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/pci/piix.ko needs unkn=
own=20
symbol ide_pci_register_driver
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide.ko needs unknown=20
symbol ide_scan_pcibus
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide.ko needs unknown=20
symbol ide_release_dma
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide.ko needs unknown=20
symbol create_proc_ide_interfaces
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide.ko needs unknown=20
symbol ide_add_proc_entries
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide.ko needs unknown=20
symbol proc_ide_read_capacity
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide.ko needs unknown=20
symbol destroy_proc_ide_drives
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide.ko needs unknown=20
symbol idedefault_driver
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide.ko needs unknown=20
symbol proc_ide_destroy
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide.ko needs unknown=20
symbol ide_remove_proc_entries
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide.ko needs unknown=20
symbol proc_ide_create
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide-probe.ko needs=20
unknown symbol create_proc_ide_interfaces
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide-probe.ko needs=20
unknown symbol ide_cfg_sem
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide-probe.ko needs=20
unknown symbol ide_bus_type
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide-probe.ko needs=20
unknown symbol idedefault_driver
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide-probe.ko needs=20
unknown symbol do_ide_request
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide-probe.ko needs=20
unknown symbol ide_add_generic_settings
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide-probe.ko needs=20
unknown symbol blk_queue_activity_fn
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide-disk.ko needs unkn=
own=20
symbol proc_ide_read_geometry
WARNING: /lib/modules/2.6.0-test5/kernel/drivers/ide/ide-disk.ko needs unkn=
own=20
symbol blk_rq_prep_restart
WARNING: Module /lib/modules/2.6.0-test5/kernel/drivers/scsi/ide-scsi.ko=20
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test5/kernel/drivers/ide/pci/piix.ko=20
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test5/kernel/drivers/ide/ide.ko ignored,=
=20
due to loop
WARNING: Module /lib/modules/2.6.0-test5/kernel/drivers/ide/ide-taskfile.ko=
=20
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test5/kernel/drivers/ide/ide-probe.ko=20
ignored, due to loop
WARNING: Loop detected: /lib/modules/2.6.0-test5/kernel/drivers/ide/
ide-iops.ko needs ide.ko which needs ide-iops.ko again!
WARNING: Module /lib/modules/2.6.0-test5/kernel/drivers/ide/ide-iops.ko=20
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test5/kernel/drivers/ide/ide-io.ko ignor=
ed,=20
due to loop
WARNING: Module /lib/modules/2.6.0-test5/kernel/drivers/ide/ide-disk.ko=20
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test5/kernel/drivers/ide/ide-default.ko=
=20
ignored, due to loop
WARNING: Module /lib/modules/2.6.0-test5/kernel/drivers/ide/ide-cd.ko ignor=
ed,=20
due to loop

Any ideas? Or did I do something wrong?

Thanks in advance,

	Florian
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/bNnnfCf8muQVS4cRAk3gAKCNz124skR2HoBJ07bWuY+RsMNxQwCfdquC
3fiHRTpXpH5oC4y5kBjSmyw=3D
=3DUBC/
=2D----END PGP SIGNATURE-----

--Boundary-00=_inNb/m9sHOS2PTb
Content-Type: application/x-bzip2;
  name="config.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.bz2"

QlpoOTFBWSZTWU1R3SQABhjfgEAQWOf/8j////C////gYBfcAAlOhyG2E+wYtaz3ZgCxpqrrQ5AK
xUYdnUJEO2itZuynS3cXGnHTthtmNGoNNEEyADRATSYVP1PSaTxT8iGFNoMkPUGmhGgImQGpPQqe
U9EA0AGjIAAFU/JPRT1NDTRoaGg00DQaA0AMgABJpJCp4TQUeimCfqIYIMQNGjQAyAcZMmTEYmAE
yYJkANGEYAhgEiQCAI0Q0qeqPympnpIyaA0yMgAB1+n7j/w/2QUqVkpa8r63TATKVFFJpowa22y2
wwSsPvXlJiHbNIP8f5Zihr5byybLkNiaYVDgIQv34bpuzUTH/NwcqUby/n92Gja1e4JR7i1OrFh4
JioGXWFSKGZ30phI6LUrcsKqiKuMKmCFLSDbgrjghkccG5Z8KGOXWFzEyVigLFiiJUIsQSiYhBZF
VTMiVYSsgtZEtFJmUiwKyLLaGJjJWFW2XKFRZUlRQUVQMRaEIKNd/fua2xLcZFMy3JhSXKTMMxG4
swqgiRqV9KamJorh6IaMrdYy5gZchcMbiY5cwa57M1M0XKmYJdm6PhzY1NW5a5UzMwymGXG0Mq3F
UzGhLlrDCSFCpZT1tnJ6Mcz3+zb02p0IG47Een7L2wUABECcjZavlNb/so9TVR2ev7nGxwH2Pwx+
LBLPaCLWQbyJFxTOdPLOvi6qca23+L5d5yRGLDTwnqRGc01ysyARFU+7vlnvjMtFIEJIpyvVNiBT
TaqdvFeJ/jf8Z09BPLaNphm0J+ZpPOw6E4On6dpQyVoLOVWkIU/A9no2+XevGOJDWzhXqjfwzUvM
oO4LEQmB5onw3HWSaOisoBTSSuRMqWytGjz/uQaRxYTljlmyzi0Qvv1JorVs2+Nvlt7q317pPmOO
qVDhu3fSfDdtGk4mext48avfB4hljSYbHhGurgzmv2w38w17mg6aiA4HjXwGhwstMdNhD3HIcV54
14Q3u1zXUT4XZ3UW5Wbe7nGGPziYMsGMIPWq2q+mOGQ4Obds8jUhq8pP49av7n89eKztX2Vte+Ho
/hteN5PJ+Mse7ym/gn2e/P3ztt5j2YQeFUZZ+c28V6d7/Aaeke0m1vDLW+sRjBv0dX0z4xzG62qG
DCmIzwV86c6n27rJQGs5PoytdZrjFLcRw868rFMXunQftHewqb8Le/w8R4fjAhEQIE/Er7fV6+EY
bM8TqE3xCIgQI+lj/qbcvW3mZV32384BxhhCp3qXODp+7yLqvZ9PiERAEQefyCAQwPGung8v8Vg1
+855LFFybyukPI/m0GVMdXuAdhTk501MG80MDRGfITIMQDCBIHWWg8gQgKTZUmakOS9GdwqqaLBA
Mgrj6WefpWGuafra9b1mG+m62r/TvP+lXv08q8LMLPd9R7jiD1iy2sOt2/lzuumLvDg6YdZyIl+c
I8tPHaTSXhpzawlohma29+nv3iTuq3p3tzc6uBM++jYHi5WbgBFDTeovdcLwfO7dZE69m0Mp1brs
dXh51sGbsdHCOyj4C/G4iFm7CwZ3TWq+LOsXhznFtpeWDt9PXOjr30b6und9b7izZlrKQ76zd+Oq
+soqo18u+UhGkhQJbx0HVtLmwhPc+jc94ihiZGtFc3GSrRby79DaVb76e81RdUgTaBtImMG0eudb
8x088ydzi+boRKARy0sgsHLDB+bjWw6ud03dfZpvGbwIoEjrTF4A5sCiABYrz5AJ+nZnyz2VGExb
apt133yV8AuAUHr6oMuEOL8xAc7QE9W6MFuNald/Jwr3w5d8OzeoWuHdPqpwwNkttNaXVhojtdSX
w7IOqEuPLnU6x7SrWvgqh83iqzKb9YKK7lWpXEcD3Ms9yYydtk/qODxDdNnxrgz1lu+F3Cat8Ivp
IcPc+cTaLXgaN09xGoNI5z1fU9vlF5do1oKae9X70wXdl15+ve+nmuvPbTYO7SmTl6PlqPSU5R9L
93Grek6qczWtqRKXLaRe0qqdHULw7yMNJ1dnHsijOSQ67aiONlRjBK1uFTh8T+B8SNLsJS1ENz97
Ko1YCDLMnEjyxIgmJE0oj37W4KM4qFae77k+2O7FY2eAt4oqFlcdbSJ6C9IQ3LY99Kr51vyYPYSL
05ElsxTXE4m1wlxU2uedSgAOGFE84Ocr/ejzvW4FawYhctgwmChBA4Rqv1pCs154zZoKjimWsOGh
ahI8v1fiJzWmcc5T23P+H0+KZnzf4xRHEoq0hLTS6JL32+ZFWXZrWHwwCMmZWGMBs1a2cmCZQqDh
ezMVixRBO0PSdeDW1fPjJkS7DkcdNIEBBL7lYnWkPbDiStIMY0Gs5So4UrX34Tzfiyy4kSvBGdCh
pn7ahj0PJUXnhIylDYtUw01autocVHSEORtEqMSObWoTt5jlH7BgoLBVRAUGMWCgxBBVGIkYixEB
YosZBQViyMQWKKsFGIiQUUjEVQUVGIoIKKKiMixBFggxYxYLGMWKyMigrBRgiqiKwEVWCMFVFRZA
URIKoqKKCMRRxpFBBBRSRYCqAiiAsgsRjGERURVGKirFZBVYhBYiKjBUFEQixYxoYMJAfLzvH49T
mias1zScjutTmQkbTSABXRPWm0yU4lXilzdXFBeGBLwzZA0KJdvQ6+8a9q309NKCXdVvI/Q7dJNg
WiQwqgpcEoMt0Pky4nvD9bvjEZv+1e4F0mZ25iTXmcasoggmYQAkXVIUFTSaJBMR8+34c45WHkyE
KgjCcJXr5Znhk1LyJxO1VBBETUFgFIB6k4Heb0UeJBnEtvbLyQgXQ/FrNqobPVgFOCEroqDJGSA7
RbSFeihTaVJwM94CT3EU0JeXxi3TpOuU95zfrwtn5aWXcaUEafeIb6qWJExc2YhzkpDUfiUYHFbI
DvSOisO1jQnpXSTt81CaRRU4PJgMsWGUnVnz1h+xXI0oFCxbSPE5blA8tVUgq7cDPcODihbMrhNY
NJqGAqlDablZTtxnqaZxHiDjG2QqYlBUBNFQZ9JbmcI5FtqvRZbtklNz8dLH0iIYiqmgHdrTEZvH
TLEu+kdM7NBmwhmSVxoQEFs/dEgkBNsBEG2BvULXcRoG6y0SccAdobTzsunAWzSD7tQ/p5+LpJCE
eJ6e9uXOWat8RWvh0Bohr0MSq0SZdoMMky7Xr3rgLc77+fbMx23413++/5t+JX4GpzOTsVhcHrv8
B+RqFdjGtb8Wllw+jc6jZQSnxpTwcMlzMLTpuQJG+BRAP8m853UP5lNyHfy33EhCbMhJySSCgQUI
LICwIsgSKAdmQkqSEYkkk8g7g996GY1gG2wxfErMYrJw2yt+phId2HVVFnujaEocwaUzAea4q4cU
4jjgtaamdSpcijxdmTbcZQtS97g8u0u8LcHq8ye5T536EShPfcwoxyZZFnJ55A30xwdjMAsZkJRc
lT061+dL8VPRlAtz5mhIQifgfw/PWpzFlbQMlWfbblS2kqINk47+ZG5PUjadGktWn7RFlE1Zzk2c
bpJvMkmyYWLbaln41uHhzfXaBHbcvEiDdEX+IeRKUqlhSQvoPLHGHqkveITKu8zy60pLua3ySc/K
1BYM4ZmFeatePX2yGl8JOkI/CcZ45Pv9tlZW9zIvxEPkoUlAxVkyAlzHPtOH0FiiIEgazU8u1weu
8i3SvJ1ca9ZSRxJuGx8BmJ4tnulhN5i9i0C6jp6OiLyrSet4wtDFgOB0jiq2rqqYvZ9EARG7UjeN
COw3kpQm/lFQSFF3SMdJ1BnCSDU3aK9sG3XEXyDjma/iZg4pdwYtIlvWOM6YGlPiyKZ6dKrS0V9X
hFnUb1Uz80diKACvZG3KbszY4GQENGd1vSZrmwqpjTq/taDbfXInaIyhtZs3dmE394D5kg4aHmMh
eJZS51jS1JGzXD+zOlfhqSOWEumDM3lSugfVoJmyTehzZyymuKLyd0zp2TeYcTLv37FeE0OiTSEU
DdAdjdsvr7rfUHudTh4m7xZVEFkNAEhCwsjOfO+ra4CKibQIY5tmQ15mUgbGsu5hkltN/Xo2XexJ
vLLubpoxCTw4veTguErGmMUR3S21SKGsmQXNAh2TpRsQ1BWjvOQ20Ogz28tpIrnJDzvX66TbPGYi
uvo95GMm7yGB+WhlsrGflxJcBOkCOGc/Tgtw0kgQIM6bvSSIpHNJvfT2zGcCyiN02lpGLxkc8dBG
cxX3G1tpnSEUKbHsdR3vwtO4HxYOcu5syfXkzmUdVHb4q3ZFRXVSg9Ae2X1ebCXLQ8njZXPXHODI
KuFJMh8nUYCIOy4ITuQBfWq7uuy7bcS95JkoATBDiikEVB2bZH2SXMOe9Hz67qK5KSrgLSYZo2hG
mCkUXIUZLCkpw46LdGRIKJEwsaAmHpqIPcsZXZfuIIuE8sOXkJ0iQ2NfPHcFvX83HYz3RFVBIi2s
LDVGEMIH8s6w64nXdz8xbVQOfcM2ChxZ6igaaiZTcoDu6jlRGSxafkpUWkoAsODDIUdUE5w8vTxS
IHtacpXuLIchlFbwQMlFH5BR+bsDLhjepN+xi+85hiaTUMyK6Iiu2chiBxTD9JmXuU/VwfDM/aBs
k5NBvx5zmez+XWe+jnEGJmPp2LUgpUl4zqigw5TUO7IzgKvqdJV2+0p5KusGaEln4kRBuvEHg+GY
khLWULR3wcFyizXVu8gi/PUgmZQkay3JExohl0nrlYadBJtfaqilDdj7KSQyExKecnahSjcNcTkK
nlutsIIsyudcoyXBoZF6r3KIxkXvG7zfl5MM5CQ+5AxBt3gchKctKdpEMoxUjoiJbtt0vrq4ayvp
RTJ7uxG1fYT98BoDp2xrg1WXIt4eGorSC5PrGKzOhO1rIygW6w7lgQ4Khe4lkSAsLGqOCNTUNEKt
ZJ2bsDP5qOrYOMaZTd2SKsKapLVQPqlqO2a1lSe5ox+vxvtUoAXN+S+BLTZU2NRsdbVcfRMSwIUN
ndU28LmepqFuK58WVnMTgQovTVxgqCK+7Dl02befwdva36Bwd+HKlE9AUQMLKtk8JfaocCW+ZMwa
AL0y5HUGyUE5kRqT8T13SNmsEmkIwk11Q72rnaBhW3ARNJRuoy7BOophJcHAOIdKE3iks07RnNni
9+pTp3XmhnFNjKbJhJWSQ6nZYveQRLXFzPFhFzI6kKmBnPSZHhaPI3JDiL6X4wB+PPH81ayBBv5I
ZfT1Ne7ozJhA6JNxX8d/p9JTXz+nDA5mFBow9WoiFDVIl65be/MpZ57xXqJIXk/jBV5GfIIBJpkS
IrbUvhcJgeiFyQogy5LLq3tFpj4/A6mhblIDbc5trnAs8+rS70BfGtCQNq/i94IImVnviYSdYiyO
+JEpxDMmm0CVpRnVWIkRh1+/AmWA+JnoDar6hEF85yfl89usodfmLyuGzANSDh888RLKpKPVDtgG
xeZGVuINqrWkEkIJMBtDaIyzxeenaKunaFbeDNlTEIlaTTX5swKEbB+pcgoGVUQA+mWE5HBZM2Ue
d03I2IEOKpQ2EdfZ1tp6c2JGZBLzeNYrk2lhcyLUGGMZrZzcGTxYYZtxqc0N9rxOKiKoojYxtSYD
dpQAT5vJ9/f1MJmajDEV6jV7AnEoCo9U4Giho8SKMxTZSpiCjRtGJJWau7Jly0E2izIGr3LyUOmc
B3zpdhNZ33+dGnTq8/DUK9zOSQOm9AxJBQCvXv+DWiKKnLGGErRrgXlPzuYfSQqR1p66n5YbXquu
tpc7N15syIdlfYcrO05MOe94pJyK9XefKcp6sMbBWQizKLY/pRKSPlRS62XWwokj0WDq8newbChk
CJy5Kx26YV5kNEykQnt40plesn4ZHiEaZwhIbFNPl5pDxIQUtRbYUWI8TEHTAljVUOHjAZ/Yzanb
hxUzNCBcFyLEAINotzkSWXiy0oea88SZDK3Z2ZQ4sU0i9kASwog1Zhc4JGraLmIFXvT3eX9gfP2/
l6jq3/v0H1yktlhEf3JfZDI1fdLgP4JTnYlYxnll3dg+Yi8+deWLsQUt3tExGSf0NX67fmqfyaER
KAGKORgAxJh7fd7O/prd0b5rSeqKooru3U1tpPs4k+xkHJAOZrdzIgnOfajCh/ZRI58qQHzdH6FY
m00NHIFIJqgMYM/pLx27/2rSTpY4JS+muinC6ViZ2DQcVCZUsPdVnRyu5wnvtxH1I1hxUgLnaQ/5
+VUR28xCCr8Hqh1elDmSQhNwfF9DGXNtj5DwgKAhEgNkkAU5UVihQMZFB9uvokHq0BBUWyHX34uc
UyDnIrXJcn+CNXc9QAjdv4js1Ke0kkEdJJQx7uDd3avLxZ52GY0ER1FEEMlNvhiZIiIECUSX9kf9
S+U9wJQJSSpwN93X1PeHChcqKGyTnz9J66sVNavjMlgOu6yVqKWH+mOLUqimWWP9kFRoQj9d7v9W
fMourldaShJdpiYJUE2ZmxYsu2+TA2yeO3AaCQp0eERAgStIIBJAoiGIIbbdk8O2+XVfsdOHbn2v
tqhH/POyPhD1YCgKV+mDSFwUAFN3VO6YAp4G/8giwYdgIOv1/PAkhCfXS9KNvyr19fBP/c+y/txK
RHFeEJeGMZhAG08QljG6tlh1YYiGPDI+1+04+39PnmmS/ksEMzG/5ZUQM+v4MBj2FNsPp7Hy+00U
YJID0r6efu+3vWPxauRFVOvSmjc2ymW3JEMbI9PeGcpJCFePttNawfvYkhC9Pm1TTJkaYfPyBEsC
S9pQxAG6QrQIEkQYyMOc//P6oNKiSEKCjupxaWD3ppN5gc3oFqZR+xfVxSuQYTIyAD5tJ0bVre1i
hQnlMWjpa8fe4nP77vH2B8/fjpfTU+7QNptDYjbdTVar7evZTn+HucLzmMBGKgBHuBSYTf9S3w7j
1Sj7ECBAMbOnTlAlsXZVPHCGuxAJ/+LuSKcKEgmqO6SA

--Boundary-00=_inNb/m9sHOS2PTb--

