Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264545AbTIDCif (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbTIDCg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:36:29 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:21941 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S264521AbTIDCgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:36:16 -0400
Date: Wed, 03 Sep 2003 19:35:23 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Daniel Phillips <phillips@arcor.de>, Larry McVoy <lm@bitmover.com>
cc: Nick Piggin <piggin@cyberone.com.au>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <8700000.1062642922@[10.10.2.4]>
In-Reply-To: <200309040421.16939.phillips@arcor.de>
References: <20030903040327.GA10257@work.bitmover.com> <31190000.1062604245@[10.10.2.4]> <20030904004943.GB5227@work.bitmover.com> <200309040421.16939.phillips@arcor.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thursday 04 September 2003 02:49, Larry McVoy wrote:
>> It's much better to have a bunch of OS's and pull
>> them together than have one and try and pry it apart.
> 
> This is bogus.  The numbers clearly don't work if the ccCluster is made of 
> uniprocessors, so obviously the SMP locking has to be implemented anyway, to 
> get each node up to the size just below the supposed knee in the scaling 
> curve.  This eliminates the argument about saving complexity and/or work.
> 
> The way Linux scales now, the locking stays out of the range where SSI could 
> compete up to, what?  128 processors?  More?  Maybe we'd better ask SGI about 
> that, but we already know what the answer is for 32: boring old SMP wins 
> hands down.  Where is the machine that has the knee in the wrong part of the 
> curve?  Oh, maybe we should all just stop whatever work we're doing and wait 
> ten years for one to show up.
> 
> But far be it from me to suggest that reality should intefere with your fun.

Yes you need locking, but only for the bits where you glue stuff back
together. Plenty of bits can operate indepandantly per node, or at
least ... I'm hoping they can in my vapourware world ;-)

M.

