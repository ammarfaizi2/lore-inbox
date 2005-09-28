Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVI1UCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVI1UCg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVI1UCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:02:36 -0400
Received: from talin.podgorze.pl ([195.225.250.33]:33506 "EHLO
	thinkpaddie.zlew.org") by vger.kernel.org with ESMTP
	id S1750817AbVI1UCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:02:35 -0400
From: Grzegorz Piotr Jaskiewicz <gj@kdemail.net>
Organization: KDE
To: linux-kernel@vger.kernel.org
Subject: oops on firewire pcmcia card removal
Date: Wed, 28 Sep 2005 22:02:05 +0200
User-Agent: KMail/1.8.91
X-Face: ?m}EMc-C]"l7<^`)a1NYO-('xy3:5V{82Z^-/D3^[MU8IHkf$o`~%CC5D4[GhaIgk/$oN7
	Y7;f}!(<IG>ooAGiKCVs$m~P1B-8Vt=]<V,FX{h4@fK/?Qtg]5ofD|P~&)q:6H>~1Nt2fh
	s-iKbN$.Ne^1(4tdwmmW>ew'=LPv+{{=YE=LoZU-5kfYnZSa`P7Q4pW]tKmUk`@&}M,dn-
	Kh{hA{~Ls4a$NjJI@1_f')]3|_}!GoJZss[Q$D-#l^.4GxPp[p:s<S~B&+6)
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509282202.09341@gj-laptop>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sometimes it's enough to just unplug the cable first, than eject pcmcia card. 
And sometimes not:
2.6.13.2

Sep 28 19:56:10 thinkpaddie kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Sep 28 19:56:10 thinkpaddie kernel:  printing eip:
Sep 28 19:56:10 thinkpaddie kernel: e1dc88ae
Sep 28 19:56:10 thinkpaddie kernel: *pde = 00000000
Sep 28 19:56:10 thinkpaddie kernel: Oops: 0000 [#1]
Sep 28 19:56:10 thinkpaddie kernel: Modules linked in: dv1394 raw1394 eth1394 
ohci1394 binfmt_misc rfcomm l2cap bluetooth ipv6 deflate zlib_deflate twofish 
serpent aes_i586 blowfish des sha256 crypto_null af_key joydev ide_cd cdrom 
8250_pnp snd_intel8x0m 8250_pci 8250 serial_core snd_intel8x0 snd_ac97_codec 
tpm_nsc tpm_atmel tpm uhci_hcd usbcore isofs zlib_inflate tun irtty_sir 
sir_dev irda radeon drm intel_agp evdev vmmon vmnet nvram snd_pcm_oss snd_pcm 
snd_timer snd_page_alloc snd_mixer_oss agpgart ieee1394 pcmcia firmware_class 
yenta_socket rsrc_nonstatic pcmcia_core rtc 3c59x mii nfs lockd nfs_acl 
sunrpc af_packet
Sep 28 19:56:10 thinkpaddie kernel: CPU:    0
Sep 28 19:56:10 thinkpaddie kernel: EIP:    0060:[pg0+563624110/1069257728]    
Tainted: P      VLI
Sep 28 19:56:10 thinkpaddie kernel: EFLAGS: 00010282   (2.6.13.1)
Sep 28 19:56:10 thinkpaddie kernel: EIP is at dv1394_remove_host+0x20/0xd8 
[dv1394]
Sep 28 19:56:10 thinkpaddie kernel: eax: e1ac2354   ebx: 00000000   ecx: 
e1dc4c34   edx: e1dcab40
Sep 28 19:56:10 thinkpaddie kernel: esi: 00000000   edi: e1dc90fd   ebp: 
df4b9e10   esp: df4b9df4
Sep 28 19:56:10 thinkpaddie kernel: ds: 007b   es: 007b   ss: 0068
Sep 28 19:56:10 thinkpaddie kernel: Process pccardd (pid: 2070, 
threadinfo=df4b8000 task=df406540)
Sep 28 19:56:10 thinkpaddie kernel: Stack: d586c000 e1dc4c2c df4b9e10 e1a8ac51 
e1dcab40 e1ac2388 d586c000 df4b9e34
Sep 28 19:56:10 thinkpaddie kernel:        e1a8ae3c d586c000 d586c000 df406540 
00000282 e1dcab40 e1ac2388 d586c000
Sep 28 19:56:10 thinkpaddie kernel:        df4b9e54 e1a8b7d4 e1dcab40 d586c000 
00000000 d586c000 e1c776ec d586ded8
Sep 28 19:56:10 thinkpaddie kernel: Call Trace:
Sep 28 19:56:10 thinkpaddie kernel:  [show_stack+159/213] show_stack+0x9f/0xd5
Sep 28 19:56:10 thinkpaddie kernel:  [show_registers+362/510] 
show_registers+0x16a/0x1fe
Sep 28 19:56:10 thinkpaddie kernel:  [die+209/330] die+0xd1/0x14a
Sep 28 19:56:10 thinkpaddie kernel:  [do_page_fault+601/1818] 
do_page_fault+0x259/0x71a
Sep 28 19:56:10 thinkpaddie kernel:  [error_code+79/84] error_code+0x4f/0x54
Sep 28 19:56:10 thinkpaddie kernel:  [pg0+560225852/1069257728] 
__unregister_host+0x1b/0xa9 [ieee1394]
Sep 28 19:56:10 thinkpaddie kernel:  [pg0+560228308/1069257728] 
highlevel_remove_host+0x3c/0x69 [ieee1394]
Sep 28 19:56:10 thinkpaddie kernel:  [pg0+560224650/1069257728] 
hpsb_remove_host+0x42/0x6c [ieee1394]
Sep 28 19:56:10 thinkpaddie kernel:  [pg0+562227819/1069257728] 
ohci1394_pci_remove+0x6f/0x266 [ohci1394]
Sep 28 19:56:10 thinkpaddie kernel:  [pci_device_remove+32/55] 
pci_device_remove+0x20/0x37
Sep 28 19:56:10 thinkpaddie kernel:  [__device_release_driver+90/116] 
__device_release_driver+0x5a/0x74
Sep 28 19:56:10 thinkpaddie kernel:  [device_release_driver+35/53] 
device_release_driver+0x23/0x35
Sep 28 19:56:10 thinkpaddie kernel:  [bus_remove_device+105/125] 
bus_remove_device+0x69/0x7d
Sep 28 19:56:10 thinkpaddie kernel:  [device_del+51/105] device_del+0x33/0x69
Sep 28 19:56:10 thinkpaddie kernel:  [device_unregister+18/32] 
device_unregister+0x12/0x20
Sep 28 19:56:10 thinkpaddie kernel:  [pci_destroy_dev+41/121] 
pci_destroy_dev+0x29/0x79
Sep 28 19:56:10 thinkpaddie kernel:  [pci_remove_bus_device+49/56] 
pci_remove_bus_device+0x31/0x38
Sep 28 19:56:10 thinkpaddie kernel:  [pci_remove_behind_bridge+45/74] 
pci_remove_behind_bridge+0x2d/0x4a
Sep 28 19:56:10 thinkpaddie kernel:  [pg0+559380642/1069257728] 
cb_free+0x24/0x5d [pcmcia_core]
Sep 28 19:56:10 thinkpaddie kernel:  [pg0+559363616/1069257728] 
shutdown_socket+0x64/0xaf [pcmcia_core]
Sep 28 19:56:10 thinkpaddie kernel:  [pg0+559363907/1069257728] 
socket_shutdown+0x34/0x3a [pcmcia_core]
Sep 28 19:56:10 thinkpaddie kernel:  [pg0+559365255/1069257728] 
socket_remove+0x12/0x43 [pcmcia_core]
Sep 28 19:56:10 thinkpaddie kernel:  [pg0+559365385/1069257728] 
socket_detect_change+0x51/0x88 [pcmcia_core]
Sep 28 19:56:10 thinkpaddie kernel:  [pg0+559365944/1069257728] 
pccardd+0x1f8/0x1fd [pcmcia_core]
Sep 28 19:56:10 thinkpaddie kernel:  [kernel_thread_helper+5/11] 
kernel_thread_helper+0x5/0xb
Sep 28 19:56:10 thinkpaddie kernel: Code: e8 94 96 37 de 83 c4 38 5b 5d c3 55 
89 e5 57 56 53 83 ec 10 8b 45 08 8b 98 28 1d 00 00 8b 80 20 1d 00 00 8b 70 04 
bf fd 90 dc e1 <ac> ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 85 c0 0f 85 
98

I tried to find out what might be wrong, but this requires some indepth 
knowledge about the thing.


0000:07:00.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 46) (prog-if 10 [OHCI])
        Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f6000000 (32-bit, non-prefetchable) [size=2K]
        Region 1: I/O ports at 3000 [size=128]
        Region 2: Memory at f6000800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Thanks.

-- 
GJ

Binary system, you're either 1 or 0...
dead or alive ;)
