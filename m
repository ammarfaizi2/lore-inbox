Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314474AbSDWWs1>; Tue, 23 Apr 2002 18:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314479AbSDWWs0>; Tue, 23 Apr 2002 18:48:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43177 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S314474AbSDWWsZ>;
	Tue, 23 Apr 2002 18:48:25 -0400
Date: Tue, 23 Apr 2002 22:44:51 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5: MAX_PRIO cleanup
In-Reply-To: <1019601843.1469.257.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0204232241520.8215-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 23 Apr 2002, Robert Love wrote:

> Now that I am working on the configurable maximum RT value patch, I see
> why I did this: we can't hardcode the values like "0 to 99" because that
> 99 is set now via a compile-time define.  Even if it defaults to 100, it
> can be a range of values so the comments should be specific and give the
> exact define.

i'm not so sure whether we want to make the last step to make the maximum
RT priority value to be a .config option. Sure we can keep things flexible
so that it's just a matter of a single redefine, but do we really want
users to be able to change the API of Linux in such a way?

the applications which need 1000 RT threads are i suspect specialized, and
since it needs a kernel recompile anyway, it's not a big problem to change
a single constant in the source code - we do that for many other things.  
I'd very much suggest we keep the 0-99 range for RT tasks, it's been well
established and not making it a .config doesnt make it any harder for 1000
RT priority levels to be defined for specific applications.

	Ingo

