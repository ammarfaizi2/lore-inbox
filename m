Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269358AbTGOTSI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269448AbTGOTSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:18:08 -0400
Received: from chaos.analogic.com ([204.178.40.224]:56708 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269358AbTGOTSC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:18:02 -0400
Date: Tue, 15 Jul 2003 15:35:29 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Tupshin Harper <tupshin@tupshin.com>
cc: Valdis.Kletnieks@vt.edu,
       "Ranga Reddy M - CTD ,Chennai." <rangareddym@ctd.hcltech.com>,
       linux-kernel@vger.kernel.org
Subject: Re: setting year to 2094 casuing Error.
In-Reply-To: <3F144D88.8000401@tupshin.com>
Message-ID: <Pine.LNX.4.53.0307151523530.20747@chaos>
References: <EF836A380096D511AD9000B0D021B5270153C968@narmada.techmas.hcltech.com>
            <3F13A0B7.6050103@tupshin.com> <200307151417.h6FEHkMQ010873@turing-police.cc.vt.edu>
 <3F144D88.8000401@tupshin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003, Tupshin Harper wrote:

> Valdis.Kletnieks@vt.edu wrote:
>
> >On Mon, 14 Jul 2003 23:35:35 PDT, Tupshin Harper said:
> >
> >
> >>Ranga Reddy M - CTD ,Chennai. wrote:
> >>
> >>
> >>>I have set the system time from BIOS to 17/03/2094.After setting this
> >>>,booted with linux O.S.
> >>>
> >>>Now its showing system date as year=1994.I did not get how this happend.
> >>>
> >>>
> >
> >
> >
> >>http://www.howstuffworks.com/question75.htm
> >>
> >>
> >
> >Yes, but if it was a 2038 problem, you'd expect a date in 2094 to roll
> > over to 2026 (as
> >2094 is 56 years past 2038, and 2026 is 56 past 1970).
> >
> >I suspect he has a crippled clock chip that only keeps 2 digits of year.
> >
> >
> Agreed...I didn't do the math to verify that was his only problem, but
> he seemed unaware that there are *any* known problems with dates in the
> future, and the URL i sent was merely designed to point out that such
> dates are unsupported for now.
>
> -Tupshin
>

It's hardly a "crippled" clock chip. It's just the way it was
designed.  Crippled implies that it was previously better.
The year goes from 00 to 99 in BCD (currently) although, if you
muck up everything you can set it to 0 to 255 in binary
but you have to rewrite the BIOS <grin>...

Also, the century byte is in BCD too. That makes the end of
the world as we know it on 9999 some 7,996 years from now.
Before then, the MC146818A chip emulation will be replaced
with a 16,384-bit virtual device so don't worry.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

