Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266539AbRGDID7>; Wed, 4 Jul 2001 04:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266538AbRGDIDu>; Wed, 4 Jul 2001 04:03:50 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:6670 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266539AbRGDIDj>; Wed, 4 Jul 2001 04:03:39 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Why Plan 9 C compilers don't have asm("")
Date: 4 Jul 2001 01:03:13 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9huik1$grm$1@cesium.transmeta.com>
In-Reply-To: <200107040337.XAA00376@smarty.smart.net> <20010703233605.A1244@zalem.puupuu.org> <20010704002436.C1294@ftsoj.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010704002436.C1294@ftsoj.fsmlabs.com>
By author:    Cort Dougan <cort@fsmlabs.com>
In newsgroup: linux.dev.kernel
>
> There isn't such a crippling difference between straight-line and code with
> unconditional branches in it with modern processors.  In fact, there's very
> little measurable difference.
> 
> If you're looking for something to blame hurd performance on I'd suggest
> the entire design of Mach, not inline asm vs procedure calls.  Tossing a
> few context switches into calls is a lot more expensive.
> 

That's not where the bulk of the penalty of a function call comes in
(and it's a call/return, not an unconditional branch.)  The penalty
comes in because of the additional need to obey the calling
convention, and from the icache discontinuity.

Not to mention that certain things simply cannot be done that way.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
