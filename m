Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVCEXel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVCEXel (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 18:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVCEXcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:32:13 -0500
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:38313 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261207AbVCEXJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:09:15 -0500
Message-ID: <422A3C7F.3020501@yahoo.com>
Date: Sat, 05 Mar 2005 15:10:55 -0800
From: Lars <lhofhansl@yahoo.com>
Organization: What? Organized??
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.11 breaks ALSA Intel AC97 audio
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With Kernel 2.6.11 the Audio driver in my ThinkPad T42 stopped working.
The dsp device is detected and readable/writable, but there's no
audible sound.
Everything worked fine with 2.6.9 and 2.6.10.
Did anybody else see this?

/proc/pci:
----------

   Bus  0, device  31, function  5:
     Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 1).
       IRQ 11.
       I/O at 0x1c00 [0x1cff].
       I/O at 0x18c0 [0x18ff].
       Non-prefetchable 32 bit memory at 0xc0000c00 [0xc0000dff].
       Non-prefetchable 32 bit memory at 0xc0000800 [0xc00008ff].

Kernel sound config:
--------------------

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
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
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VX222 is not set

Loaded Modules:
---------------

snd_intel8x0           28864  1
snd_ac97_codec         75256  1 snd_intel8x0
snd_pcm_oss            50016  0
snd_mixer_oss          17856  1 snd_pcm_oss
snd_pcm                82120  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              20740  1 snd_pcm
snd                    45156  8 
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               7008  1 snd
snd_page_alloc          7620  2 snd_intel8x0,snd_pcm

