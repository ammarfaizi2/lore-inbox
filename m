Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbUJXXlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbUJXXlN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 19:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbUJXXlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 19:41:13 -0400
Received: from CPE-203-51-28-190.nsw.bigpond.net.au ([203.51.28.190]:35057
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S261619AbUJXXkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 19:40:51 -0400
Message-ID: <417C3D7F.8070803@eyal.emu.id.au>
Date: Mon, 25 Oct 2004 09:40:47 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc1 - 'modprobe -r dvb-bt8xx' oops
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is reproducible. I was doing this on a fresh boot:
         modprobe -r mt352
         modprobe -r sp887x
         modprobe -r dvb-bt8xx
         modprobe -r bt878
         modprobe -r bttv
         modprobe -r dvb-core

Vanilla 2.6.9-rc1 on P4.

Linux video capture interface: v1.00
tuner: Ignoring new-style parameters in presence of obsolete ones
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:03:01.0[A] -> GSI 21 (level, low) -> IRQ 21
bttv0: Bt848 (rev 18) at 0000:03:01.0, irq: 21, latency: 32, mmio: 0xde000000
bttv0: using: STB, Gateway P/N 6000699 (bt848) [card=3,insmod option]
bttv0: gpio config override: mask=0x7, mux=0x1,0x0,0x2,0x3,0x4
bttv0: gpio: en=00000000, out=00000000 in=00f0c0fc [init]
tuner: chip found at addr 0xc0 i2c-bus bt848 #0 [sw]
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles)) by insmod option
tuner: The type=<n> insmod option will go away soon.
tuner: Please use the tuner=<n> option provided by
tuner: tv aard core driver (bttv, saa7134, ...) instead.
bttv0: using tuner=2
tuner: type already set to 5, ignoring request for 2
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL can sleep, using XTAL (35468950).
bttv: Bt8xx card found (1).
ACPI: PCI interrupt 0000:03:02.0[A] -> GSI 22 (level, low) -> IRQ 22
bttv1: Bt878 (rev 17) at 0000:03:02.0, irq: 22, latency: 32, mmio: 0xde001000
bttv1: detected: AVermedia DVB-T 771 [card=123], PCI subsystem ID is 1461:0771
bttv1: using: AVerMedia AVerTV DVB-T 771 [card=123,autodetected]
bttv1: gpio config override: mask=0x7, mux=0x1,0x0,0x2,0x3,0x4
bttv1: gpio: en=00000000, out=00000000 in=0090000f [init]
bttv1: using tuner=4
bttv1: registered device video1
bttv1: registered device vbi1
bttv1: PLL: 28636363 => 35468950 .. ok
bttv1: add subdevice "dvb1"
bttv: Bt8xx card found (2).
ACPI: PCI interrupt 0000:03:03.0[A] -> GSI 16 (level, low) -> IRQ 16
bttv2: Bt878 (rev 17) at 0000:03:03.0, irq: 16, latency: 32, mmio: 0xde003000
bttv2: detected: AverMedia AverTV DVB-T [card=124], PCI subsystem ID is 1461:076
1
bttv2: using: AverMedia AverTV DVB-T 761 [card=124,autodetected]
bttv2: gpio config override: mask=0x7, mux=0x1,0x0,0x2,0x3,0x4
bttv2: gpio: en=00000000, out=00000000 in=0098000d [init]
bttv2: using tuner=-1
bttv2: registered device video2
bttv2: registered device vbi2
bttv2: PLL: 28636363 => 35468950 .. ok
bttv2: add subdevice "remote2"
bttv2: add subdevice "dvb2"
bt878: AUDIO driver version 0.0.0 loaded
bt878: Bt878 AUDIO function found (0).
ACPI: PCI interrupt 0000:03:02.1[A] -> GSI 22 (level, low) -> IRQ 22
bt878(0): Bt878 (rev 17) at 03:02.1, irq: 22, latency: 32, memory: 0xde002000
bt878: Bt878 AUDIO function found (1).
ACPI: PCI interrupt 0000:03:03.1[A] -> GSI 16 (level, low) -> IRQ 16
bt878(1): Bt878 (rev 17) at 03:03.1, irq: 16, latency: 32, memory: 0xde004000
btaudio: driver version 0.7 loaded [digital+analog]
SCSI subsystem initialized
dc395x: Tekram DC395(U/UW/F), DC315(U) - ASIC TRM-S1040 v2.05, 2004/03/08
ACPI: PCI interrupt 0000:03:04.0[A] -> GSI 18 (level, low) -> IRQ 18
dc395x: Used settings: AdapterID=07, Speed=0(20.0MHz), dev_mode=0x57
dc395x:                AdaptMode=0x0f, Tags=4(16), DelayReset=1s
dc395x: Connectors: ext50  Termination: Auto Low High
dc395x: Performing initial SCSI bus reset
scsi0 : Tekram DC395(U/UW/F), DC315(U) - ASIC TRM-S1040 v2.05, 2004/03/08
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:03:05.0[A] -> GSI 21 (level, low) -> IRQ 21
ohci1394: fw-host0: Remapped memory spaces reg 0xf90ce000
ohci1394: fw-host0: Soft reset finished
ohci1394: fw-host0: Iso contexts reg: 000000a8 implemented: 0000000f
ohci1394: fw-host0: 4 iso receive contexts available
ohci1394: fw-host0: Iso contexts reg: 00000098 implemented: 000000ff
ohci1394: fw-host0: 8 iso transmit contexts available
ohci1394: fw-host0: Receive DMA ctx=0 initialized
ohci1394: fw-host0: Receive DMA ctx=0 initialized
ohci1394: fw-host0: Transmit DMA ctx=0 initialized
ohci1394: fw-host0: Transmit DMA ctx=1 initialized
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[21]  MMIO=[dd004000-dd0047ff]  Max Packet=[2048]
ieee1394: CSR: setting expire to 98, HZ=1000
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
ohci1394: fw-host0: IntEvent: 00020010
ohci1394: fw-host0: irq_handler: Bus reset requested
ohci1394: fw-host0: Cancel request received
ohci1394: fw-host0: Got RQPkt interrupt status=0x00008409
ohci1394: fw-host0: Single packet rcv'd
ohci1394: fw-host0: Got phy packet ctx=0 ... discarded
ohci1394: fw-host0: IntEvent: 00010000
ohci1394: fw-host0: SelfID interrupt received (phyid 0, root)
ohci1394: fw-host0: SelfID packet 0x807f8c56 received
ieee1394: Including SelfID 0x568c7f80
ohci1394: fw-host0: SelfID for this node is 0x807f8c56
ohci1394: fw-host0: SelfID complete
ohci1394: fw-host0: PhyReqFilter=ffffffffffffffff
ieee1394: selfid_complete called with successful SelfID stage ... irm_id: 0xFFC0
  node_id: 0xFFC0
