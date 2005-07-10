Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVGJUjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVGJUjh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 16:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVGJUj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 16:39:27 -0400
Received: from gherkin.frus.com ([192.158.254.49]:4809 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S262091AbVGJUh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 16:37:26 -0400
Subject: Re: 2.6.12 vs. /sbin/cardmgr
In-Reply-To: <20050710184649.GG8758@dominikbrodowski.de> "from Dominik Brodowski
 at Jul 10, 2005 08:46:49 pm"
To: Dominik Brodowski <linux@dominikbrodowski.net>
Date: Sun, 10 Jul 2005 15:37:22 -0500 (CDT)
CC: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20050710203722.DCBBDDBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
> On Sat, Jul 09, 2005 at 12:12:17AM -0500, Bob Tracy wrote:
> > (/sbin/cardmgr chewing up lots of CPU cycles with 2.6.12 kernel)
> 
> Please post the output of "lspci" and "lsmod" as I'd like to know which
> kind of PCMCIA bridge is in your notebook.

====-- lspci -v --====

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Flags: bus master, medium devsel, latency 32
	Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fc000000-feffffff

00:03.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 00bb
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 10100000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

00:03.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 00bb
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 10101000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001

00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 32
	I/O ports at 0860 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at dce0 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Flags: medium devsel, IRQ 9

00:08.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI Audio Accelerator (rev 10)
	Subsystem: Dell Computer Corporation: Unknown device 00bb
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at d800 [size=256]
	Memory at faffe000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [c0] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00bb
	Flags: bus master, stepping, medium devsel, latency 32, IRQ 11
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	I/O ports at ec00 [size=256]
	Memory at fcfff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
	Capabilities: [5c] Power Management version 1

06:00.0 Ethernet controller: Galileo Technology Ltd.: Unknown device 1fa6 (rev 07)
	Subsystem: D-Link System Inc: Unknown device 3b08
	Flags: bus master, 66Mhz, medium devsel, latency 168, IRQ 11
	Memory at 11000000 (32-bit, non-prefetchable) [size=64K]
	Memory at 11010000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [40] Power Management version 2

====-- lsmod --====
Module                  Size  Used by
parport_pc             37252  1 
lp                     12132  0 
parport                39048  2 parport_pc,lp
irda                  132120  0 
crc_ccitt               1984  1 irda
snd_seq_oss            37376  0 
snd_seq_midi_event      8320  1 snd_seq_oss
snd_seq                61552  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          8876  2 snd_seq_oss,snd_seq
snd_pcm_oss            62784  0 
snd_mixer_oss          21440  1 snd_pcm_oss
snd_maestro3           24836  0 
snd_ac97_codec         85432  1 snd_maestro3
snd_pcm               107012  3 snd_pcm_oss,snd_maestro3,snd_ac97_codec
snd_timer              27972  2 snd_seq,snd_pcm
snd_page_alloc         10564  1 snd_pcm
snd                    61060  9 snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_maestro3,snd_ac97_codec,snd_pcm,snd_timer
soundcore              10272  1 snd
ide_cd                 44196  0 
cdrom                  42752  1 ide_cd
pcmcia                 28552  2 
yenta_socket           23720  3 
rsrc_nonstatic         13952  1 yenta_socket
pcmcia_core            52580  3 pcmcia,yenta_socket,rsrc_nonstatic
driverloader          337488  0 
intel_agp              23708  1 
agpgart                36648  1 intel_agp
uhci_hcd               34384  0 
usbcore               127100  3 driverloader,uhci_hcd
genrtc                 10440  0 
joydev                  9952  0 
evdev                   9408  0 

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
