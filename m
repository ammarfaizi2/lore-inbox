Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131670AbRCOKd2>; Thu, 15 Mar 2001 05:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRCOKdT>; Thu, 15 Mar 2001 05:33:19 -0500
Received: from nef.ens.fr ([129.199.96.32]:59913 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S131668AbRCOKdI>;
	Thu, 15 Mar 2001 05:33:08 -0500
Date: Thu, 15 Mar 2001 11:32:22 +0100
From: Éric Brunet <ebrunet@quatramaran.ens.fr>
Message-Id: <200103151032.LAA12725@quatramaran.ens.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Bug in 2.2.19pre16 : bad interaction between sound and APM
In-Reply-To: <20010312111121.A27564@serifos.unige.ch>
In-Reply-To: <20010312111121.A27564@serifos.unige.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In ens.mailing-lists.linux-kernel, I wrote:
>A friend of mine has a toshiba 320CDT laptop, with a redhat 6.1
>installed. In order to be able to use the USB port, I have compiled on it
>a 2.2.19pre16 kernel. It all works very well except that I cannot get
>sound working after the laptop has been in suspend mode.
>
Nobody can help me to understand where this bug comes from and how I
could fix it or get around it ? (For instance by reinitializing the sound
subsystem, knowing that it is not a module but built inside the kernel.)

Thank you very much by advance

Éric Brunet




End of original message:
>After a resume from suspend mode, if I try to play a mp3 sample, I only
>get some hashed, repetitive and disconnected fragments of the original
>tune. In the logs, I get the message
>
>Sound: DMA (output) timed out --- IRQ/DRQ config error ?
>
>The sound subsystem is compiled in the kernel (not as a module). Here is
>some relevant part of /proc/sound (copied by hand, so there might be some
>typos or omissions)
>
>OSS/Free: 3.8s2++-971130
>
>drivers
>Type 42: OPL3SA2
>Type 45: OPL3SA2 MSS
>Type 43: OPL3SA2 MIDI
>Type  1: OPL-2/OPL-3 FM
>Type  5: Roland MPU-401
>Type 26: MPU-401 (UART)
>
>OPL3SA2        at 0x370 irq 5 drq 1,0
>OPL3SA2 MSS    at 0x530       drq 1,0
>OPL3SA2 MIDI   at 0x330 irq 9 drq 1
>OPL-2/OPL-3 FM at 0x388 irq 9 drq 0
>
>Audio devices:
> 0: MS Sound System (CS4321) DUPLEX
>
>apm version is 3.0beta9.
>
>I remember I had some similar problem with sound on this machine with the
>previous kernel (standard redhat 6.1 kernel), but I never really paid
>attention: as the sound was a module, I could reinitialize everything by
>unloading and reloading the module. So it is quite probable that this
>problem is an old one which has nothing to do in particular with
>2.2.19pre16.
>
>If there is some missing information, or if you want me to try something,
>please don't hesitate.  And by the way, is there a way to reinitialize the
>sound subsystem when it is not compiled as a module ?