ieee1394: NodeMgr: Processing host reset for knodemgrd_0
ieee1394: send packet local: ffc00140 ffc0ffff f0000400
ieee1394: received packet: ffc00140 ffc0ffff f0000400
ieee1394: send packet local: ffc00160 ffc00000 00000000 31990404
ieee1394: received packet: ffc00160 ffc00000 00000000 31990404
ieee1394: send packet local: ffc00540 ffc0ffff f0000404
ieee1394: received packet: ffc00540 ffc0ffff f0000404
ieee1394: send packet local: ffc00560 ffc00000 00000000 34393331
ieee1394: received packet: ffc00560 ffc00000 00000000 34393331
ieee1394: send packet local: ffc00940 ffc0ffff f0000408
ieee1394: received packet: ffc00940 ffc0ffff f0000408
ieee1394: send packet local: ffc00960 ffc00000 00000000 32a264e0
ieee1394: received packet: ffc00960 ffc00000 00000000 32a264e0
ieee1394: send packet local: ffc00d40 ffc0ffff f000040c
ieee1394: received packet: ffc00d40 ffc0ffff f000040c
ieee1394: send packet local: ffc00d60 ffc00000 00000000 00610d00
ieee1394: received packet: ffc00d60 ffc00000 00000000 00610d00
ieee1394: send packet local: ffc01140 ffc0ffff f0000410
ieee1394: received packet: ffc01140 ffc0ffff f0000410
ieee1394: send packet local: ffc01160 ffc00000 00000000 ebd66900
ieee1394: received packet: ffc01160 ffc00000 00000000 ebd66900
ieee1394: send packet local: ffc01550 ffc0ffff f0000400 04000000
ieee1394: received packet: ffc01550 ffc0ffff f0000400 04000000
ieee1394: send packet local: ffc01570 ffc00000 00000000 04000000
ieee1394: received packet: ffc01570 ffc00000 00000000 04000000
ieee1394: NodeMgr: raw=0xe064a232 irmc=1 cmc=1 isc=1 bmc=0 pmc=0 cyc_clk_acc=100
  max_rec=2048 max_rom=1024 gen=3 lspd=2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000d61000069d6eb]
