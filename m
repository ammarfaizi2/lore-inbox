Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293088AbSCRWBQ>; Mon, 18 Mar 2002 17:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293089AbSCRWBG>; Mon, 18 Mar 2002 17:01:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33295 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293082AbSCRWAy>; Mon, 18 Mar 2002 17:00:54 -0500
Date: Mon, 18 Mar 2002 14:00:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Cort Dougan <cort@fsmlabs.com>
cc: Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 7.52 second kernel compile
In-Reply-To: <20020318143431.E4783@host110.fsmlabs.com>
Message-ID: <Pine.LNX.4.33.0203181357160.1457-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Mar 2002, Cort Dougan wrote:
>
> } But the whole point of _scattering_ is so incredibly broken in itself!
> } Don't do it.
>
> Yes, that is indeed correct theoretically.  The problem is that we actually
> measured it and there was very little locality.  When I added some
> multiple-tlb loads it actually decreased wall-clock performance for nearly
> every user load I put on the machine.

This is what I meant by hardware support for multiple loads - you mustn't
let speculative TLB loads displace real TLB entries, for example.

> Linus, I knew that deep in my heart 8 years ago when I started in on all
> this.  I'm with you but I'm not good enough with a soldering iron to fix
> every powerpc out there that forces that crappy IBM spawned madness upon
> us.

Oh, I agree, we can't fix existing broken hardware, we'll ave to just live
with it.

		Linus

