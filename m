Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTE0BBm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTE0BBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:01:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43407 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262175AbTE0BBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:01:41 -0400
Date: Mon, 26 May 2003 18:13:09 -0700 (PDT)
Message-Id: <20030526.181309.02272953.davem@redhat.com>
To: andrea@suse.de
Cc: akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030527010903.GF3767@dualathlon.random>
References: <20030527004115.GD3767@dualathlon.random>
	<20030526.174841.116378513.davem@redhat.com>
	<20030527010903.GF3767@dualathlon.random>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Tue, 27 May 2003 03:09:03 +0200

   I'm not going to implement the above in 2.4, that sounds a 2.5 thing,

Then your 2.4.x load balancing is buggy for networking.
You simply cannot ignore this issue and act as if it
does not exist and does not have huge consequence for IRQ
load balancing decisions.

   but my point is that by just ignoring ksoftirqd in the idle selection
   should avoid the biggest of the NAPI issues.

On a properly functioning system, ksoftirqd should not be running.

   > But deciding how to intepret these measurements and what to do in
   > response is a userlevel policy decision.  This also coincides with
   > how cpufreq works.
   
   you mean you can have slightly different modes selectable by sysctl
   right?

One posibility.  Another is a descriptor describing things like
how much to weight hardware vs. software IRQ load, vs. process
load etc.

   or do you really want to generate a reschedule per second

No, nothing like this.