ieee1394: send packet 100: ffff0100 ffc0ffff f0000234 1f0000c0
ohci1394: fw-host0: Inserting packet for node 0-63:1023, tlabel=0, tcode=0x0, sp
eed=0
ohci1394: fw-host0: Starting transmit DMA ctx=0
ohci1394: fw-host0: IntEvent: 00000001
ohci1394: fw-host0: Got reqTxComplete interrupt status=0x00008011
ohci1394: fw-host0: Packet sent to node 63 tcode=0x0 tLabel=0x00 ack=0x11 spd=0
data=0x1F0000C0 ctx=0
eth1394: $Rev: 1224 $ Ben Collins <bcollins@debian.org>
divert: not allocating divert_blk for non-ethernet device eth1
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
ohci1394: fw-host0: ohci_iso_recv_init: packet-per-buffer mode, DMA buffer is 16
  pages (65536 bytes), using 16 blocks, buf_stride 4096, block_irq_interval 1
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as devic
e
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
   Vendor: ATAPI     Model: DVD RW 8XMax      Rev: 130D
   Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 5
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Intel 810 + AC97 Audio, version 1.01, 13:10:53 Oct 23 2004
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH5 found at IO 0xdc00 and 0xd800, MEM 0xde101000 and 0xde102000, I
RQ 17
i810: Intel ICH5 mmio at 0xf89be000 and 0xf9038000
i810_audio: Primary codec has ID 2
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 2
ac97_codec: AC97 Audio codec, id: ALG128 (Unknown)
i810_audio: AC'97 codec 2 Unable to map surround DAC's (or DAC's not present), t
otal channels = 2
DVB: registering new adapter (bttv1).
DVB: registering new adapter (bttv2).
xxx attach
sp887x: waiting for firmware upload...
i2c_adapter i2c-3: sendbytes: error - bailout.
sp887x_initial_setup: firmware upload... done.
DVB: registering frontend 1 (Microtune MT7202DTF)...
i2c_adapter i2c-1: sendbytes: error - bailout.
dvbfe_mt352: Setup for Avermedia 771.
xxx attach
DVB: registering frontend 0 (DVB-T Zarlink MT352 demodulator driver)...
i2c_adapter i2c-3: sendbytes: error - bailout.
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
ts: Compaq touchscreen protocol output
xxx detach
xxx detach
Unable to handle kernel NULL pointer dereference at virtual address 00000004
  printing eip:
f89743ea
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in: tsdev psmouse v4l1_compat dvb_bt8xx dvb_core i810_audio ac97_
codec sr_mod sg ide_scsi ide_cd cdrom it87 eeprom i2c_isa i2c_i801 eth1394 i2c_s
ensor ohci_hcd ohci1394 ieee1394 dc395x scsi_mod snd_bt87x bt878 bttv tuner vide
o_buf firmware_class i2c_algo_bit v4l2_common btcx_risc videodev e1000 snd_intel
8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd
_rawmidi snd_seq_device snd soundcore i2c_core cfi_cmdset_0002 cfi_util mtdpart
jedec_probe cfi_probe gen_probe ichxrom mtdcore chipreg map_funcs ehci_hcd uhci_
hcd usbcore shpchp pciehp pci_hotplug intel_mch_agp intel_agp agpgart parport_pc
  parport 8250_pnp 8250 serial_core evdev nls_cp437 msdos fat dm_mod rtc unix
CPU:    0
EIP:    0060:[<f89743ea>]    Not tainted VLI
EFLAGS: 00010282   (2.6.10-rc1)
EIP is at dvb_bt8xx_remove+0x89/0xc3 [dvb_bt8xx]
eax: 00000000   ebx: f7142c38   ecx: f9218df8   edx: 00000000
esi: f7142c00   edi: 00000000   ebp: f89744a0   esp: f77a8ef8
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 3948, threadinfo=f77a8000 task=f6c9ea20)
Stack: f7174100 f7142e8c f773ec80 f8975620 c0226a02 f773ec80 f773eca8 f773e890
        f8975670 c0226a24 f773ec80 f8975620 c031c0c4 c0226e46 f8975620 f8975620
        f8975620 c031c0c4 c022731c f8975620 f8975700 f909396c f8975620 f89744af
Call Trace:
  [<c0226a02>] device_release_driver+0x64/0x66
  [<c0226a24>] driver_detach+0x20/0x2e
  [<c0226e46>] bus_remove_driver+0x4d/0x8e
  [<c022731c>] driver_unregister+0x13/0x2a
  [<f909396c>] bttv_sub_unregister+0xf/0x15 [bttv]
  [<f89744af>] dvb_bt8xx_exit+0xf/0x13 [dvb_bt8xx]
  [<c0134be7>] sys_delete_module+0x157/0x18c
  [<c014d1e7>] sys_munmap+0x51/0x76
  [<c010508b>] syscall_call+0x7/0xb
Code: 24 04 ff 56 78 8d 86 34 02 00 00 89 04 24 e8 f8 32 89 00 89 1c 24 e8 32 50
  89 00 8b 46 2c 89 04 24 e8 27 13 89 00 8b 06 8b 56 04 <89> 50 04 89 02 c7 46 04
  00 02 20 00 c7 06 00 01 10 00 89 34 24

-- 
Eyal Lebedinsky	 (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
