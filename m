Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290813AbSARUeH>; Fri, 18 Jan 2002 15:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290811AbSARUd6>; Fri, 18 Jan 2002 15:33:58 -0500
Received: from [208.29.163.248] ([208.29.163.248]:16322 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S290813AbSARUds>; Fri, 18 Jan 2002 15:33:48 -0500
Date: Fri, 18 Jan 2002 12:33:34 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Tulip driver bug in 2.4.17 (fwd)
In-Reply-To: <3C48774E.2020708@candelatech.com>
Message-ID: <Pine.LNX.4.40.0201181224320.27656-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Ben Greear wrote:

> David Lang wrote:
>
>
> > for me the same machine is rock solid with 2.4.5/8 (driver 0.9.14) but
> > fails with 2.4.14/17 (driver 0.9.15-pre9)
>
>
> Can you check if your 2.4.5/8 driver actually does 100bt-FD autonegotiation
> correctly?  I believe it was broken during that time, and fixed in 2.4.9.
> It's possible that that may have something to do with the problem, but
> it's a stretch...

I have been seeing some errors that could be autonegotiation failing, they
haven't been enough for me to ge the time to track them down (and I was
putting them down to cisco switch config issues anyway) I'll have to
double check.

correction on version numbers.

2.4.5-pre1 worked, 2.4.5 has driver 0.9-15-pre2 and fails, I guess I
hadn't tested properly with 2.4.8, compiling now with drivers/net from
2.4.4.

when it locks up the reset works immediatly, power takes a few seconds to
shutdown.

> It might also be interesting to see if the working driver still works
> if you forward port it into 2.4.17....
>
> Ben
>
>
> >
> > the failure is not at all traffic related, I have these boxes in
> > production (only useing 3 of the 4 ports) with no problems at all, but on
> > a box not connected to any network I can lock it up by just issuing an
> > ifconfig.
> >
> > it's possible that it's a PCI problem (if so can we back off the timing to
> > what worked?), but I would expect the problem to be more variable if that
> > was the case.
> >
> > David Lang
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
>
>
> --
> Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
> President of Candela Technologies Inc      http://www.candelatech.com
> ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
>
>
