Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWJMPB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWJMPB3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 11:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWJMPB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 11:01:29 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:38798 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750904AbWJMPB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 11:01:28 -0400
Message-ID: <1160751687.452faa4742f00@imp5-g19.free.fr>
Date: Fri, 13 Oct 2006 17:01:27 +0200
From: neologix@free.fr
To: linux-kernel@vger.kernel.org
Subject: [PROBLEM] ATI IXP - Unknown symbol -> no sound
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 70.225.171.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

short:
[2.6.18] ATI IXP - Unknown symbol -> no sound

longer:
I have an ATI IXP sound card, and since kernel 2.6.17, sometimes I have no sound
when I boot.
The card dosn't appear in /proc/asound/cards

The relevant log part are given below
What is weird is that the modules are loaded, and that it doesn't happen
everytime.
I have a P4 with hyperthreading enabled (I don't know if it plays a part).
The thing is that before 2.6.17, I never had problems

If you need any information or anything, feel free to ask.





*** lspci ***

00:14.5 Multimedia audio controller: ATI Technologies Inc IXP150 AC'97 Audio
Controller
        Subsystem: Hewlett-Packard Company Unknown device 006b
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 64 (500ns min), Cache Line Size: 32 bytes
        Interrupt: pin B routed to IRQ 5
        Region 0: Memory at d0003000 (32-bit, non-prefetchable) [size=256]

00:14.6 Modem: ATI Technologies Inc IXP AC'97 Modem (rev 01) (prog-if 00
[Generic])
        Subsystem: Hewlett-Packard Company Unknown device 006b
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 64 (500ns min), Cache Line Size: 32 bytes
        Interrupt: pin B routed to IRQ 5
        Region 0: Memory at d0003400 (32-bit, non-prefetchable) [size=256]

*** /lspci ***





*** dmesg ***

snd_pcm: Unknown symbol snd_dma_reserve_buf
snd_pcm: Unknown symbol snd_dma_free_pages
snd_pcm: Unknown symbol snd_malloc_pages
snd_pcm: Unknown symbol snd_dma_get_reserved_buf
snd_pcm: Unknown symbol snd_dma_alloc_pages
snd_pcm: Unknown symbol snd_free_pages
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 17
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[17]  MMIO=[d0208000-d02087ff]  Max
Packet=[2048]  IR/IT contexts=[4/8]
snd_ac97_codec: Unknown symbol snd_interval_refine
snd_ac97_codec: Unknown symbol snd_pcm_hw_rule_add
Yenta: CardBus bridge found at 0000:02:04.0 [103c:006b]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:04.0, mfunc 0x01111d22, devctl 0x64
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:13.0: irq 18, io mem 0xd0001000
snd_atiixp: Unknown symbol snd_ac97_pcm_close
snd_atiixp: Unknown symbol snd_ac97_resume
snd_atiixp: Unknown symbol snd_pcm_new
snd_atiixp: Unknown symbol snd_pcm_limit_hw_rates
snd_atiixp: Unknown symbol snd_pcm_lib_preallocate_pages_for_all
snd_atiixp: Unknown symbol snd_ac97_pcm_open
snd_atiixp: Unknown symbol snd_pcm_stop
snd_atiixp: Unknown symbol snd_pcm_format_physical_width
snd_atiixp: Unknown symbol snd_ac97_update_bits
snd_atiixp: Unknown symbol snd_ac97_mixer
snd_atiixp: Unknown symbol snd_ac97_bus
snd_atiixp: Unknown symbol snd_ac97_suspend
snd_atiixp: Unknown symbol snd_pcm_lib_malloc_pages
snd_atiixp: Unknown symbol snd_pcm_lib_ioctl
snd_atiixp: Unknown symbol snd_pcm_lib_free_pages
snd_atiixp: Unknown symbol snd_pcm_set_ops
snd_atiixp: Unknown symbol snd_ac97_get_short_name
snd_atiixp: Unknown symbol snd_pcm_suspend_all
snd_atiixp: Unknown symbol snd_ac97_pcm_assign
snd_atiixp: Unknown symbol snd_pcm_hw_constraint_integer
snd_atiixp: Unknown symbol snd_pcm_period_elapsed
snd_atiixp: Unknown symbol snd_pcm_hw_constraint_step
snd_atiixp: Unknown symbol snd_ac97_tune_hardware

*** /dmesg ***



If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux neobox 2.6.18 #1 SMP PREEMPT Wed Sep 20 12:41:54 CDT 2006 i686 GNU/Linux

Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
udev                   100
Modules Loaded         radeon thermal fan button processor ac battery
michael_mic arc4 ieee80211_crypt_tkip aes ieee80211_crypt_ccmp nls_iso8859_1
nls_cp437 vfat fat nls_base snd_usb_audio snd_usb_lib snd_rawmidi
snd_seq_device snd_hwdep usbhid 8250_pci 8250 serial_core pcmcia ehci_hcd
bcm43xx snd_atiixp_modem snd_ac97_codec ide_cd ohci_hcd snd_pcm firmware_class
yenta_socket rsrc_nonstatic pcmcia_core cdrom snd_ac97_bus usbcore ohci1394
snd_timer snd soundcore snd_page_alloc ieee80211softmac ieee80211
ieee80211_crypt


I recently had the same "undefined symbols" problem, but they don't appear in
the same order:

*** dmesg ***

Oct 12 13:03:41 neobox kernel: snd_ac97_codec: Unknown symbol ac97_bus_type
Oct 12 13:03:41 neobox kernel: ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19
(level, low) -> IRQ 18
Oct 12 13:03:41 neobox kernel: ohci_hcd 0000:00:13.1: OHCI Host Controller
Oct 12 13:03:41 neobox kernel: ohci_hcd 0000:00:13.1: new USB bus registered,
assigned bus number 2
Oct 12 13:03:41 neobox kernel: ohci_hcd 0000:00:13.1: irq 18, io mem 0xd0002000
Oct 12 13:03:41 neobox kernel: snd_atiixp: Unknown symbol snd_ac97_pcm_close
Oct 12 13:03:41 neobox kernel: snd_atiixp: Unknown symbol snd_ac97_resume
Oct 12 13:03:41 neobox kernel: snd_atiixp: Unknown symbol snd_ac97_pcm_open
Oct 12 13:03:41 neobox kernel: snd_atiixp: Unknown symbol snd_ac97_update_bits
Oct 12 13:03:41 neobox kernel: snd_atiixp: Unknown symbol snd_ac97_mixer
Oct 12 13:03:41 neobox kernel: snd_atiixp: Unknown symbol snd_ac97_bus
Oct 12 13:03:41 neobox kernel: snd_atiixp: Unknown symbol snd_ac97_suspend
Oct 12 13:03:41 neobox kernel: snd_atiixp: Unknown symbol
snd_ac97_get_short_name
Oct 12 13:03:41 neobox kernel: snd_atiixp: Unknown symbol snd_ac97_pcm_assign
Oct 12 13:03:41 neobox kernel: snd_atiixp: Unknown symbol snd_ac97_tune_hardware

*** /dmesg ***



cheers

