Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbSKSNdL>; Tue, 19 Nov 2002 08:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264984AbSKSNdL>; Tue, 19 Nov 2002 08:33:11 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:8832 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S264644AbSKSNdK>; Tue, 19 Nov 2002 08:33:10 -0500
Date: Wed, 20 Nov 2002 00:39:59 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.48 and ALSA
Message-ID: <20021119133959.GA818@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it supposed to work when compiled into the kernel? I have it compiled
with OSS emulation and it worked as modules with 2.5.47 but not compiled
in to 2.5.48 (trying to avoid the whole modules changes here :)

I get the sound device recognised but I hear no output and aumix is only
reporting Vol, Synth, Line, Mic and CD. No PCM. :/

This is the relevant part of dmesg. I can't give it in full because the
buffer overflows on bootup. :/

Advanced Linux Sound Architecture Driver Version 0.9.0rc5 (Sun Nov 10 19:48:18 2002 UTC).
request_module[snd-card-0]: not ready
request_module[snd-card-1]: not ready
request_module[snd-card-2]: not ready
request_module[snd-card-3]: not ready
request_module[snd-card-4]: not ready
request_module[snd-card-5]: not ready
request_module[snd-card-6]: not ready
request_module[snd-card-7]: not ready
driver pci:Maestro3: registering
kobject Maestro3: registering
bus pci: add driver Maestro3
PCI: Enabling device 00:0c.0 (0000 -> 0003)
Yenta IRQ list 00b8, PCI irq10
Socket status: 30000820
Yenta IRQ list 00b8, PCI irq10
Socket status: 30000006
bound device '00:0c.0' to driver 'Maestro3'
ALSA device list:
  #0: Dummy 1
  #1: ESS Maestro3 PCI at 0x1000, irq 11

And my .config:

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_DUMMY=y
CONFIG_SND_VIRMIDI=y
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
CONFIG_SND_MAESTRO3=y
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set

I'd provide /proc/asound entries but there's a buttload of files there
and I don't know what would be interesting. The only patch applied to
the kernel is the one to make the kernel pnpbios option play nicely with
my laptops broken bios (ie it lets me boot up).

Any question etc, please holler. :)

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
