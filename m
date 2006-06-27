Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932962AbWF0CM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932962AbWF0CM4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 22:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933285AbWF0CM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 22:12:56 -0400
Received: from pool-71-254-79-253.ronkva.east.verizon.net ([71.254.79.253]:58308
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932962AbWF0CMy (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 22:12:54 -0400
Message-Id: <200606270212.k5R2CIvh005395@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: tglx@linutronix.de
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: Your message of "Tue, 27 Jun 2006 01:27:09 +0200."
             <1151364429.25491.462.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <20060624061914.202fbfb5.akpm@osdl.org> <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
            <1151364429.25491.462.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1151374338_5283P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Jun 2006 22:12:18 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1151374338_5283P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Jun 2006 01:27:09 +0200, Thomas Gleixner said:
> On Mon, 2006-06-26 at 17:41 -0400, Valdis.Kletnieks=40vt.edu wrote:
> > On Sat, 24 Jun 2006 06:19:14 PDT, Andrew Morton said:
> > >=20
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1=
7/2.6.
17-mm2/
> >=20
> > I'm seeing a 2-minute or so hang at system startup, seems to be hrtim=
er
> > related. =20
>=20
> hrtimer is not really involved here.

OK, the fact that it was continually in kernel/hrtimer.c was a red herrin=
g? :)

(2.6.17-mm1 worked OK on this...)

> ktime_get_ts() has not been touched since it was merged in 2.6.16
>=20
> Can you provide the complete boot log up to this point please ? -
> Preferably over serial console.

Can't manage a serial console, you'll have to settle for the dmesg output=

once we get up and running:

=5B    0.000000=5D Linux version 2.6.17-mm2-test (valdis=40turing-police.=
cc.vt.edu) (gcc version 4.1.1 20060619 (Red Hat 4.1.1-5)) =231 PREEMPT Mo=
n Jun 26 20:20:32 EDT 2006
=5B    0.000000=5D BIOS-provided physical RAM map:
=5B    0.000000=5D  BIOS-e820: 0000000000000000 - 000000000009fc00 (usabl=
e)
=5B    0.000000=5D  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reser=
ved)
=5B    0.000000=5D  BIOS-e820: 0000000000100000 - 000000002ffe2800 (usabl=
e)
=5B    0.000000=5D  BIOS-e820: 000000002ffe2800 - 0000000030000000 (reser=
ved)
=5B    0.000000=5D  BIOS-e820: 00000000feda0000 - 00000000fee00000 (reser=
ved)
=5B    0.000000=5D  BIOS-e820: 00000000ffb80000 - 0000000100000000 (reser=
ved)
=5B    0.000000=5D 767MB LOWMEM available.
=5B    0.000000=5D On node 0 totalpages: 196578
=5B    0.000000=5D   DMA zone: 4096 pages, LIFO batch:0
=5B    0.000000=5D   Normal zone: 192482 pages, LIFO batch:31
=5B    0.000000=5D DMI 2.3 present.
=5B    0.000000=5D ACPI: RSDP (v000 DELL                                 =
 ) =40 0x000fde50
=5B    0.000000=5D ACPI: RSDT (v001 DELL    CPi R   0x27d40107 ASL  0x000=
00061) =40 0x000fde64
=5B    0.000000=5D ACPI: FADT (v001 DELL    CPi R   0x27d40107 ASL  0x000=
00061) =40 0x000fde90
=5B    0.000000=5D ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x010=
0000e) =40 0x00000000
=5B    0.000000=5D ACPI: PM-Timer IO Port: 0x808
=5B    0.000000=5D Allocating PCI resources starting at 40000000 (gap: 30=
000000:ceda0000)
=5B    0.000000=5D Detected 1595.395 MHz processor.
=5B   17.076049=5D Built 1 zonelists.  Total pages: 196578
=5B   17.076053=5D Kernel command line: console=3Dtty0 vga=3D794 single
=5B   17.076524=5D Local APIC disabled by BIOS -- you can enable it with =
=22lapic=22
=5B   17.076537=5D mapped APIC to ffffd000 (01603000)
=5B   17.076543=5D Enabling fast FPU save and restore... done.
=5B   17.076547=5D Enabling unmasked SIMD FPU exception support... done.
=5B   17.076553=5D Initializing CPU=230
=5B   17.076661=5D CPU 0 irqstacks, hard=3Dc04ec000 soft=3Dc04eb000
=5B   17.076666=5D PID hash table entries: 4096 (order: 12, 16384 bytes)
=5B   17.076790=5D Console: colour dummy device 80x25
=5B   17.077842=5D Dentry cache hash table entries: 131072 (order: 7, 524=
288 bytes)
=5B   17.079004=5D Inode-cache hash table entries: 65536 (order: 6, 26214=
4 bytes)
=5B   17.106571=5D Memory: 773400k/786312k available (2308k kernel code, =
12312k reserved, 989k data, 192k init, 0k highmem)
=5B   17.106585=5D Checking if this processor honours the WP bit even in =
supervisor mode... Ok.
=5B   17.166527=5D Calibrating delay using timer specific routine.. 3192.=
23 BogoMIPS (lpj=3D1596116)
=5B   17.166576=5D Security Framework v1.0.0 initialized
=5B   17.166585=5D SELinux:  Initializing.
=5B   17.166603=5D SELinux:  Starting in permissive mode
=5B   17.166615=5D selinux_register_security:  Registering secondary modu=
le capability
=5B   17.166623=5D Capability LSM initialized as secondary
=5B   17.166642=5D Mount-cache hash table entries: 512
=5B   17.166791=5D CPU: After generic identify, caps: 3febf9ff 00000000 0=
0000000 00000000 00000000 00000000 00000000
=5B   17.166805=5D CPU: After vendor identify, caps: 3febf9ff 00000000 00=
000000 00000000 00000000 00000000 00000000
=5B   17.166819=5D CPU: Trace cache: 12K uops, L1 D cache: 8K
=5B   17.166825=5D CPU: L2 cache: 512K
=5B   17.166830=5D CPU: After all inits, caps: 3febf9ff 00000000 00000000=
 00000080 00000000 00000000 00000000
