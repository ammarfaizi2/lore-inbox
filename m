Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVDEGxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVDEGxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 02:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVDEGxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 02:53:17 -0400
Received: from one.firstfloor.org ([213.235.205.2]:65477 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261586AbVDEGxI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 02:53:08 -0400
To: Paul Jackson <pj@engr.sgi.com>
Cc: kenneth.w.chen@intel.com, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
	<20050402145351.GA11601@elte.hu>
	<20050402215332.79ff56cc.pj@engr.sgi.com>
	<20050403070415.GA18893@elte.hu>
	<20050403043420.212290a8.pj@engr.sgi.com>
	<20050403071227.666ac33d.pj@engr.sgi.com>
	<20050403150102.GA25442@elte.hu>
	<20050403153056.0ad6ee8e.pj@engr.sgi.com>
From: Andi Kleen <ak@muc.de>
Date: Tue, 05 Apr 2005 08:53:04 +0200
In-Reply-To: <20050403153056.0ad6ee8e.pj@engr.sgi.com> (Paul Jackson's
 message of "Sun, 3 Apr 2005 15:30:56 -0700")
Message-ID: <m1d5t91zqn.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@engr.sgi.com> writes:
>
> We already expose the SLIT table node distances (using SN2 specific
> /proc files today, others are working on an arch-neutral mechanism).

There is already an arch neutral mechanism in sysfs, see
/sys/devices/system/node/node*/distance

That should be exactly SLIT on x86-64 and IA64 where node_distance()
reports SLIT data.

But of course SLIT doesn't know anything about cache latencies.

/Andi
