Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136619AbREGTCv>; Mon, 7 May 2001 15:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136618AbREGTCo>; Mon, 7 May 2001 15:02:44 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:55564 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136614AbREGTCU>; Mon, 7 May 2001 15:02:20 -0400
Message-ID: <3AF6F11E.3A03050E@transmeta.com>
Date: Mon, 07 May 2001 12:01:50 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Wow! Is memory ever cheap!
In-Reply-To: <20010505095802.X12431@work.bitmover.com> <20010506142043.B31269@metastasis.f00f.org> <20010505194536.D14127@work.bitmover.com> <9d6qk6$i86$1@cesium.transmeta.com> <20010507115659.T14127@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> > >
> > > On the other hand, if your apps don't have built in integrity checks then
> > > ECC is pretty much a requirement.
> >
> > Isn't this pretty much saying "if you're willing to dedicate your
> > system to running nothing but Bitkeeper, you can run it really fast?"
> 
> A) Fast has nothing to do with it, ECC runs at the same speed as non-ECC;

"It" meaning BitKeeper.

> B) As I said above, "if your apps don't have built in integrity checks then
>    ECC is pretty much a requirement";
> C) As I said above, we use our systems for BK development, so this choice
>    makes sense for us.
> 
> I think the point you are really missing is that it is not an either/or
> choice.  All you really need in practice is one application which is
> both heavily used and has integrity checks.  It could be BitKeeper or
> something else, all that matters is that it will detect memory problems.

This is not true in my experience.  YES, it will detect bad memory
configurations, but with over 2^34 memory cells to worry about -- each of
them carrying a charge of a few dozen electrons only -- you WILL have
random failures, especially if the memory is allowed to remain stale for
extended periods of time, as is very likely in a configuration like this
(think disk cache.)

Bad memory configurations is bad.  However, good memory configurations
are not necessarily perfect.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