=5B   17.166840=5D Intel machine check architecture supported.
=5B   17.166850=5D Intel machine check reporting enabled on CPU=230.
=5B   17.166857=5D CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
=5B   17.166865=5D CPU0: Thermal monitoring enabled
=5B   17.166885=5D CPU: Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz stepping=
 04
=5B   17.166899=5D Checking 'hlt' instruction... OK.
=5B   17.170623=5D SMP alternatives: switching to UP code
=5B   17.170630=5D Freeing SMP alternatives: 0k freed
=5B   17.170636=5D ACPI: Core revision 20060608
=5B   17.213523=5D ACPI: setting ELCR to 0200 (from 0800)
=5B   17.219183=5D checking if image is initramfs... it is
=5B   17.365993=5D Freeing initrd memory: 1031k freed
=5B   17.366492=5D NET: Registered protocol family 16
=5B   17.367056=5D ACPI: ACPI Dock Station Driver=20
=5B   17.367520=5D ACPI: bus type pci registered
=5B   17.381009=5D PCI: PCI BIOS revision 2.10 entry at 0xfbfee, last bus=
=3D2
=5B   17.381016=5D Setting up standard PCI resources
=5B   17.411263=5D ACPI: Interpreter enabled
=5B   17.411276=5D ACPI: Using PIC for interrupt routing
=5B   17.415489=5D ACPI: PCI Root Bridge =5BPCI0=5D (0000:00)
=5B   17.415503=5D PCI: Probing PCI hardware (bus 00)
=5B   17.415912=5D ACPI: Assume root bridge =5B=5C_SB_.PCI0=5D bus is 0
=5B   17.490877=5D PCI quirk: region 0800-087f claimed by ICH4 ACPI/GPIO/=
TCO
=5B   17.490889=5D PCI quirk: region 0880-08bf claimed by ICH4 GPIO
=5B   17.490990=5D PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
=5B   17.491566=5D Boot video device is 0000:01:00.0
=5B   17.492357=5D PCI: Transparent bridge - 0000:00:1e.0
=5B   17.493327=5D ACPI: PCI Interrupt Routing Table =5B=5C_SB_.PCI0._PRT=
=5D
=5B   17.643870=5D ACPI: PCI Interrupt Link =5BLNKA=5D (IRQs 9 10 *11)
=5B   17.645210=5D ACPI: PCI Interrupt Link =5BLNKB=5D (IRQs 5 7) *11
=5B   17.646534=5D ACPI: PCI Interrupt Link =5BLNKC=5D (IRQs 9 10 *11)
=5B   17.647875=5D ACPI: PCI Interrupt Link =5BLNKD=5D (IRQs 5 7 9 10 *11=
)
=5B   17.651329=5D ACPI: PCI Interrupt Routing Table =5B=5C_SB_.PCI0.AGP_=
._PRT=5D
=5B   17.652545=5D ACPI: PCI Interrupt Routing Table =5B=5C_SB_.PCI0.PCIE=
._PRT=5D
=5B   17.655595=5D ACPI: Power Resource =5BPADA=5D (on)
=5B   17.657068=5D Linux Plug and Play Support v0.97 (c) Adam Belay
=5B   17.657090=5D pnp: PnP ACPI init
=5B   17.883045=5D pnp: PnP ACPI: found 17 devices
=5B   17.883086=5D Intel 82802 RNG detected
=5B   17.883685=5D usbcore: registered new driver usbfs
=5B   17.883950=5D usbcore: registered new driver hub
=5B   17.884558=5D PCI: Using ACPI for IRQ routing
=5B   17.884568=5D PCI: If a device doesn't work, try =22pci=3Drouteirq=
=22.  If it helps, post a report
=5B   17.927252=5D pnp: 00:02: ioport range 0x4d0-0x4d1 has been reserved=

=5B   17.927264=5D pnp: 00:02: ioport range 0x800-0x805 could not be rese=
rved
=5B   17.927273=5D pnp: 00:02: ioport range 0x808-0x80f could not be rese=
rved
=5B   17.927286=5D pnp: 00:03: ioport range 0x806-0x807 has been reserved=

=5B   17.927295=5D pnp: 00:03: ioport range 0x810-0x85f could not be rese=
rved
=5B   17.927303=5D pnp: 00:03: ioport range 0x860-0x87f has been reserved=

=5B   17.927311=5D pnp: 00:03: ioport range 0x880-0x8bf has been reserved=

=5B   17.927319=5D pnp: 00:03: ioport range 0x8c0-0x8df has been reserved=

=5B   17.927326=5D pnp: 00:03: ioport range 0x8e0-0x8ff has been reserved=

=5B   17.927341=5D pnp: 00:04: ioport range 0xf000-0xf0fe has been reserv=
ed
=5B   17.927349=5D pnp: 00:04: ioport range 0xf100-0xf1fe has been reserv=
ed
=5B   17.927370=5D pnp: 00:04: ioport range 0xf200-0xf2fe has been reserv=
ed
=5B   17.927379=5D pnp: 00:04: ioport range 0xf400-0xf4fe has been reserv=
ed
=5B   17.927387=5D pnp: 00:04: ioport range 0xf500-0xf5fe has been reserv=
ed
=5B   17.927396=5D pnp: 00:04: ioport range 0xf600-0xf6fe has been reserv=
ed
=5B   17.927405=5D pnp: 00:04: ioport range 0xf800-0xf8fe has been reserv=
ed
=5B   17.927413=5D pnp: 00:04: ioport range 0xf900-0xf9fe has been reserv=
ed
=5B   17.927431=5D pnp: 00:09: ioport range 0x900-0x91f has been reserved=

=5B   17.927438=5D pnp: 00:09: ioport range 0x3f0-0x3f1 has been reserved=

