Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317014AbSF0Xd3>; Thu, 27 Jun 2002 19:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317018AbSF0Xd2>; Thu, 27 Jun 2002 19:33:28 -0400
Received: from mtiwmhc21.worldnet.att.net ([204.127.131.46]:30874 "EHLO
	mtiwmhc21.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S317014AbSF0Xd1>; Thu, 27 Jun 2002 19:33:27 -0400
Date: Thu, 27 Jun 2002 19:39:53 -0400
To: linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com
Subject: via82cxxx_audio.c: Assertion failed!
Message-ID: <20020627233953.GA6654@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.4.19-rc1, after playing bzflag I noticed the following
messages:

Assertion failed! chan->is_active == sg_active(chan->iobase),via82cxxx_audio.c,v
ia_chan_maybe_start,line=1196 <--this was repeated 16 times.
via_audio: ignoring drain playback error -512

The second time I was able to reproduce it(while playing bzflag) I
didn't get the "via_audio: .. " message.

Below is the output of ./via-audio-diag -aps while playing bzflag.

via-audio-diag.c:v1.00 05/06/2000 Jeff Garzik (jgarzik@mandrakesoft.com)
Index #1: Found a via 686a audio adapter at 0xcc00.
AC97 RESET = 0x5800 (22528)
AC97 MASTER_VOL_STEREO = 0x0606 (1542)
AC97 HEADPHONE_VOL = 0x8000 (32768)
AC97 MASTER_VOL_MONO = 0x000A (10)
AC97 MASTER_TONE = 0x0000 (0)
AC97 PCBEEP_VOL = 0x8000 (32768)
AC97 PHONE_VOL = 0x8000 (32768)
AC97 MIC_VOL = 0x8000 (32768)
AC97 LINEIN_VOL = 0x8000 (32768)
AC97 CD_VOL = 0x8000 (32768)
AC97 VIDEO_VOL = 0x8000 (32768)
AC97 AUX_VOL = 0x8000 (32768)
AC97 PCMOUT_VOL = 0x0101 (257)
AC97 RECORD_SELECT = 0x0000 (0)
AC97 RECORD_GAIN = 0x8000 (32768)
AC97 RECORD_GAIN_MIC = 0x0000 (0)
AC97 GENERAL_PURPOSE = 0x0000 (0)
AC97 3D_CONTROL = 0x0000 (0)
AC97 MODEM_RATE = 0x0000 (0)
AC97 POWER_CONTROL = 0x000F (15)
AC97 EXTENDED_ID = 0x0200 (512)
AC97 EXTENDED_STATUS = 0x0000 (0)
AC97 PCM_FRONT_DAC_RATE = 0x0000 (0)
AC97 PCM_SURR_DAC_RATE = 0x0000 (0)
AC97 PCM_LFE_DAC_RATE = 0x0000 (0)
AC97 PCM_LR_ADC_RATE = 0x0000 (0)
AC97 PCM_MIC_ADC_RATE = 0x0000 (0)
AC97 CENTER_LFE_MASTER = 0x0000 (0)
AC97 SURROUND_MASTER = 0x0000 (0)
AC97 RESERVED_3A = 0x0000 (0)
SGD Playback            : 80 00 B7 09D21008 000008B8
SGD Record              : 00 00 00 00000000 00000000
SGD FM                  : 00 00 00 00000000 00000000
SGD Modem Playback      : 00 00 00 00000000 00000000
SGD Modem Record        : 00 00 00 00000000 00000000
SGD reg 0x80 = 0x00BA0000
SGD reg 0x84 = 0x00001000
SGD reg 0x88 = 0x00000000
SGD reg 0x8C = 0x00000000
PCI reg 0x10 = 0xD0000008
PCI reg 0x3C = 0x00
PCI reg 0x40 = 0x00
PCI reg 0x41 = 0x00
PCI reg 0x42 = 0x00
PCI reg 0x43 = 0x00
PCI reg 0x44 = 0x00
PCI reg 0x48 = 0x00

If there's anything else I can do, let me know.

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
