Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279778AbRLQN6I>; Mon, 17 Dec 2001 08:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279981AbRLQN57>; Mon, 17 Dec 2001 08:57:59 -0500
Received: from lab1.psy.univie.ac.at ([131.130.64.2]:46013 "EHLO
	lab1.psy.univie.ac.at") by vger.kernel.org with ESMTP
	id <S279778AbRLQN5z>; Mon, 17 Dec 2001 08:57:55 -0500
Date: Mon, 17 Dec 2001 14:57:53 +0100 (CET)
From: Ulrich Leodolter <ulrich@lab1.psy.univie.ac.at>
X-X-Sender: <ulrich@lab20.brl.univie.ac.at>
To: <linux-kernel@vger.kernel.org>
Subject: i810_audio.c v0.11 kernel lockup
Message-ID: <Pine.LNX.4.33.0112171427150.1299-100000@lab20.brl.univie.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


problem:	kernel lockup when apps tries to play sound
kernel:		linux-2.4.17-pre8
i810_audio.c:	version 0.11 from 
http://people.redhat.com/dledford/i810_audio.c.gz
processor:	Intel Pentium4 1.5GHz
mainboard:	Luck Star P4A845S (http://www.lucky-star.com.tw)

i have compiled the driver with all DEBUG enabled,
here are the last kernel messages before the kernel dies:

Dec 17 14:22:22 lab20 kernel: Intel 810 + AC97 Audio, version 0.11, 10:33:03 Dec 17 2001
Dec 17 14:22:22 lab20 kernel: PCI: Found IRQ 11 for device 00:1f.5
Dec 17 14:22:22 lab20 kernel: PCI: Sharing IRQ 11 with 00:1f.3
Dec 17 14:22:22 lab20 kernel: PCI: Setting latency timer of device 00:1f.5 to 64
Dec 17 14:22:22 lab20 kernel: i810: Intel ICH2 found at IO 0xe000 and 0xdc00, IRQ 11
Dec 17 14:22:22 lab20 kernel: i810_audio: Audio Controller supports 6 channels.
Dec 17 14:22:22 lab20 kernel: ac97_codec: AC97 Audio codec, id: 0x414c:0x4710 (ALC200/200P)
Dec 17 14:22:22 lab20 kernel: i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
Dec 17 14:22:22 lab20 kernel: i810_audio: called i810_set_dac_rate : asked for 48000, got 48000
Dec 17 14:22:22 lab20 kernel: i810_audio: allocated 65536 (order = 4) bytes at ee980000
Dec 17 14:22:22 lab20 kernel: i810_audio: prog_dmabuf, sample rate = 48000, format = 3,
Dec 17 14:22:22 lab20 kernel: ^Inumfrag = 32, fragsize = 2048 dmasize = 65536
Dec 17 14:22:22 lab20 kernel: i810_audio: 9584 bytes in 50 milliseconds
Dec 17 14:22:43 lab20 kernel: i810_audio: called i810_set_dac_rate : asked for 8000, got 8000
Dec 17 14:22:43 lab20 kernel: i810_audio: i810_ioctl, arg=0x10, cmd=SNDCTL_DSP_SETFMT
Dec 17 14:22:43 lab20 kernel: i810_audio: i810_ioctl, arg=0x0, cmd=SNDCTL_DSP_STEREO
Dec 17 14:22:43 lab20 kernel: i810_audio: i810_ioctl, arg=0x5622, cmd=SNDCTL_DSP_SPEED
Dec 17 14:25:06 lab20 syslogd 1.3-3: restart.


-- 
+---------------------------------------------------------+
|  Ulrich Leodolter                                       |
|  Brain Research Lab, Department of Psychology           |
|  University of Vienna                                   |
|  Liebiggasse 5                                          |
|  A-1010 Vienna, Austria (Europe)                        |
|  Tel: +43-1-4277-47828                                  |
|  Fax: +43-1-4277-47859                                  |
|  Email: Ulrich.Leodolter@univie.ac.at                   |
|  http://mailbox.univie.ac.at/ulrich.leodolter           |
+---------------------------------------------------------+

