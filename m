Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbSKCFq0>; Sun, 3 Nov 2002 00:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSKCFq0>; Sun, 3 Nov 2002 00:46:26 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:33238 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S261660AbSKCFqS>; Sun, 3 Nov 2002 00:46:18 -0500
Message-ID: <3DC4B9A7.3080707@nortelnetworks.com>
Date: Sun, 03 Nov 2002 00:52:39 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: small question and bug report for 2.5.45
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With 2.5, if I change the kernel config what is the minimal sequence of 
make commands needed to give me a ready-to-boot system?  (ie which of 
"dep bzImage modules modules_install install" are required?)

Also, I've been getting a bunch of the following errors in dmesg on 2.5.45:


Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
Call Trace:
  [<c031944c>] snd_cs46xx_playback_prepare+0x3c/0x2b0
  [<c02f609f>] snd_pcm_prepare+0xdf/0x210
  [<c02f8408>] snd_pcm_playback_ioctl1+0x48/0x2e0
  [<c02f89f6>] snd_pcm_kernel_playback_ioctl+0x36/0x50
  [<c02eb8c7>] snd_pcm_oss_prepare+0x27/0x50
  [<c02eb930>] snd_pcm_oss_make_ready+0x40/0x60
  [<c02ebd5a>] snd_pcm_oss_write1+0x3a/0x180
  [<c02edde8>] snd_pcm_oss_write+0x48/0x80
  [<c01432bb>] vfs_write+0xcb/0x130
  [<c014353c>] sys_write+0x3c/0x50
  [<c0107553>] syscall_call+0x7/0xb


relevent config bits:
#
# Sound
#
CONFIG_SOUND=y

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1816A is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES968 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_ALS100 is not set
# CONFIG_SND_AZT2320 is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_DT019X is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
CONFIG_SND_CS46XX=y
CONFIG_SND_CS46XX_NEW_DSP=y
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
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