=5B   17.927454=5D pnp: 00:0f: ioport range 0xbf40-0xbf5f has been reserv=
ed
=5B   17.929718=5D PCI: Bridge: 0000:00:01.0
=5B   17.929729=5D   IO window: c000-cfff
=5B   17.929740=5D   MEM window: fc000000-fdffffff
=5B   17.929750=5D   PREFETCH window: d8000000-e7ffffff
=5B   17.929792=5D PCI: Bus 3, cardbus bridge: 0000:02:01.0
=5B   17.929799=5D   IO window: 0000e000-0000e0ff
=5B   17.929808=5D   IO window: 0000e400-0000e4ff
=5B   17.929818=5D   PREFETCH window: 40000000-41ffffff
=5B   17.929829=5D   MEM window: f4000000-f5ffffff
=5B   17.929838=5D PCI: Bus 7, cardbus bridge: 0000:02:01.1
=5B   17.929844=5D   IO window: 0000e800-0000e8ff
=5B   17.929853=5D   IO window: 00001000-000010ff
=5B   17.929863=5D   PREFETCH window: 42000000-43ffffff
=5B   17.929873=5D   MEM window: f6000000-f7ffffff
=5B   17.929882=5D PCI: Bus 11, cardbus bridge: 0000:02:03.0
=5B   17.929888=5D   IO window: 00001400-000014ff
=5B   17.929897=5D   IO window: 00001800-000018ff
=5B   17.929907=5D   PREFETCH window: 44000000-45ffffff
=5B   17.929917=5D   MEM window: fa000000-fbffffff
=5B   17.929926=5D PCI: Bridge: 0000:00:1e.0
=5B   17.929934=5D   IO window: e000-ffff
=5B   17.929946=5D   MEM window: f4000000-fbffffff
=5B   17.929956=5D   PREFETCH window: 40000000-46ffffff
=5B   17.929991=5D PCI: Setting latency timer of device 0000:00:1e.0 to 6=
4
=5B   17.930019=5D PCI: Enabling device 0000:02:01.0 (0000 -> 0003)
=5B   17.930959=5D ACPI: PCI Interrupt Link =5BLNKD=5D enabled at IRQ 11
=5B   17.930967=5D PCI: setting IRQ 11 as level-triggered
=5B   17.930973=5D ACPI: PCI Interrupt 0000:02:01.0=5BA=5D -> Link =5BLNK=
D=5D -> GSI 11 (level, low) -> IRQ 11
=5B   17.931011=5D PCI: Enabling device 0000:02:01.1 (0000 -> 0003)
=5B   17.931020=5D ACPI: PCI Interrupt 0000:02:01.1=5BA=5D -> Link =5BLNK=
D=5D -> GSI 11 (level, low) -> IRQ 11
=5B   17.931055=5D ACPI: PCI Interrupt 0000:02:03.0=5BA=5D -> Link =5BLNK=
D=5D -> GSI 11 (level, low) -> IRQ 11
=5B   17.931103=5D NET: Registered protocol family 2
=5B   17.939416=5D IP route cache hash table entries: 32768 (order: 5, 13=
1072 bytes)
=5B   17.939725=5D TCP established hash table entries: 131072 (order: 7, =
524288 bytes)
=5B   17.940277=5D TCP bind hash table entries: 65536 (order: 6, 262144 b=
ytes)
=5B   17.940808=5D TCP: Hash tables configured (established 131072 bind 6=
5536)
=5B   17.940816=5D TCP reno registered
=5B   17.942193=5D Machine check exception polling timer started.
=5B   17.942330=5D speedstep: frequency transition measured seems out of =
range (0 nSec), falling back to a safe one of 500000 nSec.
=5B   17.954033=5D audit: initializing netlink socket (disabled)
=5B   17.954062=5D audit(1151368037.173:1): initialized
=5B   17.954290=5D VFS: Disk quotas dquot_6.5.1
=5B   17.954321=5D Dquot-cache hash table entries: 1024 (order 0, 4096 by=
tes)
=5B   17.954433=5D SELinux:  Registering netfilter hooks
=5B   17.960062=5D Initializing Cryptographic API
=5B   17.960073=5D io scheduler noop registered
=5B   17.960086=5D io scheduler anticipatory registered (default)
=5B   17.960096=5D io scheduler deadline registered
=5B   17.960113=5D io scheduler cfq registered
=5B   17.961187=5D vesafb: framebuffer at 0xe0000000, mapped to 0xf088000=
0, using 5120k, total 32768k
=5B   17.961199=5D vesafb: mode is 1280x1024x16, linelength=3D2560, pages=
=3D1
=5B   17.961206=5D vesafb: protected mode interface info at c000:e140
=5B   17.961213=5D vesafb: pmi: set display start =3D c00ce185, set palet=
te =3D c00ce20a
=5B   17.961218=5D vesafb: pmi: ports =3D b4c3 b503 ba03 c003 c103 c403 c=
503 c603 c703 c803 c903 cc03 ce03 cf03 d003 d103 d203 d303 d403 d503 da03=
 ff03=20
=5B   17.961246=5D vesafb: scrolling: redraw
=5B   17.961253=5D vesafb: Truecolor: size=3D0:5:6:5, shift=3D0:11:5:0
=5B   18.042761=5D Console: switching to colour frame buffer device 160x6=
4
=5B   18.118229=5D fb0: VESA VGA frame buffer device
=5B   18.119853=5D ACPI: Video Device =5BVID=5D (multi-head: yes  rom: no=
  post: no)
=5B   18.137796=5D Hangcheck: starting hangcheck timer 0.9.0 (tick is 180=
 seconds, margin is 60 seconds).
=5B   18.138627=5D Hangcheck: Using get_cycles().
=5B   18.139017=5D Serial: 8250/16550 driver =24Revision: 1.90 =24 4 port=
s, IRQ sharing enabled
=5B   18.140389=5D serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A=

