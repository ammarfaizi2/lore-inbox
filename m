Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131441AbQKPXkH>; Thu, 16 Nov 2000 18:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131507AbQKPXjr>; Thu, 16 Nov 2000 18:39:47 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:51213 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131441AbQKPXjo>; Thu, 16 Nov 2000 18:39:44 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: rdtsc to mili secs?
Date: 16 Nov 2000 15:09:39 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8v1pfj$p5e$1@cesium.transmeta.com>
In-Reply-To: <3A078C65.B3C146EC@mira.net> <20001114222240.A1537@bug.ucw.cz> <3A12FA97.ACFF1577@transmeta.com> <20001116115730.A665@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001116115730.A665@suse.cz>
By author:    Vojtech Pavlik <vojtech@suse.cz>
In newsgroup: linux.dev.kernel
> 
> Anyway, this should be solvable by checking for clock change in the
> timer interrupt. This way we should be able to detect when the clock
> went weird with a 10 ms accuracy. And compensate for that. It should be
> possible to keep a 'reasonable' clock running even through the clock
> changes, where reasonable means constantly growing and as close to real
> time as 10 ms difference max.
> 

Actually, on machines where RDTSC works correctly, you'd like to use
that to detect a lost timer interrupt.

It's tough, it really is :(

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
