Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263243AbTDWJA0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 05:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbTDWJA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 05:00:26 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:53991 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263243AbTDWJAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 05:00:25 -0400
Date: Wed, 23 Apr 2003 05:12:29 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] HT scheduler, sched-2.5.68-A9
In-Reply-To: <1490710000.1051055323@flay>
Message-ID: <Pine.LNX.4.44.0304230510480.11873-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Apr 2003, Martin J. Bligh wrote:

> Hmmm. When the machine is loaded up fully, this seems OK, but for lower
> loads, it seems to have a significant degredation. This is on my normal
> 16-way machine, no HT at all ... just checking for degredations. At a
> guess, maybe it's bouncing stuff around between runqueues under low
> loads?

hm - it should not cause any change in the non-HT case. Oh, there's one
thing that could make a difference on SMP - could you change
AGRESSIVE_IDLE_STEAL back to 0?

> Are there things embedded in here that change stuff for non-HT machines?

not intentionally, but apparently there's some sort of effect. The idle
steal thing could explain it.

	Ingo