=5B   18.143041=5D 00:0d: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
=5B   18.145096=5D ACPI: PCI Interrupt Link =5BLNKB=5D enabled at IRQ 5
=5B   18.145622=5D PCI: setting IRQ 5 as level-triggered
=5B   18.145628=5D ACPI: PCI Interrupt 0000:00:1f.6=5BB=5D -> Link =5BLNK=
B=5D -> GSI 5 (level, low) -> IRQ 5
=5B   18.150711=5D RAMDISK driver initialized: 16 RAM disks of 10240K siz=
e 1024 blocksize
=5B   18.153515=5D loop: loaded (max 8 devices)
=5B   18.155121=5D ACPI: PCI Interrupt Link =5BLNKC=5D enabled at IRQ 11
=5B   18.155653=5D ACPI: PCI Interrupt 0000:02:00.0=5BA=5D -> Link =5BLNK=
C=5D -> GSI 11 (level, low) -> IRQ 11
=5B   18.156511=5D 3c59x: Donald Becker and others. www.scyld.com/network=
/vortex.html
=5B   18.157184=5D 0000:02:00.0: 3Com PCI 3c905C Tornado at f0804c00.
=5B   18.180566=5D Uniform Multi-Platform E-IDE driver Revision: 7.00alph=
a2
=5B   18.181173=5D ide: Assuming 33MHz system bus speed for PIO modes; ov=
erride with idebus=3Dxx
=5B   18.181949=5D ICH3M: IDE controller at PCI slot 0000:00:1f.1
=5B   18.182459=5D PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
=5B   18.183917=5D ACPI: PCI Interrupt Link =5BLNKA=5D enabled at IRQ 11
=5B   18.184443=5D ACPI: PCI Interrupt 0000:00:1f.1=5BA=5D -> Link =5BLNK=
A=5D -> GSI 11 (level, low) -> IRQ 11
=5B   18.185291=5D ICH3M: chipset revision 2
=5B   18.185626=5D ICH3M: not 100% native mode: will probe irqs later
=5B   18.186180=5D     ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:=
DMA, hdb:DMA
=5B   18.186891=5D ICH3M: too many IDE interfaces, no room in table
=5B   18.187409=5D Probing IDE interface ide0...
=5B   18.450439=5D hda: FUJITSU MHV2060AH, ATA DISK drive
=5B   18.857812=5D hdb: TOSHIBA CD-RW/DVD-ROM SD-R2102, ATAPI CD/DVD-ROM =
drive
=5B   18.913058=5D ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
=5B   18.914653=5D hda: max request size: 128KiB
=5B   18.945264=5D hda: 117210240 sectors (60011 MB) w/8192KiB Cache, CHS=
=3D65535/16/63, UDMA(100)
=5B   18.950740=5D hda: cache flushes supported
=5B   18.951152=5D  hda: hda1 hda2
=5B   18.961383=5D hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UD=
MA(33)
=5B   18.962142=5D Uniform CD-ROM driver Revision: 3.20
=5B   18.995085=5D ohci_hcd: 2006 May 24 USB 1.1 'Open' Host Controller (=
OHCI) Driver (PCI)
=5B   18.995333=5D USB Universal Host Controller Interface driver v3.0
=5B   19.023273=5D ACPI: PCI Interrupt 0000:00:1d.0=5BA=5D -> Link =5BLNK=
A=5D -> GSI 11 (level, low) -> IRQ 11
=5B   19.051304=5D PCI: Setting latency timer of device 0000:00:1d.0 to 6=
4
=5B   19.051312=5D uhci_hcd 0000:00:1d.0: UHCI Host Controller
=5B   19.079265=5D uhci_hcd 0000:00:1d.0: new USB bus registered, assigne=
d bus number 1
=5B   19.106918=5D uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000bf80
=5B   19.134365=5D usb usb1: new device found, idVendor=3D0000, idProduct=
=3D0000
=5B   19.161938=5D usb usb1: new device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
=5B   19.189672=5D usb usb1: Product: UHCI Host Controller
=5B   19.217323=5D usb usb1: Manufacturer: Linux 2.6.17-mm2-test uhci_hcd=

=5B   19.244946=5D usb usb1: SerialNumber: 0000:00:1d.0
=5B   19.273170=5D usb usb1: configuration =231 chosen from 1 choice
=5B   19.301075=5D hub 1-0:1.0: USB hub found
=5B   19.329130=5D hub 1-0:1.0: 2 ports detected
=5B   19.457331=5D ACPI: PCI Interrupt 0000:00:1d.2=5BC=5D -> Link =5BLNK=
C=5D -> GSI 11 (level, low) -> IRQ 11
=5B   19.485837=5D PCI: Setting latency timer of device 0000:00:1d.2 to 6=
4
=5B   19.485845=5D uhci_hcd 0000:00:1d.2: UHCI Host Controller
=5B   19.514259=5D uhci_hcd 0000:00:1d.2: new USB bus registered, assigne=
d bus number 2
=5B   19.542782=5D uhci_hcd 0000:00:1d.2: irq 11, io base 0x0000bf20
=5B   19.570654=5D usb usb2: new device found, idVendor=3D0000, idProduct=
=3D0000
=5B   19.598622=5D usb usb2: new device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D1
=5B   19.626613=5D usb usb2: Product: UHCI Host Controller
=5B   19.654475=5D usb usb2: Manufacturer: Linux 2.6.17-mm2-test uhci_hcd=

=5B   19.682341=5D usb usb2: SerialNumber: 0000:00:1d.2
=5B   19.710556=5D usb usb2: configuration =231 chosen from 1 choice
=5B   19.738543=5D hub 2-0:1.0: USB hub found
=5B   19.766078=5D hub 2-0:1.0: 2 ports detected
=5B   20.099723=5D usb 2-1: new low speed USB device using uhci_hcd and a=
ddress 2
=5B   20.295519=5D usb 2-1: new device found, idVendor=3D045e, idProduct=
=3D0023
=5B   20.322578=5D usb 2-1: new device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
=5B   20.349770=5D usb 2-1: Product: Microsoft Trackball Optical=AE
=5B   20.376744=5D usb 2-1: Manufacturer: Microsoft
=5B   20.404665=5D usb 2-1: configuration =231 chosen from 1 choice
=5B   20.448492=5D input: Microsoft Microsoft Trackball Optical=AE as /cl=
ass/input/input0
=5B   20.475250=5D input: USB HID v1.00 Mouse =5BMicrosoft Microsoft Trac=
kball Optical=AE=5D on usb-0000:00:1d.2-1
=5B   20.502548=5D usbcore: registered new driver usbhid
=5B   20.529495=5D drivers/usb/input/hid-core.c: v2.6:USB HID core driver=

=5B   20.557090=5D PNP: PS/2 Controller =5BPNP0303:KBC,PNP0f13:PS2M=5D at=
 0x60,0x64 irq 1,12
