Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271873AbRHUVxj>; Tue, 21 Aug 2001 17:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271871AbRHUVx2>; Tue, 21 Aug 2001 17:53:28 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:56096 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271870AbRHUVxP>; Tue, 21 Aug 2001 17:53:15 -0400
Subject: Re: Entropy from net devices - keyboard & IDE just as 'bad' [was
	Re: [PATCH] let Net Devices feed Entropy, updated (1/2)]
From: Robert Love <rml@tech9.net>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9lu9dj$n5v$7@abraham.cs.berkeley.edu>
In-Reply-To: <606175155.998387452@[169.254.45.213]>
	<Pine.LNX.4.33.0108210042520.32719-100000@dlang.diginsite.com> 
	<9lu9dj$n5v$7@abraham.cs.berkeley.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.20.07.08 (Preview Release)
Date: 21 Aug 2001 17:53:34 -0400
Message-Id: <998430815.3120.39.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-08-21 at 14:31, David Wagner wrote:
> David Lang  wrote:
> >so as I see this discussion it goes something like this.
> >
> >1. the entropy pool is not large enough on headless machines.
> >2. you don't want to use urandom as there are theoretical attacks against
> >it
> 
> If that's the concern, then I'm glad to say that I have very reassuring
> news for you.  No attacks are known on /dev/urandom, not even theoretical
> ones.

This is because there are no known attacks are SHA-1.

> (And no attack is known on SHA-1, not even a theoretical one.)

Right.

> (Don't confuse a remote risk that someone might discover a theoretical
> attack on SHA-1 with knowledge that we already know of a theoretical
> attack on SHA-1.)

Responding to David Lang, #1 is correct.  On a headless or diskless
machine, the entropy pool can be very small.  Net devices provide the
needed entropy.

Thus, since _you_ trust SHA-1, if you also feel the bits garnered from
your network interfaces is entropic, then the patch is useful for you.

If you don't, then don't enable it.  But, since you trust SHA-1,
/dev/random is of no difference to you than /dev/urandom, so its no
difference :)

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

