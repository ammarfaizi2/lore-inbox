Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264299AbRFDOso>; Mon, 4 Jun 2001 10:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264253AbRFDNWx>; Mon, 4 Jun 2001 09:22:53 -0400
Received: from 11dyn36.beverw.casema.net ([212.64.98.36]:63749 "EHLO
	gateway.castricum.nl") by vger.kernel.org with ESMTP
	id <S264252AbRFDNWi>; Mon, 4 Jun 2001 09:22:38 -0400
Message-ID: <000701c0ecf9$eae40dc0$0501a8c0@castricum.nl>
From: "Ben Castricum" <hostmaster@cia.c64.org>
To: <linux-kernel@vger.kernel.org>
Subject: I810 Sound broke between 2.4.2 and 2.4.3
Date: Mon, 4 Jun 2001 15:26:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I use amp to play my mp3s and it seem to stop functioning since 2.4.3. I
captured the kernel messages from the module :

--- 2.4.2 ---
Intel 810 + AC97 Audio, version 0.01, 14:04:06 Jun  4 2001
PCI: Found IRQ 10 for device 00:1f.5
PCI: The same IRQ used for device 00:1f.3
PCI: The same IRQ used for device 01:09.0
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH 82801AA found at IO 0xe100 and 0xe000, IRQ 10
ac97_codec: AC97 Audio codec, id: 0x4144:0x5340 (Analog Devices AD1881)
i810_audio: Codec refused to allow VRA, using 48Khz only.

--- 2.4.3 ---
Intel 810 + AC97 Audio, version 0.01, 14:18:58 Jun  4 2001
PCI: Found IRQ 10 for device 00:1f.5
PCI: The same IRQ used for device 00:1f.3
PCI: The same IRQ used for device 01:09.0
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH 82801AA found at IO 0xe100 and 0xe000, IRQ 10
ac97_codec: AC97 Audio codec, id: 0x4144:0x5340 (Analog Devices AD1881)
i810_audio: Codec refused to allow VRA, using 48Khz only.
i810_audio: 9576 bytes in 50 milliseconds

an strace of amp seems to halt on writing to the /dev/dsp

I have an Intel Celeron on an Asus-MEW motherboard which has this soundcard
integrated.

Any ideas?

Ben

