Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315816AbSEECKN>; Sat, 4 May 2002 22:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315814AbSEECKM>; Sat, 4 May 2002 22:10:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1545 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315815AbSEECKL>; Sat, 4 May 2002 22:10:11 -0400
Date: Sat, 4 May 2002 19:09:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Andi Kleen <ak@muc.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.13 IDE and preemptible kernel problems
In-Reply-To: <3CD47BA7.9080006@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0205041903480.1594-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 May 2002, Martin Dalecki wrote:
>
> OK, lest's make a deal you do the following and - realize
> immediately that there is a need for single argument
> time_past() or whatever and I turn spinlock debugging on :-).

Hmm.. Something like

	#define timeout_expired(x)	time_after(jiffies, (x))

migth indeed make sense.

But I'm a lazy bastard. Is there some victim^H^H^H^H^H^Hhero who would
want to do the 'sed s/time_after(jiffies,/timeout_expired(/g' and verify
that it does the right thing and send it to me as a patch?

The thing is, I wonder if it should be "time_after(jiffies,x)" or
"time_after_eq(jiffies,x)". There's a single-tick difference there..

		Linus

