Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319284AbSH2S1s>; Thu, 29 Aug 2002 14:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319290AbSH2S1s>; Thu, 29 Aug 2002 14:27:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24325 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319284AbSH2S1q>; Thu, 29 Aug 2002 14:27:46 -0400
Date: Thu, 29 Aug 2002 11:38:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc. kernel preemption bits
In-Reply-To: <1030635181.978.2559.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0208291136180.2316-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29 Aug 2002, Robert Love wrote:
>
> 	- we have a debug check in preempt_schedule that, even
> 	  on detecting a schedule with irqs disabled, still goes
> 	  ahead and reschedules.  We should return. (me)

I think we should return silently, and simply consider the case of
disabled local interrupts to be equivalent to having preemption disabled.

So I would remove even the warning.

Comments?

		Linus

