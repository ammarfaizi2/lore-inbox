Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbTIGClS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 22:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263294AbTIGClS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 22:41:18 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:15802 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263288AbTIGClQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 22:41:16 -0400
Date: Sat, 06 Sep 2003 19:40:14 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: John Yau <jyau_kernel_dev@hotmail.com>, "'Robert Love'" <rml@tech9.net>
cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Message-ID: <149150000.1062902395@[10.10.2.4]>
In-Reply-To: <000201c374c8$1124ee20$f40a0a0a@Aria>
References: <000201c374c8$1124ee20$f40a0a0a@Aria>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The rationale behind Ingo's patch is to "break up" the timeslices to give
> better scheduling latency to 
>> multiple tasks at the same priority. 
>> So it is not "unnecessary context switches," just "extra context switches."
> 
> Hmm...my reasoning is that those switches are unnecessary because the
> interactivity bonus/penalty will take care of breaking the timeslices up in
> case of a CPU hog, albeit not at precise 25 ms granularity.  Though having
> regularity in scheduling is nice, I think Ingo's patch somewhat negates the
> purpose of having heterogenous time slice lengths.  I suspect Ingo's
> approach will thrash the caches quite a bit more than mine; we should
> definitely test this a bit to find out for sure.  Any suggestions on how to
> go about that?
> 
> If we're going to do a context switch every 25 ms no matter what, we might
> as well just make the scheduler a true real time scheduler, dump having
> different time slice lengths and interactivity recalculations, and go
> completely round robin with strictly enforced priorities and a single class
> of time slice somewhere 1 to 5 ms long.

IIRC, that context switching was what sucked on cpu bound jobs (like
doing a kernel compile). If you can send me both patches (offline), 
I'll do a straight comparison on the benchmarking rig I have set up 
on Monday.

M.

