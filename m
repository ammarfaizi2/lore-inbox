Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292764AbSBUUaH>; Thu, 21 Feb 2002 15:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292763AbSBUU35>; Thu, 21 Feb 2002 15:29:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34061 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292760AbSBUU3q>; Thu, 21 Feb 2002 15:29:46 -0500
Date: Thu, 21 Feb 2002 12:29:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: <linux-kernel@vger.kernel.org>, <kpreempt-tech@lists.sourceforge.net>
Subject: Re: [PATCH] 2.5: conditional schedules with a preemptive kernel
In-Reply-To: <1014254791.18361.172.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0202211227260.18900-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20 Feb 2002, Robert Love wrote:
> 
> With a preemptive kernel, explicit conditional schedules when
> preempt_count is zero are a waste of cycles and code size.

Hmm.. Are there any other kind?

Another way of saying this: how can a conditional schedule _ever_ be 
nothing but a waste of cycles and code size with preemption enabled?

If the reason is the BKL, then I would much prefer those paths to be 
BKL-fixed, than have two different conditional schedules.

In short, I'd rather get a patch that just unconditionally makes the 
conditional schedules no-ops with preemption enabled. That would seem to 
make a lot more sense.

		Linus

