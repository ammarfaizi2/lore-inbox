Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUDPAAu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 20:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUDPAAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 20:00:49 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:31113 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261891AbUDPAAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 20:00:46 -0400
Subject: Re: PAT support
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: ebiederm@xmission.com, ak@muc.de, tripperda@nvidia.com
Content-Type: text/plain
Organization: 
Message-Id: <1082065120.850.32.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 15 Apr 2004 17:38:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman writes:
> Andi Kleen <ak@muc.de> writes:

>> Yes agreed. I already had vendors complaining about this.
>> But for this it will need some more work - the MTRRs need to be fully
>> converted to PAT and then disabled (because MTRRs have 
>> higher priority than PAT). Doing so is a lot more risky than 
>> what Terrence's patch does currently though.  But longer term
>> we will need it.
>
> Ugh.  You are right.  The processors look at the two types and pick
> the one that caches the least.  So PAT can't enable caching :(

There's more to it than this. You need to use both
the MTRRs and PAT for best performance. I can't find
the explanation in my AMD manual, so maybe this is
an Intel-only thing. From (human) memory:

Use the PAT stuff as your primary cache-control
mechanism. Then, to the extent that you can, use
the MTRRs to double-mark some of the uncached or
uncachable memory. This avoids some sort of
useless bus traffic or TLB goings-on.

Sorry I can't be clearer; check the Intel books.