=5B   20.588872=5D serio: i8042 AUX port at 0x60,0x64 irq 12
=5B   20.616419=5D serio: i8042 KBD port at 0x60,0x64 irq 1
=5B   20.643830=5D mice: PS/2 mouse device common for all mice
=5B   20.671744=5D input: PC Speaker as /class/input/input1
=5B   20.703182=5D input: AT Translated Set 2 keyboard as /class/input/in=
put2
=5B   20.729296=5D i2c /dev entries driver
=5B   20.756733=5D device-mapper: ioctl: 4.8.0-ioctl (2006-06-24) initial=
ised: dm-devel=40redhat.com
=5B   20.783167=5D EDAC MC: Ver: 2.0.0 Jun 26 2006
=5B   20.809776=5D Advanced Linux Sound Architecture Driver Version 1.0.1=
2rc1 (Thu Jun 22 13:55:50 2006 UTC).
=5B   20.838718=5D ACPI: PCI Interrupt 0000:00:1f.5=5BB=5D -> Link =5BLNK=
B=5D -> GSI 5 (level, low) -> IRQ 5
=5B   20.866066=5D PCI: Setting latency timer of device 0000:00:1f.5 to 6=
4
=5B   21.394886=5D input: DualPoint Stick as /class/input/input3
=5B   21.440329=5D input: AlpsPS/2 ALPS DualPoint TouchPad as /class/inpu=
t/input4
=5B   21.477604=5D intel8x0_measure_ac97_clock: measured 50992 usecs
=5B   21.504570=5D intel8x0: measured clock 96446 rejected
=5B   21.531559=5D intel8x0: clocking to 48000
=5B   21.561232=5D ALSA device list:
=5B   21.587477=5D   =230: Intel 82801CA-ICH3 with CS4205 at 0xd800, irq =
5
=5B   21.614454=5D TCP bic registered
=5B   21.640610=5D Initializing IPsec netlink socket
=5B   21.666716=5D NET: Registered protocol family 1
=5B   21.692833=5D NET: Registered protocol family 10
=5B   21.718628=5D lo: Disabled Privacy Extensions
=5B   21.744152=5D IPv6 over IPv4 tunneling driver
=5B   21.769925=5D NET: Registered protocol family 17
=5B   21.794964=5D NET: Registered protocol family 15
=5B   21.819751=5D Using IPI Shortcut mode
=5B   21.844980=5D Freeing unused kernel memory: 192k freed
=5B   21.869356=5D Time: tsc clocksource has been installed.
=5B   21.893677=5D Write protecting the kernel read-only data: 406k
=5B   23.024849=5D kjournald starting.  Commit interval 5 seconds
=5B   23.047661=5D EXT3-fs: mounted filesystem with ordered data mode.
=5B   23.744042=5D security:  6 users, 5 roles, 1965 types, 81 bools, 1 s=
ens, 256 cats
=5B   23.766353=5D security:  58 classes, 123884 rules
=5B   23.790135=5D SELinux:  Completing initialization.
=5B   23.811527=5D SELinux:  Setting up existing superblocks.
=5B   23.887619=5D SELinux: initialized (dev dm-0, type ext3), uses xattr=

=5B   24.028866=5D SELinux: initialized (dev tmpfs, type tmpfs), uses tra=
nsition SIDs
=5B   24.050014=5D SELinux: initialized (dev usbfs, type usbfs), uses gen=
fs_contexts
=5B   24.071108=5D SELinux: initialized (dev selinuxfs, type selinuxfs), =
uses genfs_contexts
=5B   24.092316=5D SELinux: initialized (dev mqueue, type mqueue), uses t=
ransition SIDs
=5B   24.113511=5D SELinux: initialized (dev devpts, type devpts), uses t=
ransition SIDs
=5B   24.134412=5D SELinux: initialized (dev eventpollfs, type eventpollf=
s), uses genfs_contexts
=5B   24.155337=5D SELinux: initialized (dev inotifyfs, type inotifyfs), =
uses genfs_contexts
=5B   24.176033=5D SELinux: initialized (dev tmpfs, type tmpfs), uses tra=
nsition SIDs
=5B   24.196440=5D SELinux: initialized (dev debugfs, type debugfs), uses=
 genfs_contexts
=5B   24.216556=5D SELinux: initialized (dev futexfs, type futexfs), uses=
 genfs_contexts
=5B   24.236170=5D SELinux: initialized (dev pipefs, type pipefs), uses t=
ask SIDs
=5B   24.255380=5D SELinux: initialized (dev sockfs, type sockfs), uses t=
ask SIDs
=5B   24.274225=5D SELinux: initialized (dev proc, type proc), uses genfs=
_contexts
=5B   24.292902=5D SELinux: initialized (dev bdev, type bdev), uses genfs=
_contexts
=5B   24.311432=5D SELinux: initialized (dev rootfs, type rootfs), uses g=
enfs_contexts
=5B   24.330082=5D SELinux: initialized (dev sysfs, type sysfs), uses gen=
fs_contexts
=5B   24.351494=5D audit(1151368041.674:2): policy loaded auid=3D42949672=
95
=5B   24.370664=5D audit(1151368041.666:3): avc:  granted  =7B load_polic=
y =7D for  pid=3D1 comm=3D=22init=22 scontext=3Dsystem_u:system_r:kernel_=
t:s0 tcontext=3Dsystem_u:object_r:security_t:s0 tclass=3Dsecurity
=5B   47.325645=5D SysRq : Show Regs
=5B   47.346690=5D=20
=5B   47.367719=5D Pid: 4, comm:              khelper
=5B   47.390642=5D EIP: 0060:=5B<c0119ee8>=5D CPU: 0
=5B   47.412044=5D EIP is at getnstimeofday+0x9e/0xb8
=5B   47.433443=5D  EFLAGS: 00000283    Not tainted  (2.6.17-mm2-test =23=
1)
=5B   47.455170=5D EAX: efd562dc EBX: efd562dc ECX: 00000000 EDX: 07e3c40=
8
=5B   47.477049=5D ESI: 49972cca EDI: aebbd096 EBP: effd0e5c DS: 007b ES:=
 007b
