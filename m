Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131938AbQKJVjR>; Fri, 10 Nov 2000 16:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131888AbQKJVi5>; Fri, 10 Nov 2000 16:38:57 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:44548 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131849AbQKJViu>; Fri, 10 Nov 2000 16:38:50 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: rdtsc to mili secs?
Date: 10 Nov 2000 13:38:16 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8uhps8$1tm$1@cesium.transmeta.com>
In-Reply-To: <3A078C65.B3C146EC@mira.net> <E13t7ht-0007Kv-00@the-village.bc.nu> <20001110154254.A33@bug.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001110154254.A33@bug.ucw.cz>
By author:    Pavel Machek <pavel@suse.cz>
In newsgroup: linux.dev.kernel
> > 
> > Sensibly configured power saving/speed throttle systems do not change the
> > frequency at all. The duty cycle is changed and this controls the cpu 
> > performance but the tsc is constant
> 
> Do you have an example of notebook that does powersaving like that?
> I have 2 examples of notebooks with changing TSC speed...
> 

Intel PIIX-based systems will do duty-cycle throttling, for example.
However, there are definitely notebooks that will mess with the
frequency.  At Transmeta, we went through some considerable pain to
make sure RDTSC would count walltime even across Longrun transitions.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
