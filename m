Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130256AbQKKIaf>; Sat, 11 Nov 2000 03:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130245AbQKKIa0>; Sat, 11 Nov 2000 03:30:26 -0500
Received: from linus.st-and.ac.uk ([138.251.32.11]:35483 "EHLO
	linus.st-andrews.ac.uk") by vger.kernel.org with ESMTP
	id <S130232AbQKKIaS>; Sat, 11 Nov 2000 03:30:18 -0500
Date: Sat, 11 Nov 2000 08:26:07 GMT
Message-Id: <200011110826.IAA01091@hindleyhome.st-andrews.ac.uk>
From: Mark Hindley <mh15@st-andrews.ac.uk>
To: linux-sound@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: opl3 under 2.4.0-test10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to setup my ALS 110 soundcard under my build of kernel
2.4.0-test10.

I have built in isapnp support and also the sb and opl3 drivers. 

The sb driver works fine other than complaining about a missing 16 bit
DMA (which I understand is missing from the card anyway). I can play
and record wav with no problems. I am still missing MIDI.

However, even though I pass opl3=0x388 on the Kernel command line all
I get is an isapnp panic.

Am I doing something silly or is there a bug? Is it a sound driver or
isapnp or kernel problem?

While trying to locate the problem I could not get any response from
/dev/sndstat.

% cat /dev/sndstat
cat: /dev/sndstat: No such device

Is it not supported in 2.4.0? I can't find the same info in the /proc filesystem.


The full dmesg extract that seems relevant is 

Linux version 2.4.0-test10 (root@HindleyHome) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #26 Fri Nov 3 18:08:00 GMT 2000

YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft 1993-1996
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: PnP Sound Chip detected
sb: ALS110 isapnp panic: opl3 device not found
sb: ISAPnP reports 'PnP Sound Chip' at i/o 0x220, irq 5, dma 3, 1
SB16: Bad or missing 16 bit DMA channel
<Sound Blaster 16 (ALS-100) (4.02)> at 0x220 irq 5 dma 3,1
sb: 1 Soundblaster PnP card(s) found.

Thanks for the help


Mark



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
