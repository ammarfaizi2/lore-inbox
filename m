Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbTEHFdv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 01:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbTEHFdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 01:33:51 -0400
Received: from franka.aracnet.com ([216.99.193.44]:13528 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261177AbTEHFdu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 01:33:50 -0400
Date: Wed, 07 May 2003 20:32:04 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: garbled oopsen
Message-ID: <23400000.1052364724@[10.10.2.4]>
In-Reply-To: <m34r46dufb.fsf@averell.firstfloor.org>
References: <20030508011013$3d80@gated-at.bofh.it><20030508015008$481c@gated-at.bofh.it> <m34r46dufb.fsf@averell.firstfloor.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Can these be cleaned up in any reasonable way?
>> 
>> It needs some additional spinlock in there.  People have moaned for over a
>> year, patches have been floating about but nobody has taken the time to
>> finish one off and submit it.
> 
> I considered it for x86-64 and even implemented it, but never submitted
> in fear of deadlocks e.g. when an oops recurses. For this a 
> spinlock_timeout() would be useful. Print anyways when you cannot get the
> lock in a second or two.

The trouble is that the subsystems you want may be broken (eg timers).
IMHO it's better to just spew whatever you can (the current crap) ... 
wait a couple of seconds, then have another go at doing it properly.

That way people can't complain it's worse than it is now in any way ;-)

M.

