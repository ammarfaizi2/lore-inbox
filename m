Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSH0JtN>; Tue, 27 Aug 2002 05:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSH0JtN>; Tue, 27 Aug 2002 05:49:13 -0400
Received: from hal.astr.lu.lv ([195.13.134.67]:29830 "EHLO hal.astr.lu.lv")
	by vger.kernel.org with ESMTP id <S315454AbSH0JtM> convert rfc822-to-8bit;
	Tue, 27 Aug 2002 05:49:12 -0400
From: Andris Pavenis <pavenis@latnet.lv>
To: linux-kernel@vger.kernel.org
Subject: Linux-2.4.20-pre4-ac1: i810_audio broken
Date: Tue, 27 Aug 2002 12:53:12 +0300
User-Agent: KMail/1.4.6
Cc: Doug Ledford <dledford@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200208271253.12192.pavenis@latnet.lv>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found that i810_audio has been broken in kernel 2.4.20-pre4-ac1. It was Ok with 
2.4.20-pre1-ac1 I used before.

With 2.4.20-pre4-ac1 I'm only getting garbled sound and kernel messages (see below).
Didn't have time yet to study mire detailed which change breaks driver.

In Alan's changelog I see:

2.4.20-pre2-ac5: Further i810_audio updates for 845 (Juergen Sawinski) 
2.4.20-pre1-ac3: Tidy up error paths on i810_audio init (Alan) 
2.4.20-pre1-ac2: First set of i810 audio updates (Doug Ledford) 

Andris

------ at startup -----------------
Intel 810 + AC97 Audio, version 0.22, 11:18:00 Aug 26 2002
PCI: Found IRQ 5 for device 00:1f.5
PCI: Sharing IRQ 5 with 00:1f.3
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH 82801AA found at IO 0xe100 and 0xe000, MEM 0x0000 and 0x0000, IRQ 5
i810_audio: Audio Controller supports 2 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: resetting hw channel 0
ac97_codec: AC97 Audio codec, id: 0x4144:0x5348 (Analog Devices AD1881A)
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not present), to
------ error messages  ------------
i810_audio: DMA overrun on write
i810_audio: CIV 0, LVI 27, hwptr 253a, count -13626
i810_audio: DMA overrun on write
i810_audio: CIV 0, LVI 27, hwptr 2662, count -296
i810_audio: DMA overrun on write
i810_audio: CIV 0, LVI 27, hwptr 2662, count -296
i810_audio: DMA overrun on write
i810_audio: CIV 0, LVI 27, hwptr 266a, count -8
i810_audio: DMA overrun on write
i810_audio: CIV 1, LVI 31, hwptr 2924, count -10526
i810_audio: DMA overrun on write
i810_audio: CIV 1, LVI 31, hwptr 2924, count -10526
i810_audio: DMA overrun on write
i810_audio: CIV 0, LVI 3, hwptr 253a, count -5434
i810_audio: DMA overrun on write
i810_audio: CIV 0, LVI 3, hwptr 2562, count -40
......

---------  error message from artsd (KDE-3.1 beta1) -------
Sound server fatal error:
AudioSubSystem::handleIO: write failed
len = 3228, can_write = 4096, errno = 17 (File exists)
This might be a sound hardware/driver specific problem (see aRts FAQ)

-------------------------------------------------------------------- 
Kernel was compiled with gcc-3.1 (like earlier kernels where i810_audio worked
Ok)
