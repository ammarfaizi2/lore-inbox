Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTEHUsU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 16:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbTEHUsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 16:48:20 -0400
Received: from intranet.resilience.com ([12.36.124.2]:32414 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id S262069AbTEHUsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 16:48:19 -0400
Mime-Version: 1.0
Message-Id: <p05210612bae074d9a621@[207.213.214.37]>
In-Reply-To: <3EBAAA8B.4060001@techsource.com>
References: <200305081009_MC3-1-37FA-2407@compuserve.com>
 <p0521060abae04b745ea6@[207.213.214.37]> <3EBAAA8B.4060001@techsource.com>
Date: Thu, 8 May 2003 14:00:38 -0700
To: Timothy Miller <miller@techsource.com>
From: Jonathan Lundell <jlundell@lundell-bros.com>
Subject: Re: top stack (l)users for 2.5.69
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:05pm -0400 5/8/03, Timothy Miller wrote:
>My suggestion would be that if we do manage to get typical stack 
>usage down to the point where we can go to a 4K stack, then 
>interrupt handlers would have to be rewritten to recognize whether 
>or not the interrupt arrived on a user process kernel stack and then 
>move the context over to the "interrupt stack".  The overhead would 
>be low enough that it's worth doing so that we could reduce process 
>kernel stack size.  Whenever an interrupt service routine is itself 
>interrupted, the interrupt stack check code would realize that it is 
>already using the interrupt stack and not move the context.  Here, 
>then, we would need only one single interrupt stack which we would 
>size for worst case; so if we made it 8 or 12K, that's 8 or 12K once 
>for each CPU which is allowed to receive interrupts, not once per 
>process.
>
>You like?  :)

It makes sense to me. But this thread has gone in a circle, I think.

At 9:20am -0700 5/7/03, Martin J. Bligh wrote:
>There are patches to make i386 do this (and use 4K stacks as a config option)
>from Dave Hansen and Ben LaHaise in 2.5-mjb tree.

(the message context was a separate interrupt stack)
-- 
/Jonathan Lundell.
