Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269963AbRHSD4g>; Sat, 18 Aug 2001 23:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269962AbRHSD40>; Sat, 18 Aug 2001 23:56:26 -0400
Received: from odyssey.netrox.net ([204.253.4.3]:31390 "EHLO t-rex.netrox.net")
	by vger.kernel.org with ESMTP id <S269960AbRHSD4O>;
	Sat, 18 Aug 2001 23:56:14 -0400
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
From: Robert Love <rml@tech9.net>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel@vger.kernel.org, riel@conectiva.com.br
In-Reply-To: <Pine.LNX.4.30.0108182234250.31188-100000@waste.org>
In-Reply-To: <Pine.LNX.4.30.0108182234250.31188-100000@waste.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.18.07.08 (Preview Release)
Date: 18 Aug 2001 23:56:41 -0400
Message-Id: <998193404.653.12.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Aug 2001 22:36:00 -0500, Oliver Xymoron wrote:
> But your claim is there _is_ entropy. If you think there is, go ahead and
> use it. Via /dev/urandom. Yes, I know it's theoretically not secure, but
> then neither is what you're proposing.

I am only continuing this because I want to explain...

I claim there is entropy from what?  The difference between interrupts
for net devices?  Everyone agrees that there is.  The issues is that an
external attacker could influence the interrupts to the net device, and
thus make some assumptions about the state.  That is why this patch is
configurable.  Do as you please.  As I said, some people want it or need
it.

Again, /dev/urandom is just as "secure" as /dev/random.  Its the same
pool.  The same stuff.  Except that /dev/random blocks when the entropy
count hits 0.

Now, this count is purely theoretical, too.  Its an estime of the amount
of entropy -- lack of determinability -- in the pool of bytes.

Even when it reaches 0, since the pool is still unknown (only previous
output may be known) and the output is hashed, its still pretty much
undeterminable.  But mathematically and theoretically, our entropy
estimate says it is not.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

