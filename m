Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbQKSWXd>; Sun, 19 Nov 2000 17:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129657AbQKSWXX>; Sun, 19 Nov 2000 17:23:23 -0500
Received: from styx.suse.cz ([195.70.145.226]:55027 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129516AbQKSWXN>;
	Sun, 19 Nov 2000 17:23:13 -0500
Date: Sun, 19 Nov 2000 22:46:23 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rdtsc to mili secs?
Message-ID: <20001119224623.A1418@suse.cz>
In-Reply-To: <3A078C65.B3C146EC@mira.net> <E13t7ht-0007Kv-00@the-village.bc.nu> <20001110154254.A33@bug.ucw.cz> <8uhps8$1tm$1@cesium.transmeta.com> <20001114222240.A1537@bug.ucw.cz> <3A12FA97.ACFF1577@transmeta.com> <20001116115730.A665@suse.cz> <20001118211231.A382@bug.ucw.cz> <20001118231354.A2796@suse.cz> <20001119212404.A1175@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001119212404.A1175@bug.ucw.cz>; from pavel@suse.cz on Sun, Nov 19, 2000 at 09:24:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2000 at 09:24:04PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > Anyway, this should be solvable by checking for clock change in the
> > > > timer interrupt. This way we should be able to detect when the clock
> > > > went weird with a 10 ms accuracy. And compensate for that. It should be
> > > > possible to keep a 'reasonable' clock running even through the clock
> > > > changes, where reasonable means constantly growing and as close to real
> > > > time as 10 ms difference max.
> > > > 
> > > > Yes, this is not perfect, but still keep every program quite happy and
> > > > running.
> > > 
> > > No. Udelay has just gone wrong and your old ISA xxx card just crashed
> > > whole system. Oops.
> > 
> > Yes. But can you do any better than that? Anyway, I wouldn't expect to
> > be able to put my old ISA cards into a recent notebook which fiddles
> > with the CPU speed (or STPCLK ratio).
> 
> PCMCIA is just that: putting old ISA crap into modern hardware. Sorry.

Not really, fortunately. There are ISA-sytle NE2000's on PCMCIA, but
1) You know that you have a card there via the PCMCIA services and
2) They're not the old crappy NE2000's that'd die on a random read anyway.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