=5B   47.499328=5D CR0: 8005003b CR2: 08069000 CR3: 2ffb8000 CR4: 000006d=
0
=5B   47.521783=5D  <c0125bac> ktime_get_ts+0x14/0x3f  <c0110f68> copy_pr=
ocess+0x395/0x1111
=5B   47.544819=5D  <c0111f20> do_fork+0x8d/0x16a  <c0100a27> kernel_thre=
ad+0x6c/0x74
=5B   47.567843=5D  <c01203d1> __call_usermodehelper+0x2b/0x44  <c0120922=
> run_workqueue+0x94/0xe9
=5B   47.591251=5D  <c0120e04> worker_thread+0xe1/0x115  <c0123252> kthre=
ad+0xb0/0xdc
=5B   47.614703=5D  <c01006c5> kernel_thread_helper+0x5/0xb=20
=5B   50.090792=5D SysRq : Show Regs
=5B   50.114039=5D=20
=5B   50.137151=5D Pid: 4, comm:              khelper
=5B   50.162186=5D EIP: 0060:=5B<c0119ee8>=5D CPU: 0
=5B   50.185615=5D EIP is at getnstimeofday+0x9e/0xb8
=5B   50.209150=5D  EFLAGS: 00000283    Not tainted  (2.6.17-mm2-test =23=
1)
=5B   50.233053=5D EAX: efd562dc EBX: efd562dc ECX: 00000000 EDX: 07e3c40=
8
=5B   50.257138=5D ESI: 5e71e8ca EDI: a36f8e9d EBP: effd0e5c DS: 007b ES:=
 007b
=5B   50.281259=5D CR0: 8005003b CR2: 08069000 CR3: 2ffb8000 CR4: 000006d=
0
=5B   50.305453=5D  <c0125bac> ktime_get_ts+0x14/0x3f  <c0110f68> copy_pr=
ocess+0x395/0x1111
=5B   50.330131=5D  <c0111f20> do_fork+0x8d/0x16a  <c0100a27> kernel_thre=
ad+0x6c/0x74
=5B   50.354773=5D  <c01203d1> __call_usermodehelper+0x2b/0x44  <c0120922=
> run_workqueue+0x94/0xe9
=5B   50.379825=5D  <c0120e04> worker_thread+0xe1/0x115  <c0123252> kthre=
ad+0xb0/0xdc
=5B   50.405258=5D  <c01006c5> kernel_thread_helper+0x5/0xb=20
=5B   55.545338=5D SysRq : Show Regs
=5B   55.569994=5D=20
=5B   55.594154=5D Pid: 1, comm:                 init
=5B   55.618624=5D EIP: 0060:=5B<c0119f93>=5D CPU: 0
=5B   55.643037=5D EIP is at do_gettimeofday+0x91/0xc5
=5B   55.667460=5D  EFLAGS: 00000286    Not tainted  (2.6.17-mm2-test =23=
1)
=5B   55.692237=5D EAX: e22faad7 EBX: 8ef8e1d2 ECX: db50bbaa EDX: 62dc8f7=
e
=5B   55.717439=5D ESI: ffffffff EDI: 00000000 EBP: c16d7fa4 DS: 007b ES:=
 007b
=5B   55.743054=5D CR0: 8005003b CR2: 08069000 CR3: 2ffb8000 CR4: 000006d=
0
=5B   55.768593=5D  <c0116992> sys_time+0xe/0x2f  <c0102261> sysenter_pas=
t_esp+0x56/0x79
=5B   58.448886=5D SysRq : Show Regs
=5B   58.474391=5D=20
=5B   58.499617=5D Pid: 4, comm:              khelper
=5B   58.526676=5D EIP: 0060:=5B<c0119ee8>=5D CPU: 0
=5B   58.551892=5D EIP is at getnstimeofday+0x9e/0xb8
=5B   58.577215=5D  EFLAGS: 00000207    Not tainted  (2.6.17-mm2-test =23=
1)
=5B   58.602764=5D EAX: efd562dc EBX: efd562dc ECX: 00000000 EDX: 07e3c40=
8
=5B   58.628351=5D ESI: 5216c0ca EDI: 7fd02419 EBP: effd0e5c DS: 007b ES:=
 007b
=5B   58.654222=5D CR0: 8005003b CR2: 08069000 CR3: 2ffb8000 CR4: 000006d=
0
=5B   58.680144=5D  <c0125bac> ktime_get_ts+0x14/0x3f  <c0110f68> copy_pr=
ocess+0x395/0x1111
=5B   58.706517=5D  <c0111f20> do_fork+0x8d/0x16a  <c0100a27> kernel_thre=
ad+0x6c/0x74
=5B   58.732893=5D  <c01203d1> __call_usermodehelper+0x2b/0x44  <c0120922=
> run_workqueue+0x94/0xe9
=5B   58.759698=5D  <c0120e04> worker_thread+0xe1/0x115  <c0123252> kthre=
ad+0xb0/0xdc
=5B   58.786851=5D  <c01006c5> kernel_thread_helper+0x5/0xb=20
=5B   64.039899=5D SysRq : Show Regs
=5B   64.066806=5D=20
=5B   64.093395=5D Pid: 4, comm:              khelper
=5B   64.122191=5D EIP: 0060:=5B<c0119ee8>=5D CPU: 0
=5B   64.149014=5D EIP is at getnstimeofday+0x9e/0xb8
=5B   64.175793=5D  EFLAGS: 00000283    Not tainted  (2.6.17-mm2-test =23=
1)
=5B   64.202650=5D EAX: efd562dc EBX: efd562dc ECX: 00000000 EDX: 07e3c40=
8
=5B   64.229018=5D ESI: f0575aca EDI: 67ff297e EBP: effd0e5c DS: 007b ES:=
 007b
=5B   64.254673=5D CR0: 8005003b CR2: 08069000 CR3: 2ffb8000 CR4: 000006d=
0
=5B   64.280580=5D  <c0125bac> ktime_get_ts+0x14/0x3f  <c0110f68> copy_pr=
ocess+0x395/0x1111
=5B   64.307101=5D  <c0111f20> do_fork+0x8d/0x16a  <c0100a27> kernel_thre=
ad+0x6c/0x74
=5B   64.333709=5D  <c01203d1> __call_usermodehelper+0x2b/0x44  <c0120922=
> run_workqueue+0x94/0xe9
=5B   64.360724=5D  <c0120e04> worker_thread+0xe1/0x115  <c0123252> kthre=
ad+0xb0/0xdc
=5B   64.388065=5D  <c01006c5> kernel_thread_helper+0x5/0xb=20
=5B   67.461531=5D SysRq : Show Regs
=5B   67.488572=5D=20
=5B   67.515345=5D Pid: 4, comm:              khelper
=5B   67.543903=5D EIP: 0060:=5B<c0119ee8>=5D CPU: 0
=5B   67.570469=5D EIP is at getnstimeofday+0x9e/0xb8
=5B   67.596952=5D  EFLAGS: 00000207    Not tainted  (2.6.17-mm2-test =23=
1)
=5B   67.623641=5D EAX: efd562dc EBX: efd562dc ECX: 00000000 EDX: 07e3c40=
8
=5B   67.650193=5D ESI: e3ae9cca EDI: 59fc3768 EBP: effd0e5c DS: 007b ES:=
 007b
