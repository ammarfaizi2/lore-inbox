Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265585AbSJSLjT>; Sat, 19 Oct 2002 07:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265588AbSJSLjT>; Sat, 19 Oct 2002 07:39:19 -0400
Received: from rztsun.rz.tu-harburg.de ([134.28.200.14]:16088 "EHLO
	rztsun.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id <S265585AbSJSLjR> convert rfc822-to-8bit; Sat, 19 Oct 2002 07:39:17 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Jan Dittmer <jan@jandittmer.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Call Trace from snd_emu10k1
Date: Sat, 19 Oct 2002 13:46:22 +0200
User-Agent: KMail/1.4.3
Cc: alsa-devel@alsa-project.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210191346.22181.jan@jandittmer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Got a couple of these with 2.5.44, while playing with mplayer with ac3 
passthrough (on the sb live).
Let me know if I can provide you with anything else helpful. Perhaps I should 
add, that the system isn't hanging, halting or anything else. Sound is 
flawless (at least with mplayer).

jan

Complete system info at http://lx.sfhq.hn.org/

Debug: sleeping function called from illegal context at mm/slab.c:1374
Call Trace:
 [<c0118d34>] __might_sleep+0x54/0x60
 [<c01359ae>] kmalloc+0x4e/0x120
 [<e0900910>] snd_emu10k1_fx8010_playback_irq+0x0/0x10 [snd-emu10k1]
 [<e09007bc>] snd_emu10k1_fx8010_register_irq_handler+0x6c/0x110 [snd-emu10k1]
 [<e0900d83>] snd_emu10k1_fx8010_playback_trigger+0x73/0x110 [snd-emu10k1]
 [<e0900910>] snd_emu10k1_fx8010_playback_irq+0x0/0x10 [snd-emu10k1]
 [<e08dfda9>] snd_pcm_start_R492990f9+0xa9/0x130 [snd-pcm]
 [<e08e807f>] snd_pcm_lib_write1+0x43f/0x4b0 [snd-pcm]
 [<e08e8216>] snd_pcm_lib_write_R61c057e4+0x126/0x130 [snd-pcm]
 [<e08e7b90>] snd_pcm_lib_write_transfer+0x0/0xb0 [snd-pcm]
 [<e08e2b86>] snd_pcm_playback_ioctl1+0x1a6/0x410 [snd-pcm]
 [<e08e31c0>] snd_pcm_playback_ioctl+0x20/0x30 [snd-pcm]
 [<c01522d9>] sys_ioctl+0x279/0x2d0
 [<c010709b>] syscall_call+0x7/0xb

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 
Audio Controller (rev 50)
	Subsystem: Micro-star International Co Ltd: Unknown device 3300
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- SERR-

00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- SERR-


#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
# CONFIG_SND_DEBUG_MEMORY is not set
# CONFIG_SND_DEBUG_DETECT is not set
CONFIG_SND_EMU10K1=m
CONFIG_SND_VIA82XX=m

Module                  Size  Used by    Not tainted
btaudio                12260   0
snd-rtctimer            2344   0 (unused)
snd-pcm-oss            51620   0
snd-mixer-oss          15256   0 [snd-pcm-oss]
snd-emu10k1            74064   4
snd-rawmidi            19296   0 [snd-emu10k1]
snd-pcm                90112   3 [snd-pcm-oss snd-emu10k1]
snd-timer              16728   0 [snd-rtctimer snd-pcm]
snd-hwdep               5600   0 [snd-emu10k1]
snd-ac97-codec         31652   0 [snd-emu10k1]
snd-util-mem            3468   0 [snd-emu10k1]
snd-seq-device          5968   0 [snd-emu10k1 snd-rawmidi]


