Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274685AbRIVKaw>; Sat, 22 Sep 2001 06:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274717AbRIVKam>; Sat, 22 Sep 2001 06:30:42 -0400
Received: from a82d11hel.dial.kolumbus.fi ([212.54.29.82]:59456 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S274685AbRIVKai>; Sat, 22 Sep 2001 06:30:38 -0400
Message-ID: <3BAC6860.C37ECDB7@kolumbus.fi>
Date: Sat, 22 Sep 2001 13:30:56 +0300
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: t.sailer@alumni.ethz.ch
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
In-Reply-To: <E15kEjB-0006n9-00@the-village.bc.nu> <3BAB69CF.A3F9D217@kolumbus.fi> <3BAB8B11.7ED581DB@scs.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Sailer wrote:
> 
> > lowlatency soundcards usually have something like 128-512 samples per
> > channel for 24-bit (32-bit data) 96 kHz 8 channels...

> This doesn't make sense. Even professional soundcards provide hundreds
> of kBytes of buffer space. And even with most cheap PCI cards you
> need not wait until the whole buffer is full before start reading
> samples. Even with those soundcards the latency is mostly caused
> by the digital filters in the codec.

RME Digi 96/8 Pro has 128 kB buffer. This means 2048 samples per channel for
8 channel full-duplex operation which is 21.3 ms for 96 kHz. If interrupt is
generated at 50% buffer fill then the time between interrupts is 10.7 ms.
(1)

ICEnsemble ICE1712 chip can use max 256 kB for record and playback so it's
maximum latency is 56.9 ms for 96 kHz and 28.4 ms between interrupts. (2)

As a side note, from ICE's Windows control panel I can select 2-28 ms for
DMA buffer size.

Those times are maximum, usually lower values are used. I use 10 ms buffer
under Windows.


 - Jussi Laako


In-Reply-To:

	1) RME Digi96 series datasheet
	2) ICEnsemble ICE1712 datasheet

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
