Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274778AbRIUSqs>; Fri, 21 Sep 2001 14:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274780AbRIUSqj>; Fri, 21 Sep 2001 14:46:39 -0400
Received: from mail.scs.ch ([212.254.229.5]:31506 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S274778AbRIUSqX>;
	Fri, 21 Sep 2001 14:46:23 -0400
Message-ID: <3BAB8B11.7ED581DB@scs.ch>
Date: Fri, 21 Sep 2001 20:46:41 +0200
From: Thomas Sailer <sailer@scs.ch>
Reply-To: t.sailer@alumni.ethz.ch
Organization: SCS
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.3-13jnx i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jussi Laako <jussi.laako@kolumbus.fi>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
In-Reply-To: <E15kEjB-0006n9-00@the-village.bc.nu> <3BAB69CF.A3F9D217@kolumbus.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jussi Laako schrieb:
> 
> Alan Cox wrote:
> >
> > Sound cards have a lot of buffering, we are talking 64-128Kbytes + on
> > card buffers. Thats 0.25-0.5 seconds at 48Khz 16bit stereo
> 
> Only "soundcards", that cheap crap like SoundBlaster. Professional
> lowlatency soundcards usually have something like 128-512 samples per
> channel for 24-bit (32-bit data) 96 kHz 8 channels...

This doesn't make sense. Even professional soundcards provide hundreds
of kBytes of buffer space. And even with most cheap PCI cards you
need not wait until the whole buffer is full before start reading
samples. Even with those soundcards the latency is mostly caused
by the digital filters in the codec.

Tom
