Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266550AbUH0Qii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266550AbUH0Qii (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266553AbUH0Qii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:38:38 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:26778 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266550AbUH0Qif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:38:35 -0400
Subject: Re: [0/2][ANNOUNCE] nproc: netlink access to /proc information
From: Albert Cahalan <albert@users.sf.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Roger Luethi <rl@hellgate.ch>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <20040827162308.GP2793@holomorphy.com>
References: <20040827122412.GA20052@k3.hellgate.ch>
	 <20040827162308.GP2793@holomorphy.com>
Content-Type: text/plain
Organization: 
Message-Id: <1093624660.431.6128.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Aug 2004 12:37:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-27 at 12:23, William Lee Irwin III wrote:

> I see no evidence that this will be a speedup with large numbers of
> processes, as the problematic algorithms are preserved wholesale.

Well, as far as THAT goes, I thought your tree-based
lookup was nice. I assume you still have the code.

What we got instead was a sort of cached directory
offset computation, which looks great... until you
hit the bad case. I suggest that the people trying to
reduce latency should try "top -d 0 -b >> /dev/null"
while running something like the SDET benchmark.


