Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289012AbSAIUce>; Wed, 9 Jan 2002 15:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289014AbSAIUcZ>; Wed, 9 Jan 2002 15:32:25 -0500
Received: from nile.gnat.com ([205.232.38.5]:17293 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S289012AbSAIUcN>;
	Wed, 9 Jan 2002 15:32:13 -0500
From: dewar@gnat.com
To: mrs@windriver.com, pkoning@equallogic.com
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org
Message-Id: <20020109203213.56A64F2FEB@nile.gnat.com>
Date: Wed,  9 Jan 2002 15:32:13 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<Ah... so (paraphrasing) -- if you have two byte size volatile objects,
and they happen to end up adjacent in memory, the compiler is
explicitly forbidden from turning an access to one of them into a
wider access -- because that would be an access to both of them, which
is a *different* side effect.  (Certainly that exactly matches the
hardware-centric view of why "volatile" exists.)  And the compiler
isn't allowed to change side effects, including causing them when the
source code didn't ask you to cause them.
>>

Right, and as you see that is covered by the language on external effects
in the Ada standard (remember the intent in Ada was to exactly match the
C rules :-)

But one thing in the Ada world that we consider left open is whether a
compiler is free to combine two volatile loads into a single load. Probably
the answer should be no, but the language at least in the Ada standard does
not seem strong enough to say this.
