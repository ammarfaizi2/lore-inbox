Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbULTHyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbULTHyV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 02:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbULTHxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 02:53:23 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:27282 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261476AbULTGvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 01:51:12 -0500
From: tabris <tabris@tabris.net>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at fs/inode.c:1116
Date: Mon, 20 Dec 2004 01:50:39 -0500
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart35612085.PWkHSbznLu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412200150.40052.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart35612085.PWkHSbznLu
Content-Type: multipart/mixed;
  boundary="Boundary-01=_/YnxBTONdIC4Y/l"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_/YnxBTONdIC4Y/l
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

	Attached are BUG output fro 2.6.10-rc2-mm4 (multiple BUG reports) and=20
one from 2.6.10-rc3-mm1, plus dmesg from 2.6.10-rc3-mm1.
=2D-=20
The problem with the gene pool is that there is no lifeguard.

--Boundary-01=_/YnxBTONdIC4Y/l
Content-Type: text/plain;
  charset="us-ascii";
  name="bug-2.6.10-rc2-mm4.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bug-2.6.10-rc2-mm4.1"

Dec 17 03:03:54 tabriel kernel: kernel BUG at fs/inode.c:1116!
Dec 17 03:03:54 tabriel kernel: invalid operand: 0000 [#1]
Dec 17 03:03:54 tabriel kernel: PREEMPT
Dec 17 03:03:54 tabriel kernel: Modules linked in: binfmt_misc nfsd exportfs nfs lockd sunrpc snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore agpgart sg sr_mod lp parport_pc parport w83781d i2c_sensor i2c_viapro i2c_dev i2c_core raw ide_cd cdrom floppy video thermal processor fan button battery ac 3c59x mii quota_v2 xfs ext2 mbcache rtc
Dec 17 03:03:54 tabriel kernel: CPU:    0
Dec 17 03:03:54 tabriel kernel: EIP:    0060:[<c016dfd5>]    Not tainted VLI
Dec 17 03:03:54 tabriel kernel: EFLAGS: 00010246   (2.6.10-rc2-mm4)
Dec 17 03:03:54 tabriel kernel: EIP is at iput+0x55/0x70
Dec 17 03:03:54 tabriel kernel: eax: c0310fe0   ebx: cb5a88d0   ecx: cb5a88e8   edx: cb5a88e8
Dec 17 03:03:54 tabriel kernel: esi: c7621ecc   edi: cb5a88d0   ebp: c939c000   esp: d640bf04
Dec 17 03:03:54 tabriel kernel: ds: 007b   es: 007b   ss: 0068
Dec 17 03:03:54 tabriel kernel: Process smbd (pid: 31975, threadinfo=d640a000 task=d9c36aa0)
Dec 17 03:03:54 tabriel kernel: Stack: d640a000 c016a8e7 d6d3664c 00000000 cf6d1000 c01643b2 c7621ecc 00000000
Dec 17 03:03:55 tabriel kernel:        c7621ecc dbc5b73c d6d3664c d6d3664c dffe0f80 c99df043 0000000f c939c00f
Dec 17 03:03:55 tabriel kernel:        00000010 00000000 00000000 0000003f 00000000 082be560 00000000 0829419f
Dec 17 03:03:55 tabriel kernel: Call Trace:
Dec 17 03:03:55 tabriel kernel:  [<c016a8e7>] dput+0x67/0x2a0
Dec 17 03:03:55 tabriel kernel:  [<c01643b2>] sys_rename+0x1c2/0x1e0
Dec 17 03:03:55 tabriel kernel:  [<c015d143>] sys_stat64+0x23/0x30
Dec 17 03:03:55 tabriel kernel:  [<c0102fd1>] sysenter_past_esp+0x52/0x71
Dec 17 03:03:55 tabriel kernel: Code: 3f c0 e8 3f e4 05 00 85 c0 74 1e 8b 83 94 00 00 00 ba 60 df 16 c0 8b 40 24 85 c0 74 08 8b 40 18 85 c0 0f 45 d0 89 d8 ff d2 5b c3 <0f> 0b 5c 04 d8 9a 2d c0 eb ba 90 89 d8 ff d2 eb be 8d 76 00 8d


--Boundary-01=_/YnxBTONdIC4Y/l
Content-Type: text/plain;
  charset="us-ascii";
  name="bug-2.6.10-rc3-mm1.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bug-2.6.10-rc3-mm1.1"

Dec 20 01:42:32 tabriel kernel: kernel BUG at fs/inode.c:1116!
Dec 20 01:42:32 tabriel kernel: invalid operand: 0000 [#1]
Dec 20 01:42:32 tabriel kernel: PREEMPT
Dec 20 01:42:32 tabriel kernel: Modules linked in: radeon drm agpgart binfmt_misc nfsd exportfs nfs lockd ipv6 sunrpc snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore sg sr_mod lp parport_pc parport w83781d i2c_sensor i2c_viapro i2c_dev i2c_core raw ide_cd cdrom floppy video thermal processor fan button battery ac 3c59x mii quota_v2 xfs ext2 mbcache rtc
Dec 20 01:42:32 tabriel kernel: CPU:    0
Dec 20 01:42:32 tabriel kernel: EIP:    0060:[<c016e455>]    Not tainted VLI
Dec 20 01:42:32 tabriel kernel: EFLAGS: 00010246   (2.6.10-rc3-mm1)
Dec 20 01:42:32 tabriel kernel: EIP is at iput+0x55/0x70
Dec 20 01:42:32 tabriel kernel: eax: c0311e60   ebx: d18a2500   ecx: 00000003   edx: c1565e68
Dec 20 01:42:32 tabriel kernel: esi: c1400b90   edi: c1565e60   ebp: d18a2500   esp: c1565e2c
Dec 20 01:42:32 tabriel kernel: ds: 007b   es: 007b   ss: 0068
Dec 20 01:42:32 tabriel kernel: Process pdflush (pid: 140, threadinfo=c1564000 task=dff08060)
Dec 20 01:42:33 tabriel kernel: Stack: c1564000 c017719f 00000002 d18a2614 c1565e98 d18a2614 00000003 00000000
Dec 20 01:42:33 tabriel kernel:        dff08060 c012cef0 c1565e74 c1565e74 00000003 d18a2614 00000003 00000000
Dec 20 01:42:33 tabriel kernel:        dff08060 c012cef0 c1565e74 c1565e74 deb46290 c1564000 d18a2500 c1565ec0
Dec 20 01:42:33 tabriel kernel: Call Trace:
Dec 20 01:42:33 tabriel kernel:  [<c017719f>] __writeback_single_inode+0x13f/0x170
Dec 20 01:42:33 tabriel kernel:  [<c012cef0>] wake_bit_function+0x0/0x60
Dec 20 01:42:33 tabriel kernel:  [<c012cef0>] wake_bit_function+0x0/0x60
Dec 20 01:42:33 tabriel kernel:  [<c0177841>] write_inode_now+0x71/0xc0
Dec 20 01:42:33 tabriel kernel:  [<c016e2cc>] generic_forget_inode+0x6c/0x180
Dec 20 01:42:33 tabriel kernel:  [<c016e453>] iput+0x53/0x70
Dec 20 01:42:33 tabriel kernel:  [<c01773e3>] generic_sync_sb_inodes+0x213/0x300
Dec 20 01:42:33 tabriel kernel:  [<c01775ac>] writeback_inodes+0xbc/0xf0
Dec 20 01:42:33 tabriel kernel:  [<c013ae6b>] background_writeout+0x7b/0xb0
Dec 20 01:42:33 tabriel kernel:  [<c013b8de>] __pdflush+0xce/0x1f0
Dec 20 01:42:33 tabriel kernel:  [<c01153ac>] set_user_nice+0xac/0xd0
Dec 20 01:42:33 tabriel kernel:  [<c013ba00>] pdflush+0x0/0x20
Dec 20 01:42:33 tabriel kernel:  [<c013ba1a>] pdflush+0x1a/0x20
Dec 20 01:42:33 tabriel kernel:  [<c013adf0>] background_writeout+0x0/0xb0
Dec 20 01:42:33 tabriel kernel:  [<c013ba00>] pdflush+0x0/0x20
Dec 20 01:42:33 tabriel kernel:  [<c012c965>] kthread+0x95/0xd0
Dec 20 01:42:33 tabriel kernel:  [<c012c8d0>] kthread+0x0/0xd0
Dec 20 01:42:33 tabriel kernel:  [<c01012dd>] kernel_thread_helper+0x5/0x18
Dec 20 01:42:33 tabriel kernel: Code: 3f c0 e8 ef e2 05 00 85 c0 74 1e 8b 83 94 00 00 00 ba e0 e3 16 c0 8b 40 24 85 c0 74 08 8b 40 18 85 c0 0f 45 d0 89 d8 ff d2 5b c3 <0f> 0b 5c 04 62 a5 2d c0 eb ba 90 89 d8 ff d2 eb be 8d 76 00 8d


--Boundary-01=_/YnxBTONdIC4Y/l
Content-Type: text/plain;
  charset="us-ascii";
  name="bug-2.6.10-rc2-mm4.3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bug-2.6.10-rc2-mm4.3"

Dec 17 20:30:37 tabriel kernel: kernel BUG at fs/inode.c:1116!
Dec 17 20:30:37 tabriel kernel: invalid operand: 0000 [#2]
Dec 17 20:30:37 tabriel kernel: PREEMPT
Dec 17 20:30:37 tabriel kernel: Modules linked in: binfmt_misc nfsd exportfs nfs lockd sunrpc snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore agpgart sg sr_mod lp parport_pc parport w83781d i2c_sensor i2c_viapro i2c_dev i2c_core raw ide_cd cdrom floppy video thermal processor fan button battery ac 3c59x mii quota_v2 xfs ext2 mbcache rtc
Dec 17 20:30:37 tabriel kernel: CPU:    0
Dec 17 20:30:37 tabriel kernel: EIP:    0060:[<c016dfd5>]    Not tainted VLI
Dec 17 20:30:37 tabriel kernel: EFLAGS: 00010246   (2.6.10-rc2-mm4)
Dec 17 20:30:37 tabriel kernel: EIP is at iput+0x55/0x70
Dec 17 20:30:37 tabriel kernel: eax: c0310fe0   ebx: da82b0b8   ecx: 00000003   edx: ca6b7e68
Dec 17 20:30:37 tabriel kernel: esi: c1400690   edi: ca6b7e60   ebp: da82b0b8   esp: ca6b7e2c
Dec 17 20:30:37 tabriel kernel: ds: 007b   es: 007b   ss: 0068
Dec 17 20:30:37 tabriel kernel: Process pdflush (pid: 12740, threadinfo=ca6b6000 task=d696a560)
Dec 17 20:30:37 tabriel kernel: Stack: ca6b6000 c0176d1f 00000002 da82b1cc ca6b7e98 da82b1cc 00000003 00000000
Dec 17 20:30:37 tabriel kernel:        d696a560 c012cee0 ca6b7e74 ca6b7e74 00000003 da82b1cc 00000003 00000000
Dec 17 20:30:37 tabriel kernel:        d696a560 c012cee0 ca6b7e74 ca6b7e74 d34565e0 ca6b6000 da82b0b8 ca6b7ec0
Dec 17 20:30:37 tabriel kernel: Call Trace:
Dec 17 20:30:37 tabriel kernel:  [<c0176d1f>] __writeback_single_inode+0x13f/0x170
Dec 17 20:30:37 tabriel kernel:  [<c012cee0>] wake_bit_function+0x0/0x60
Dec 17 20:30:37 tabriel kernel:  [<c012cee0>] wake_bit_function+0x0/0x60
Dec 17 20:30:37 tabriel kernel:  [<c01773c1>] write_inode_now+0x71/0xc0
Dec 17 20:30:37 tabriel kernel:  [<c0121bf0>] process_timeout+0x0/0x10
Dec 17 20:30:37 tabriel kernel:  [<c016de4c>] generic_forget_inode+0x6c/0x180
Dec 17 20:30:37 tabriel kernel:  [<c016dfd3>] iput+0x53/0x70
Dec 17 20:30:37 tabriel kernel:  [<c0176f63>] generic_sync_sb_inodes+0x213/0x300
Dec 17 20:30:37 tabriel kernel:  [<c017712c>] writeback_inodes+0xbc/0xf0
Dec 17 20:30:37 tabriel kernel:  [<c013ad3b>] background_writeout+0x7b/0xb0
Dec 17 20:30:37 tabriel kernel:  [<c013b7ae>] __pdflush+0xce/0x1f0
Dec 17 20:30:37 tabriel kernel:  [<c011538c>] set_user_nice+0xac/0xd0
Dec 17 20:30:37 tabriel kernel:  [<c013b8d0>] pdflush+0x0/0x20
Dec 17 20:30:37 tabriel kernel:  [<c013b8ea>] pdflush+0x1a/0x20
Dec 17 20:30:37 tabriel kernel:  [<c013acc0>] background_writeout+0x0/0xb0
Dec 17 20:30:37 tabriel kernel:  [<c013b8d0>] pdflush+0x0/0x20
Dec 17 20:30:37 tabriel kernel:  [<c012c955>] kthread+0x95/0xd0
Dec 17 20:30:37 tabriel kernel:  [<c012c8c0>] kthread+0x0/0xd0
Dec 17 20:30:37 tabriel kernel:  [<c01012ad>] kernel_thread_helper+0x5/0x18
Dec 17 20:30:37 tabriel kernel: Code: 3f c0 e8 3f e4 05 00 85 c0 74 1e 8b 83 94 00 00 00 ba 60 df 16 c0 8b 40 24 85 c0 74 08 8b 40 18 85 c0 0f 45 d0 89 d8 ff d2 5b c3 <0f> 0b 5c 04 d8 9a 2d c0 eb ba 90 89 d8 ff d2 eb be 8d 76 00 8d


--Boundary-01=_/YnxBTONdIC4Y/l
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg-2.6.10-rc3-mm1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg-2.6.10-rc3-mm1"

Linux version 2.6.10-rc3-mm1 (tabris@tabriel.tabris.net) (gcc version 3.4.1=
 (Mandrakelinux 10.1 3.4.1-4mdk)) #3 Sun Dec 19 06:19:00 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffec000 (usable)
 BIOS-e820: 000000001ffec000 - 000000001ffef000 (ACPI data)
 BIOS-e820: 000000001ffef000 - 000000001ffff000 (reserved)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131052
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126956 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6e20
ACPI: RSDT (v001 ASUS   A7V266-E 0x30303031 MSFT 0x31313031) @ 0x1ffec000
ACPI: FADT (v001 ASUS   A7V266-E 0x30303031 MSFT 0x31313031) @ 0x1ffec080
ACPI: BOOT (v001 ASUS   A7V266-E 0x30303031 MSFT 0x31313031) @ 0x1ffec040
ACPI: DSDT (v001   ASUS A7V266-E 0x00001000 MSFT 0x0100000b) @ 0x00000000
Built 1 zonelists
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01402000)
Initializing CPU#0
Kernel command line: root=3D/dev/hda3  vga=3D8
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1544.719 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 132x43
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515608k/524208k available (1827k kernel code, 8068k reserved, 949k =
data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 3039.23 BogoMIPS (lpj=3D1519616)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 0000=
0000 00000000
CPU: After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000 00000=
000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020 00000000 00=
000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(TM) XP1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0810)
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0ed0, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041203
    ACPI-0169: *** Error: No object was returned from [\_SB_.PCI0.PX40.UAR2=
=2E_STA] (Node c14d38e0), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disab=
led.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [._PRT]
ACPI: PCI Interrupt Routing Table [._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
    ACPI-0169: *** Error: No object was returned from [\_SB_.PCI0.PX40.UAR2=
=2E_STA] (Node c14d38e0), AE_NOT_EXIST
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=3Drouteirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
TC classifier action (bugs to netdev@oss.sgi.com cc hadi@cyberus.ca)
pnp: 00:02: ioport range 0xe400-0xe47f could not be reserved
pnp: 00:02: ioport range 0xe800-0xe80f has been reserved
pnp: 00:02: ioport range 0x290-0x291 has been reserved
pnp: 00:02: ioport range 0x370-0x373 has been reserved
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
    ACPI-0169: *** Error: No object was returned from [\_SB_.PCI0.PX40.UAR2=
=2E_STA] (Node c14d38e0), AE_NOT_EXIST
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PDC20265: IDE controller at PCI slot 0000:00:06.0
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 4 (level, low) -> IRQ 4
PDC20265: chipset revision 2
PDC20265: 100% native mode on irq 4
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:DMA, hdh:DMA
Probing IDE interface ide2...
hde: MAXTOR 4K060H3, ATA DISK drive
hdf: IC35L120AVV207-1, ATA DISK drive
elevator: using anticipatory as default io scheduler
ide2 at 0xb800-0xb807,0xb402 on irq 4
Probing IDE interface ide3...
hdg: Maxtor 4D060H3, ATA DISK drive
hdh: Maxtor 4D060H3, ATA DISK drive
ide3 at 0xb000-0xb007,0xa802 on irq 4
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:11.1[A] -> GSI 11 (level, low) -> IRQ 11
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x9008-0x900f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC AC28400R, ATA DISK drive
hdb: Maxtor 93652U8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Hewlett-Packard CD-Writer Plus 9100, ATAPI CD/DVD-ROM drive
hdd: SAMSUNG DVD-ROM SD-604, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hde: max request size: 128KiB
hde: 117266688 sectors (60040 MB) w/2000KiB Cache, CHS=3D65535/16/63, UDMA(=
100)
hde: cache flushes supported
 /dev/ide/host2/bus0/target0/lun0: p1 p2 < p5 >
hdf: max request size: 128KiB
hdf: 241254720 sectors (123522 MB) w/7965KiB Cache, CHS=3D16383/255/63, UDM=
A(100)
hdf: cache flushes supported
 /dev/ide/host2/bus0/target1/lun0: p1
hdg: max request size: 128KiB
hdg: 120069936 sectors (61475 MB) w/2048KiB Cache, CHS=3D16383/255/63, UDMA=
(100)
hdg: cache flushes not supported
 /dev/ide/host2/bus1/target0/lun0: p1 p2
hdh: max request size: 128KiB
hdh: 120069936 sectors (61475 MB) w/2048KiB Cache, CHS=3D65535/16/63, UDMA(=
100)
hdh: cache flushes not supported
 /dev/ide/host2/bus1/target1/lun0: p1
hda: max request size: 128KiB
hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=3D16383/16/63
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdb: max request size: 128KiB
hdb: 71346240 sectors (36529 MB) w/2048KiB Cache, CHS=3D65535/16/63, UDMA(6=
6)
hdb: cache flushes not supported
 /dev/ide/host0/bus0/target1/lun0: p1 p2 < p5 > p3
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:11.2[D] -> GSI 4 (level, low) -> IRQ 4
uhci_hcd 0000:00:11.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contro=
ller
uhci_hcd 0000:00:11.2: irq 4, io base 0x8800
uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:11.3[D] -> GSI 4 (level, low) -> IRQ 4
uhci_hcd 0000:00:11.3: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contro=
ller (#2)
uhci_hcd 0000:00:11.3: irq 4, io base 0x8400
uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:11.4[D] -> GSI 4 (level, low) -> IRQ 4
uhci_hcd 0000:00:11.4: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Contro=
ller (#3)
uhci_hcd 0000:00:11.4: irq 4, io base 0x8000
uhci_hcd 0000:00:11.4: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
usb 3-1: new low speed USB device using uhci_hcd and address 2
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices:=20
PCI0 PCI1 USB0 USB1 USB2=20
ACPI: (supports S0 S1 S4 S5)
ReiserFS: hda3: found reiserfs format "3.6" with standard journal
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:11.4-1
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:11.4-1
ReiserFS: hda3: using ordered data mode
ReiserFS: hda3: journal params: device hda3, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda3: checking transaction log (hda3)
ReiserFS: hda3: replayed 24 transactions in 12 seconds
ReiserFS: hda3: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
=46reeing unused kernel memory: 144k freed
Real Time Clock Driver v1.12
ReiserFS: hda3: Removing [15 25435 0x0 SD]..done
ReiserFS: hda3: Removing [15 25237 0x0 SD]..done
ReiserFS: hda3: There were 2 uncompleted unlinks/truncates. Completed
Adding 265064k swap on /dev/hda2.  Priority:-1 extents:1
Adding 999896k swap on /dev/hdb5.  Priority:-2 extents:1
ReiserFS: hdb3: found reiserfs format "3.6" with standard journal
ReiserFS: hdb3: using ordered data mode
ReiserFS: hdb3: journal params: device hdb3, size 8192, journal first block=
 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdb3: checking transaction log (hdb3)
ReiserFS: hdb3: replayed 5 transactions in 0 seconds
ReiserFS: hdb3: Using r5 hash to sort names
SGI XFS with ACLs, no debug enabled
SGI XFS Quota Management subsystem
XFS mounting filesystem hde1
Ending clean XFS mount for filesystem: hde1
XFS mounting filesystem hdh1
Ending clean XFS mount for filesystem: hdh1
XFS mounting filesystem hdg2
Ending clean XFS mount for filesystem: hdg2
XFS mounting filesystem hdf1
Starting XFS recovery on filesystem: hdf1 (dev: hdf1)
Ending XFS recovery on filesystem: hdf1 (dev: hdf1)
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0d.0: 3Com PCI 3c905C Tornado at 0xa000. Vers LK1.1.19

--Boundary-01=_/YnxBTONdIC4Y/l
Content-Type: text/plain;
  charset="us-ascii";
  name="bug-2.6.10-rc2-mm4.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bug-2.6.10-rc2-mm4.2"

Dec 17 20:13:37 tabriel kernel: kernel BUG at fs/inode.c:1116!
Dec 17 20:13:37 tabriel kernel: invalid operand: 0000 [#1]
Dec 17 20:13:37 tabriel kernel: PREEMPT
Dec 17 20:13:37 tabriel kernel: Modules linked in: binfmt_misc nfsd exportfs nfs lockd sunrpc snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore agpgart sg sr_mod lp parport_pc parport w83781d i2c_sensor i2c_viapro i2c_dev i2c_core raw ide_cd cdrom floppy video thermal processor fan button battery ac 3c59x mii quota_v2 xfs ext2 mbcache rtc
Dec 17 20:13:37 tabriel kernel: CPU:    0
Dec 17 20:13:37 tabriel kernel: EIP:    0060:[<c016dfd5>]    Not tainted VLI
Dec 17 20:13:37 tabriel kernel: EFLAGS: 00010246   (2.6.10-rc2-mm4)
Dec 17 20:13:37 tabriel kernel: EIP is at iput+0x55/0x70
Dec 17 20:13:37 tabriel kernel: eax: c0310fe0   ebx: c1c27290   ecx: 00000003   edx: c7001e68
Dec 17 20:13:37 tabriel kernel: esi: c13fffe0   edi: c7001e60   ebp: c1c27290   esp: c7001e2c
Dec 17 20:13:37 tabriel kernel: ds: 007b   es: 007b   ss: 0068
Dec 17 20:13:37 tabriel kernel: Process pdflush (pid: 13594, threadinfo=c7000000 task=cbf0b080)
Dec 17 20:13:37 tabriel kernel: Stack: c7000000 c0176d1f 00000002 c1c273a4 c7001e98 c1c273a4 00000003 00000000
Dec 17 20:13:37 tabriel kernel:        cbf0b080 c012cee0 c7001e74 c7001e74 00000003 c1c273a4 00000003 00000000
Dec 17 20:13:37 tabriel kernel:        cbf0b080 c012cee0 c7001e74 c7001e74 d6ae4930 c7000000 c1c27290 c7001ec0
Dec 17 20:13:37 tabriel kernel: Call Trace:
Dec 17 20:13:37 tabriel kernel:  [<c0176d1f>] __writeback_single_inode+0x13f/0x170
Dec 17 20:13:37 tabriel kernel:  [<c012cee0>] wake_bit_function+0x0/0x60
Dec 17 20:13:37 tabriel kernel:  [<c012cee0>] wake_bit_function+0x0/0x60
Dec 17 20:13:37 tabriel kernel:  [<c01773c1>] write_inode_now+0x71/0xc0
Dec 17 20:13:37 tabriel kernel:  [<c016de4c>] generic_forget_inode+0x6c/0x180
Dec 17 20:13:37 tabriel kernel:  [<c016dfd3>] iput+0x53/0x70
Dec 17 20:13:37 tabriel kernel:  [<c0176f63>] generic_sync_sb_inodes+0x213/0x300
Dec 17 20:13:37 tabriel kernel:  [<c017712c>] writeback_inodes+0xbc/0xf0
Dec 17 20:13:37 tabriel kernel:  [<c013ad3b>] background_writeout+0x7b/0xb0
Dec 17 20:13:37 tabriel kernel:  [<c013b7ae>] __pdflush+0xce/0x1f0
Dec 17 20:13:37 tabriel kernel:  [<c011538c>] set_user_nice+0xac/0xd0
Dec 17 20:13:37 tabriel kernel:  [<c013b8d0>] pdflush+0x0/0x20
Dec 17 20:13:37 tabriel kernel:  [<c013b8ea>] pdflush+0x1a/0x20
Dec 17 20:13:37 tabriel kernel:  [<c013acc0>] background_writeout+0x0/0xb0
Dec 17 20:13:37 tabriel kernel:  [<c013b8d0>] pdflush+0x0/0x20
Dec 17 20:13:37 tabriel kernel:  [<c012c955>] kthread+0x95/0xd0
Dec 17 20:13:37 tabriel kernel:  [<c012c8c0>] kthread+0x0/0xd0
Dec 17 20:13:37 tabriel kernel:  [<c01012ad>] kernel_thread_helper+0x5/0x18
Dec 17 20:13:37 tabriel kernel: Code: 3f c0 e8 3f e4 05 00 85 c0 74 1e 8b 83 94 00 00 00 ba 60 df 16 c0 8b 40 24 85 c0 74 08 8b 40 18 85 c0 0f 45 d0 89 d8 ff d2 5b c3 <0f> 0b 5c 04 d8 9a 2d c0 eb ba 90 89 d8 ff d2 eb be 8d 76 00 8d


--Boundary-01=_/YnxBTONdIC4Y/l--

--nextPart35612085.PWkHSbznLu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBxnZAgbFCivvqDfQRAqnFAJ9KFTFe0dtwMXtUiccVNdRAZY2SegCg1Qcw
O2qAlVHXLSNjFvzAjxKaWiY=
=3xTc
-----END PGP SIGNATURE-----

--nextPart35612085.PWkHSbznLu--