=5B   67.676652=5D CR0: 8005003b CR2: 08069000 CR3: 2ffb8000 CR4: 000006d=
0
=5B   67.702990=5D  <c0125bac> ktime_get_ts+0x14/0x3f  <c0110f68> copy_pr=
ocess+0x395/0x1111
=5B   67.729631=5D  <c0111f20> do_fork+0x8d/0x16a  <c0100a27> kernel_thre=
ad+0x6c/0x74
=5B   67.756234=5D  <c01203d1> __call_usermodehelper+0x2b/0x44  <c0120922=
> run_workqueue+0x94/0xe9
=5B   67.783266=5D  <c0120e04> worker_thread+0xe1/0x115  <c0123252> kthre=
ad+0xb0/0xdc
=5B   67.810608=5D  <c01006c5> kernel_thread_helper+0x5/0xb=20
=5B   71.047876=5D SysRq : Show Regs
=5B   71.074931=5D=20
=5B   71.101725=5D Pid: 4, comm:              khelper
=5B   71.130292=5D EIP: 0060:=5B<c0119ee8>=5D CPU: 0
=5B   71.156873=5D EIP is at getnstimeofday+0x9e/0xb8
=5B   71.183369=5D  EFLAGS: 00000207    Not tainted  (2.6.17-mm2-test =23=
1)
=5B   71.210065=5D EAX: efd562dc EBX: efd562dc ECX: 00000000 EDX: 07e3c40=
8
=5B   71.236614=5D ESI: ee5cdaca EDI: 4b118ebe EBP: effd0e5c DS: 007b ES:=
 007b
=5B   71.263068=5D CR0: 8005003b CR2: 08069000 CR3: 2ffb8000 CR4: 000006d=
0
=5B   71.289404=5D  <c0125bac> ktime_get_ts+0x14/0x3f  <c0110f68> copy_pr=
ocess+0x395/0x1111
=5B   71.316037=5D  <c0111f20> do_fork+0x8d/0x16a  <c0100a27> kernel_thre=
ad+0x6c/0x74
=5B   71.342641=5D  <c01203d1> __call_usermodehelper+0x2b/0x44  <c0120922=
> run_workqueue+0x94/0xe9
=5B   71.369699=5D  <c0120e04> worker_thread+0xe1/0x115  <c0123252> kthre=
ad+0xb0/0xdc
=5B   71.397075=5D  <c01006c5> kernel_thread_helper+0x5/0xb=20
=5B   73.446308=5D SysRq : Show Regs
=5B   73.473414=5D=20
=5B   73.500205=5D Pid: 1, comm:                 init
=5B   73.526997=5D EIP: 0060:=5B<c0119f93>=5D CPU: 0
=5B   73.553564=5D EIP is at do_gettimeofday+0x91/0xc5
=5B   73.580059=5D  EFLAGS: 00000286    Not tainted  (2.6.17-mm2-test =23=
1)
=5B   73.606786=5D EAX: 274c0afb EBX: 8ef8e1d2 ECX: cb3967e7 EDX: dd58277=
e
=5B   73.633399=5D ESI: ffffffff EDI: 00000000 EBP: c16d7fa4 DS: 007b ES:=
 007b
=5B   73.659894=5D CR0: 8005003b CR2: 08069000 CR3: 2ffb8000 CR4: 000006d=
0
=5B   73.686698=5D  <c0116992> sys_time+0xe/0x2f  <c0102261> sysenter_pas=
t_esp+0x56/0x79
=5B   76.464785=5D SysRq : Show Regs
=5B   76.491801=5D=20
=5B   76.518628=5D Pid: 4, comm:              khelper
=5B   76.547291=5D EIP: 0060:=5B<c0119ee8>=5D CPU: 0
=5B   76.573824=5D EIP is at getnstimeofday+0x9e/0xb8
=5B   76.600283=5D  EFLAGS: 00000287    Not tainted  (2.6.17-mm2-test =23=
1)
=5B   76.626966=5D EAX: efd562dc EBX: efd562dc ECX: 00000000 EDX: 07e3c40=
8
=5B   76.653500=5D ESI: 447068ca EDI: 3531262b EBP: effd0e5c DS: 007b ES:=
 007b
=5B   76.679940=5D CR0: 8005003b CR2: 08069000 CR3: 2ffb8000 CR4: 000006d=
0
=5B   76.706240=5D  <c0125bac> ktime_get_ts+0x14/0x3f  <c0110f68> copy_pr=
ocess+0x395/0x1111
=5B   76.732842=5D  <c0111f20> do_fork+0x8d/0x16a  <c0100a27> kernel_thre=
ad+0x6c/0x74
=5B   76.759412=5D  <c01203d1> __call_usermodehelper+0x2b/0x44  <c0120922=
> run_workqueue+0x94/0xe9
=5B   76.786408=5D  <c0120e04> worker_thread+0xe1/0x115  <c0123252> kthre=
ad+0xb0/0xdc
=5B   76.813729=5D  <c01006c5> kernel_thread_helper+0x5/0xb=20
=5B   79.214850=5D SysRq : Show Regs
=5B   79.241901=5D=20
=5B   79.268685=5D Pid: 4, comm:              khelper
=5B   79.297242=5D EIP: 0060:=5B<c0119ee8>=5D CPU: 0
=5B   79.323800=5D EIP is at getnstimeofday+0x9e/0xb8
=5B   79.350280=5D  EFLAGS: 00000283    Not tainted  (2.6.17-mm2-test =23=
1)
=5B   79.376960=5D EAX: efd562dc EBX: efd562dc ECX: 00000000 EDX: 07e3c40=
8
=5B   79.403485=5D ESI: 585bd6ca EDI: 2a54f33c EBP: effd0e5c DS: 007b ES:=
 007b
