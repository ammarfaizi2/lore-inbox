Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbVHJViI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbVHJViI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 17:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbVHJViH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 17:38:07 -0400
Received: from nef2.ens.fr ([129.199.96.40]:59914 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1030285AbVHJViG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 17:38:06 -0400
Date: Wed, 10 Aug 2005 23:38:02 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel Mailing-List <linux-kernel@vger.kernel.org>
Subject: how do I read CPU temperature in ACPI? (w/ P5WD2 motherboard)
Message-ID: <20050810213802.GA8105@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Wed, 10 Aug 2005 23:38:03 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I apologize for what is surely a stupid question: I understand
that ACPI should be able to tell me what my CPU's temperature is (I
have a sever overheating problem and I am trying to solve it by
underclocking somewhat, but I need to be able to read the temperature
to do anything worth while), but no matter what ACPI modules I load, I
can't find any hint of a CPU temperature reading anywhere below
/proc/acpi (the /proc/acpi/thermal_zone/ directory, for example,
remains empty).

That's with the "thermal", "processor" and "fan" modules loaded (and a
few others; full listing follows signature).  I tried to load the
asus_acpi module also, since I have an ASUS motherboard (a P5WD2
Premium - precise details are given below signature), but I got a "No
such device" error.  Does that mean my motherboard is unsupported and
I cannot read my CPU temperature at all?  (But I thought the whole
_point_ of ACPI was that it was an abstraction away from the hardware:
so why is there such a thing as "Asus" ACPI?)  Or else, what am I
doing wrong?

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )

Full details:

hardware config:

Asus P5WD2 Premium motherboard
Intel 995X chipset
Intel Pentium 4 550 @3.4GHz processor

lsmod output:

Module                  Size  Used by
ac                      5892  0 
container               5504  0 
fan                     5636  0 
video                  17156  0 
thermal                14600  0 
processor              24328  1 thermal
nvidia               3714948  12 
agpgart                37580  1 nvidia
ide_cd                 44804  0 
cdrom                  42528  1 ide_cd
af_packet              25480  4 
ip6table_filter         3840  1 
ip6_tables             21120  1 ip6table_filter
ipt_REJECT              6656  8 
ipt_TOS                 3584  1 
reiserfs              281716  7 
snd_emu10k1_synth       8960  0 
snd_emu10k1           120068  1 snd_emu10k1_synth
snd_ac97_codec         84216  1 snd_emu10k1
snd_pcm_oss            54688  0 
snd_mixer_oss          20736  1 snd_pcm_oss
snd_pcm                96900  3 snd_emu10k1,snd_ac97_codec,snd_pcm_oss
snd_page_alloc         11140  2 snd_emu10k1,snd_pcm
snd_emux_synth         39680  1 snd_emu10k1_synth
snd_seq_virmidi         9088  1 snd_emux_synth
snd_seq_midi_emul       8576  1 snd_emux_synth
snd_seq_dummy           4740  0 
snd_seq_oss            36992  0 
snd_seq_midi           10144  0 
snd_rawmidi            27040  3 snd_emu10k1,snd_seq_virmidi,snd_seq_midi
snd_seq_midi_event      8960  3 snd_seq_virmidi,snd_seq_oss,snd_seq_midi
snd_seq                57360  9 snd_emux_synth,snd_seq_virmidi,snd_seq_midi_emul,snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_timer              27012  3 snd_emu10k1,snd_pcm,snd_seq
snd_seq_device          9740  8 snd_emu10k1_synth,snd_emu10k1,snd_emux_synth,snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
snd_hwdep              10400  2 snd_emu10k1,snd_emux_synth
snd                    57956  13 snd_emu10k1,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_emux_synth,snd_seq_virmidi,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device,snd_hwdep
soundcore              11232  1 snd
snd_util_mem            5632  2 snd_emu10k1,snd_emux_synth
ipv6                  272544  24 
mousedev               13220  2 
iptable_mangle          3968  1 
iptable_nat            25268  0 
ip_conntrack           47208  1 iptable_nat
iptable_filter          4096  1 
ip_tables              23296  5 ipt_REJECT,ipt_TOS,iptable_mangle,iptable_nat,iptable_filter
capability              5896  0 
commoncap               8064  1 capability
ext2                   72328  6 
ext3                  146952  0 
jbd                    64920  1 ext3
mbcache                11268  2 ext2,ext3
ppp_deflate             7424  0 
zlib_deflate           23704  1 ppp_deflate
bsd_comp                7168  0 
tun                    13056  1 
ppp_async              13312  1 
ppp_generic            31892  7 ppp_deflate,bsd_comp,ppp_async
slhc                    8064  1 ppp_generic
crc_ccitt               3072  1 ppp_async
dummy                   4100  0 
dm_mod                 62368  0 
ohci1394               37300  0 
ieee1394              107704  1 ohci1394
usbhid                 36832  0 
ohci_hcd               23172  0 
uhci_hcd               34960  0 
usbcore               125820  4 usbhid,ohci_hcd,uhci_hcd
e1000                 108724  0 
rtc                    14664  0 
unix                   31248  364 

lspci output:

0000:00:00.0 Host bridge: Intel Corp.: Unknown device 2774 (rev 81)
0000:00:01.0 PCI bridge: Intel Corp.: Unknown device 2775 (rev 81)
0000:00:1b.0 0403: Intel Corp.: Unknown device 27d8 (rev 01)
0000:00:1c.0 PCI bridge: Intel Corp.: Unknown device 27d0 (rev 01)
0000:00:1c.1 PCI bridge: Intel Corp.: Unknown device 27d2 (rev 01)
0000:00:1c.2 PCI bridge: Intel Corp.: Unknown device 27d4 (rev 01)
0000:00:1c.3 PCI bridge: Intel Corp.: Unknown device 27d6 (rev 01)
0000:00:1c.4 PCI bridge: Intel Corp.: Unknown device 27e0 (rev 01)
0000:00:1c.5 PCI bridge: Intel Corp.: Unknown device 27e2 (rev 01)
0000:00:1d.0 USB Controller: Intel Corp.: Unknown device 27c8 (rev 01)
0000:00:1d.1 USB Controller: Intel Corp.: Unknown device 27c9 (rev 01)
0000:00:1d.2 USB Controller: Intel Corp.: Unknown device 27ca (rev 01)
0000:00:1d.3 USB Controller: Intel Corp.: Unknown device 27cb (rev 01)
0000:00:1d.7 USB Controller: Intel Corp.: Unknown device 27cc (rev 01)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev e1)
0000:00:1f.0 ISA bridge: Intel Corp.: Unknown device 27b8 (rev 01)
0000:00:1f.1 IDE interface: Intel Corp.: Unknown device 27df (rev 01)
0000:00:1f.2 IDE interface: Intel Corp.: Unknown device 27c0 (rev 01)
0000:00:1f.3 SMBus: Intel Corp.: Unknown device 27da (rev 01)
0000:01:01.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
0000:01:01.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 0a)
0000:01:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
0000:01:04.0 Unknown mass storage controller: Integrated Technology Express, Inc.: Unknown device 8211 (rev 11)
0000:01:05.0 Ethernet controller: Marvell Technology Group Ltd. Yukon Gigabit Ethernet 10/100/1000Base-T Adapter (rev 13)
0000:02:00.0 Unknown mass storage controller: Silicon Image, Inc. (formerly CMD Technology Inc): Unknown device 3132 (rev 01)
0000:03:00.0 Ethernet controller: Intel Corp.: Unknown device 108b (rev 03)
0000:08:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0161 (rev a1)
