Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129469AbRCLKNi>; Mon, 12 Mar 2001 05:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129473AbRCLKN2>; Mon, 12 Mar 2001 05:13:28 -0500
Received: from serifos.unige.ch ([129.194.49.75]:60433 "EHLO serifos.unige.ch")
	by vger.kernel.org with ESMTP id <S129469AbRCLKNV>;
	Mon, 12 Mar 2001 05:13:21 -0500
Date: Mon, 12 Mar 2001 11:11:21 +0100
From: Brunet Eric <Eric.Brunet@physics.unige.ch>
To: linux-kernel@vger.kernel.org
Subject: Bug in 2.2.19pre16 : bad interaction between sound and APM
Message-ID: <20010312111121.A27564@serifos.unige.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

A friend of mine has a toshiba 320CDT laptop, with a redhat 6.1
installed. In order to be able to use the USB port, I have compiled on it
a 2.2.19pre16 kernel. It all works very well except that I cannot get
sound working after the laptop has been in suspend mode.

After a resume from suspend mode, if I try to play a mp4 sample, I only
get some hashed, repetitive and disconnected fragments of the original
tune. In the logs, I get the message

Sound: DMA (output) timed out --- IRQ/DRQ config error ?

The sound subsystem is compiled in the kernel (not as a module). Here is
some relevant part of /proc/sound (copied by hand, so there might be some
typos or omissions)

OSS/Free: 3.8s2++-971130

drivers
Type 42: OPL3SA2
Type 45: OPL3SA2 MSS
Type 43: OPL3SA2 MIDI
Type  1: OPL-2/OPL-3 FM
Type  5: Roland MPU-401
Type 26: MPU-401 (UART)

OPL3SA2        at 0x370 irq 5 drq 1,0
OPL3SA2 MSS    at 0x530       drq 1,0
OPL3SA2 MIDI   at 0x330 irq 9 drq 1
OPL-2/OPL-3 FM at 0x388 irq 9 drq 0

Audio devices:
 0: MS Sound System (CS4321) DUPLEX

apm version is 3.0beta9.

I remember I had some similar problem with sound on this machine with the
previous kernel (standard redhat 6.1 kernel), but I never really paid
attention: as the sound was a module, I could reinitialize everything by
unloading and reloading the module. So it is quite probable that this
problem is an old one which has nothing to do in particular with
2.2.19pre16.

If there is some missing information, or if you want me to try ßomething,
please don't hesitate.  And by the way, is there a way to reinitialize the
sound subsystem when it is not compiled as a module ?


Éric Brunet
