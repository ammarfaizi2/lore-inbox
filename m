Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131956AbQKJXAj>; Fri, 10 Nov 2000 18:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131982AbQKJXA2>; Fri, 10 Nov 2000 18:00:28 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13320 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131956AbQKJXAS>; Fri, 10 Nov 2000 18:00:18 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: rdtsc to mili secs?
Date: 10 Nov 2000 15:00:08 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8uhulo$bcd$1@cesium.transmeta.com>
In-Reply-To: <8uhps8$1tm$1@cesium.transmeta.com> <200011102223.XAA04330@cave.bitwizard.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200011102223.XAA04330@cave.bitwizard.nl>
By author:    R.E.Wolff@BitWizard.nl (Rogier Wolff)
In newsgroup: linux.dev.kernel
> > 
> > Intel PIIX-based systems will do duty-cycle throttling, for example.
> 
> What's this "duty cycle throtteling"? Some people seem to think this
> refers to changing the duty cycle on the clock, and thereby saving
> power. I think it doesn't save any power if you do it that way. You
> are referring to the duty cycle on a "stpclk" signal, right?
> 

Yes.  The clock to the CPU isn't actually halted, but the STPCLK input
is pulsed, usually at 4 kHz, with some specific duty cycle.

It saves power roughly linearly with the duty cycle, minus some
overhead.  It tends to be used mostly for thermal protection; if all
you have is duty cycle throttling (or frequency change without
corresponding voltage change), you're usually better off getting
things done as soon as possible and then go into deep sleep instead.
However, if you are about to emit smoke, you don't really have a whole
lot of options.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
