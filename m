Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131705AbQKRWok>; Sat, 18 Nov 2000 17:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131900AbQKRWob>; Sat, 18 Nov 2000 17:44:31 -0500
Received: from olsinka.site.cas.cz ([147.231.11.16]:37771 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S131705AbQKRWoX>;
	Sat, 18 Nov 2000 17:44:23 -0500
Date: Sat, 18 Nov 2000 23:13:54 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: rdtsc to mili secs?
Message-ID: <20001118231354.A2796@suse.cz>
In-Reply-To: <3A078C65.B3C146EC@mira.net> <E13t7ht-0007Kv-00@the-village.bc.nu> <20001110154254.A33@bug.ucw.cz> <8uhps8$1tm$1@cesium.transmeta.com> <20001114222240.A1537@bug.ucw.cz> <3A12FA97.ACFF1577@transmeta.com> <20001116115730.A665@suse.cz> <20001118211231.A382@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001118211231.A382@bug.ucw.cz>; from pavel@suse.cz on Sat, Nov 18, 2000 at 09:12:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2000 at 09:12:31PM +0100, Pavel Machek wrote:

> > Anyway, this should be solvable by checking for clock change in the
> > timer interrupt. This way we should be able to detect when the clock
> > went weird with a 10 ms accuracy. And compensate for that. It should be
> > possible to keep a 'reasonable' clock running even through the clock
> > changes, where reasonable means constantly growing and as close to real
> > time as 10 ms difference max.
> > 
> > Yes, this is not perfect, but still keep every program quite happy and
> > running.
> 
> No. Udelay has just gone wrong and your old ISA xxx card just crashed
> whole system. Oops.

Yes. But can you do any better than that? Anyway, I wouldn't expect to
be able to put my old ISA cards into a recent notebook which fiddles
with the CPU speed (or STPCLK ratio).

> BTW I mailed patch to do exactly that kind of autodetection to the
> list some time ago. (I just can't find it now :-( -- search archives
> for 'TSC is slower than it should be'.

If I recall correctly, that patch didn't create a 'reasonable clock' -
it wasn't growing all the time and could skip back sometimes.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
