Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267635AbUBTBXy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUBTBVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 20:21:25 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:7579 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267619AbUBTBUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 20:20:45 -0500
Message-Id: <200402200117.i1K1H8i06599@owlet.beaverton.ibm.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Andrew Morton <akpm@osdl.org>, LSE <lse-tech@lists.sourceforge.net>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Anton Blanchard <anton@samba.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.3-rc3-mm1: sched-group-power 
In-reply-to: Your message of "Thu, 19 Feb 2004 20:24:26 +1100."
             <403480CA.7050804@cyberone.com.au> 
Date: Thu, 19 Feb 2004 17:17:08 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick, I'm not sure what capability this patch adds .. perhaps some words
of explanation.

So we have SMT/HT situations where we'd prefer to balance across cores;
that is, if 0, 1, 2, and 3 share a core and 4, 5, 6, and 7 share a core,
you'd like two processes to arrange themselves so one is on [0123] and
another is on [4567].  This is what the SD_IDLE flag indicated before.

With this patch, we can "weight" the load imposed by certain cpus, right?
What advantage does this give us?  On a given machine, won't the "weight"
of any one set of SMT siblings and cores be uniform with respect to all
the cores and siblings anyway?

Rick