=5B   79.429916=5D CR0: 8005003b CR2: 08069000 CR3: 2ffb8000 CR4: 000006d=
0
=5B   79.456234=5D  <c0125bac> ktime_get_ts+0x14/0x3f  <c0110f68> copy_pr=
ocess+0x395/0x1111
=5B   79.482858=5D  <c0111f20> do_fork+0x8d/0x16a  <c0100a27> kernel_thre=
ad+0x6c/0x74
=5B   79.509452=5D  <c01203d1> __call_usermodehelper+0x2b/0x44  <c0120922=
> run_workqueue+0x94/0xe9
=5B   79.536486=5D  <c0120e04> worker_thread+0xe1/0x115  <c0123252> kthre=
ad+0xb0/0xdc
=5B   79.563846=5D  <c01006c5> kernel_thread_helper+0x5/0xb=20
=5B   81.520148=5D SysRq : Show Regs
=5B   81.547171=5D=20
=5B   81.573927=5D Pid: 4, comm:              khelper
=5B   81.602450=5D EIP: 0060:=5B<c0119ee8>=5D CPU: 0
=5B   81.628985=5D EIP is at getnstimeofday+0x9e/0xb8
=5B   81.655440=5D  EFLAGS: 00000203    Not tainted  (2.6.17-mm2-test =23=
1)
=5B   81.682098=5D EAX: efd562dc EBX: efd562dc ECX: 00000000 EDX: 07e3c40=
8
=5B   81.708598=5D ESI: 8bd8a4ca EDI: 215de670 EBP: effd0e5c DS: 007b ES:=
 007b
=5B   81.734997=5D CR0: 8005003b CR2: 08069000 CR3: 2ffb8000 CR4: 000006d=
0
=5B   81.761260=5D  <c0125bac> ktime_get_ts+0x14/0x3f  <c0110f68> copy_pr=
ocess+0x395/0x1111
=5B   81.787828=5D  <c0111f20> do_fork+0x8d/0x16a  <c0100a27> kernel_thre=
ad+0x6c/0x74
=5B   81.814364=5D  <c01203d1> __call_usermodehelper+0x2b/0x44  <c0120922=
> run_workqueue+0x94/0xe9
=5B   81.841334=5D  <c0120e04> worker_thread+0xe1/0x115  <c0123252> kthre=
ad+0xb0/0xdc
=5B   81.868611=5D  <c01006c5> kernel_thread_helper+0x5/0xb=20
=5B   85.189743=5D SysRq : Show Regs
=5B   85.216706=5D=20
=5B   85.243406=5D Pid: 4, comm:              khelper
=5B   85.271856=5D EIP: 0060:=5B<c0119ee8>=5D CPU: 0
=5B   85.298313=5D EIP is at getnstimeofday+0x9e/0xb8
=5B   85.324694=5D  EFLAGS: 00000207    Not tainted  (2.6.17-mm2-test =23=
1)
=5B   85.351280=5D EAX: efd562dc EBX: efd562dc ECX: 00000000 EDX: 07e3c40=
8
=5B   85.377718=5D ESI: ede792ca EDI: 12898677 EBP: effd0e5c DS: 007b ES:=
 007b
=5B   85.404047=5D CR0: 8005003b CR2: 08069000 CR3: 2ffb8000 CR4: 000006d=
0
=5B   85.430268=5D  <c0125bac> ktime_get_ts+0x14/0x3f  <c0110f68> copy_pr=
ocess+0x395/0x1111
=5B   85.456795=5D  <c0111f20> do_fork+0x8d/0x16a  <c0100a27> kernel_thre=
ad+0x6c/0x74
=5B   85.483292=5D  <c01203d1> __call_usermodehelper+0x2b/0x44  <c0120922=
> run_workqueue+0x94/0xe9
=5B   85.510218=5D  <c0120e04> worker_thread+0xe1/0x115  <c0123252> kthre=
ad+0xb0/0xdc
=5B   85.537472=5D  <c01006c5> kernel_thread_helper+0x5/0xb=20
=5B   88.115373=5D SysRq : Show Regs
=5B   88.142335=5D=20
=5B   88.169013=5D Pid: 4, comm:              khelper
=5B   88.197456=5D EIP: 0060:=5B<c0119ee8>=5D CPU: 0
=5B   88.223929=5D EIP is at getnstimeofday+0x9e/0xb8
=5B   88.250315=5D  EFLAGS: 00000203    Not tainted  (2.6.17-mm2-test =23=
1)
=5B   88.276932=5D EAX: efd562dc EBX: efd562dc ECX: 00000000 EDX: 07e3c40=
8
=5B   88.303435=5D ESI: 809e10ca EDI: 06b30ece EBP: effd0e5c DS: 007b ES:=
 007b
=5B   88.329807=5D CR0: 8005003b CR2: 08069000 CR3: 2ffb8000 CR4: 000006d=
0
=5B   88.356469=5D  <c0125bac> ktime_get_ts+0x14/0x3f  <c0110f68> copy_pr=
ocess+0x395/0x1111
=5B   88.383810=5D  <c0111f20> do_fork+0x8d/0x16a  <c0100a27> kernel_thre=
ad+0x6c/0x74
=5B   88.411220=5D  <c01203d1> __call_usermodehelper+0x2b/0x44  <c0120922=
> run_workqueue+0x94/0xe9
=5B   88.439162=5D  <c0120e04> worker_thread+0xe1/0x115  <c0123252> kthre=
ad+0xb0/0xdc
=5B   88.467114=5D  <c01006c5> kernel_thread_helper+0x5/0xb=20
=5B   89.913214=5D Real Time Clock Driver v1.12ac
=5B   90.489593=5D audit(1151368108.794:4): avc:  denied  =7B dac_overrid=
e =7D for  pid=3D452 comm=3D=22dmesg=22 capability=3D1 scontext=3Dsystem_=
u:system_r:dmesg_t:s0 tcontext=3Dsystem_u:system_r:dmesg_t:s0 tclass=3Dca=
pability

And after that, things move along OK.


--==_Exmh_1151374338_5283P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEoJQCcC3lWbTT17ARAlm+AJ4xXU0A9kWYV2fVjOAQFw4L+gYolQCgvrEE
1r4QlTm8k5f8zWTbQIMF5hI=
=pEnZ
-----END PGP SIGNATURE-----

--==_Exmh_1151374338_5283P--
