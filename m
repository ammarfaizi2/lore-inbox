Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWCIKHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWCIKHW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 05:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWCIKHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 05:07:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10197 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750918AbWCIKHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 05:07:21 -0500
Subject: Re: Genius VideoWonder DVB-T PCI support
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: David Kredba <kredba@math.cas.cz>
Cc: linux-kernel@vger.kernel.org,
       Linux and Kernel Video <video4linux-list@redhat.com>
In-Reply-To: <4409506B.1050504@math.cas.cz>
References: <4409506B.1050504@math.cas.cz>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 09 Mar 2006 07:06:13 -0300
Message-Id: <1141898773.4575.1.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

It is better to address such questions to v4l ml or to dvb ml. Is it
possible to make it work with your help.

Cheers,
Mauro.

Em Sáb, 2006-03-04 às 09:31 +0100, David Kredba escreveu:
> Hello.
> 
> I got PCI card Genius VideoWonder DVB-T and I am trying to get it to work.
> 
> The card is using SAA7134H, TDA 10046HT and TDA 8274 chips.
> 
> My system is Gentoo (Base System version 1.6.14), kernel 2.6.15.
> 
> The card is, by lspci, visible as :
> 
> 02:03.0 Multimedia controller: Philips Semiconductors SAA7134 Video 
> Broadcast Decoder (rev 01)
>          Subsystem: KYE Systems Corporation Unknown device 0301
>          Flags: bus master, medium devsel, latency 32, IRQ 19
>          Memory at ffdffc00 (32-bit, non-prefetchable) [size=1K]
>          Capabilities: [40] Power Management version 1
> 
> If I tried to load saa7134-dvb module it loads and loads all of the 
> other needed modules, but it ignores the card and the module saa7134
> reports the card as V4L2 device and not the DVB.
> 
> There is /usr/lib/hotplug/firmware dvb-fe-tda10046.fw firmware.
> 
> The state before saa7134-dvb loaded :
> 
> Module                  Size  Used by
> w83627hf               24080  0
> hwmon_vid               2432  1 w83627hf
> i2c_isa                 3840  1 w83627hf
> snd_seq_midi            7072  0
> snd_emu10k1_synth       7040  0
> snd_emux_synth         35456  1 snd_emu10k1_synth
> snd_seq_virmidi         6272  1 snd_emux_synth
> snd_seq_midi_emul       7040  1 snd_emux_synth
> snd_pcm_oss            48800  0
> snd_mixer_oss          17280  1 snd_pcm_oss
> snd_seq_oss            33152  0
> snd_seq_midi_event      6144  3 snd_seq_midi,snd_seq_virmidi,snd_seq_oss
> snd_seq                50448  8 
> snd_seq_midi,snd_emux_synth,snd_seq_virmidi,snd_seq_midi_emul,snd_seq_oss,snd_seq_midi_event
> hci_usb                14100  5
> emu10k1_gp              3072  0
> snd_emu10k1           116388  2 snd_emu10k1_synth
> snd_rawmidi            20896  3 snd_seq_midi,snd_seq_virmidi,snd_emu10k1
> snd_seq_device          7308  7 
> snd_seq_midi,snd_emu10k1_synth,snd_emux_synth,snd_seq_oss,snd_seq,snd_emu10k1,snd_rawmidi
> snd_ac97_codec         91040  1 snd_emu10k1
> snd_pcm                80772  3 snd_pcm_oss,snd_emu10k1,snd_ac97_codec
> snd_timer              21636  3 snd_seq,snd_emu10k1,snd_pcm
> snd_ac97_bus            2176  1 snd_ac97_codec
> snd_page_alloc          8584  2 snd_emu10k1,snd_pcm
> snd_util_mem            3584  2 snd_emux_synth,snd_emu10k1
> snd_hwdep               7456  2 snd_emux_synth,snd_emu10k1
> snd                    48356  15 
> snd_emux_synth,snd_seq_virmidi,snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_emu10k1,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm,snd_timer,snd_hwdep
> soundcore               8032  1 snd
> video_buf              17284  0
> ir_kbd_i2c              6924  0
> ir_common               8324  1 ir_kbd_i2c
> videodev                7680  0
> i2c_i801                8076  0
> i2c_core               17536  4 w83627hf,i2c_isa,ir_kbd_i2c,i2c_i801
> intel_agp              20380  1
> agpgart                28880  1 intel_agp
> r8169                  23816  0
> 
> 
> The state after the saa7134-dvb loaded :
> 
> saa7134_dvb            10500  0
> mt352                   6276  1 saa7134_dvb
> saa7134               108896  1 saa7134_dvb
> v4l2_common             4992  1 saa7134
> v4l1_compat            13700  1 saa7134
> video_buf_dvb           4868  1 saa7134_dvb
> dvb_core               76584  1 video_buf_dvb
> nxt200x                14724  1 saa7134_dvb
> dvb_pll                 9092  2 saa7134_dvb,nxt200x
> tda1004x               15108  1 saa7134_dvb
> firmware_class          8320  3 saa7134_dvb,nxt200x,tda1004x
> w83627hf               24080  0
> hwmon_vid               2432  1 w83627hf
> i2c_isa                 3840  1 w83627hf
> snd_seq_midi            7072  0
> snd_emu10k1_synth       7040  0
> snd_emux_synth         35456  1 snd_emu10k1_synth
> snd_seq_virmidi         6272  1 snd_emux_synth
> snd_seq_midi_emul       7040  1 snd_emux_synth
> snd_pcm_oss            48800  0
> snd_mixer_oss          17280  1 snd_pcm_oss
> snd_seq_oss            33152  0
> snd_seq_midi_event      6144  3 snd_seq_midi,snd_seq_virmidi,snd_seq_oss
> snd_seq                50448  8 
> snd_seq_midi,snd_emux_synth,snd_seq_virmidi,snd_seq_midi_emul,snd_seq_oss,snd_seq_midi_event
> hci_usb                14100  5
> emu10k1_gp              3072  0
> snd_emu10k1           116388  2 snd_emu10k1_synth
> snd_rawmidi            20896  3 snd_seq_midi,snd_seq_virmidi,snd_emu10k1
> snd_seq_device          7308  7 
> snd_seq_midi,snd_emu10k1_synth,snd_emux_synth,snd_seq_oss,snd_seq,snd_emu10k1,snd_rawmidi
> snd_ac97_codec         91040  1 snd_emu10k1
> snd_pcm                80772  3 snd_pcm_oss,snd_emu10k1,snd_ac97_codec
> snd_timer              21636  3 snd_seq,snd_emu10k1,snd_pcm
> snd_ac97_bus            2176  1 snd_ac97_codec
> snd_page_alloc          8584  2 snd_emu10k1,snd_pcm
> snd_util_mem            3584  2 snd_emux_synth,snd_emu10k1
> snd_hwdep               7456  2 snd_emux_synth,snd_emu10k1
> snd                    48356  15 
> snd_emux_synth,snd_seq_virmidi,snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_emu10k1,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm,snd_timer,snd_hwdep
> soundcore               8032  1 snd
> video_buf              17284  3 saa7134_dvb,saa7134,video_buf_dvb
> ir_kbd_i2c              6924  1 saa7134
> ir_common               8324  2 saa7134,ir_kbd_i2c
> videodev                7680  1 saa7134
> i2c_i801                8076  0
> i2c_core               17536  9 
> saa7134_dvb,mt352,saa7134,nxt200x,tda1004x,w83627hf,i2c_isa,ir_kbd_i2c,i2c_i801
> intel_agp              20380  1
> agpgart                28880  1 intel_agp
> r8169                  23816  0
> 
> There is this and only this message, coming from saa7134, in teh 
> /var/log/messages file :
> 
> saa7130/34: v4l2 driver version 0.2.14 loaded
> ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
> saa7134[0]: found at 0000:02:03.0, rev: 1, irq: 19, latency: 32, mmio: 
> 0xffdffc00
> saa7134[0]: subsystem: 1489:0301, board: UNKNOWN/GENERIC 
> [card=0,autodetected]
> saa7134[0]: board init: gpio is 10000
> saa7134[0]: i2c eeprom 00: 89 14 01 03 54 20 1c 00 43 43 a9 1c 55 d2 b2 92
> saa7134[0]: i2c eeprom 10: 00 ff 86 0f ff 20 ff ff ff ff ff ff ff ff ff ff
> saa7134[0]: i2c eeprom 20: 01 40 01 02 03 ff 01 03 08 ff 01 ec ff ff ff ff
> saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> saa7134[0]: i2c eeprom 40: ff 1b 00 c0 ff 10 ff ff ff ff ff ff ff ff ff ff
> saa7134[0]: i2c eeprom 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> saa7134[0]: i2c eeprom 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> saa7134[0]: i2c eeprom 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> saa7134[0]: registered device video0 [v4l2]
> saa7134[0]: registered device vbi0
> 
> There is no support for that card at linuxtv.org site.
> 
> Is there possibility to get the card working?
> 
> Thank you very much, David Kredba
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
Cheers, 
Mauro.

