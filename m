Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129049AbQKCVZZ>; Fri, 3 Nov 2000 16:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131828AbQKCVZP>; Fri, 3 Nov 2000 16:25:15 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2312 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129049AbQKCVZE>; Fri, 3 Nov 2000 16:25:04 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a user-land  programmer...
Date: 3 Nov 2000 13:24:10 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8tvadq$l1e$1@cesium.transmeta.com>
In-Reply-To: <m3y9z0g7wp.fsf@otr.mynet.cygnus.com> <200011031951.WAA10871@ms2.inr.ac.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <200011031951.WAA10871@ms2.inr.ac.ru>
By author:    kuznet@ms2.inr.ac.ru
In newsgroup: linux.dev.kernel
>
> Hello!
> 
> > > Can we _PLEASE_PLEASE_PLEASE_ not do this anymore and have the kernel do
> > > what BSD does:  re-start the interrupted call?
> > 
> > This is crap.  Returning EINTR is necessary for many applications.
> 
> Just reminder: this "crap" is default behaviour of Linux nowadays. 8)8)
> 

signal() is crap... I personally think it was a major lose to have
signal() change to BSD behaviour by default (an unexpected change for
most applications!!)

For sigaction() you must choose behaviour explicitly anyway, by either
specifying or not specifying SA_RESTART.

Applications should use sigaction().  Period.  Full stop.  signal() is
so unpredictable these days as to be practically unusable.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
