Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTE0GAD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 02:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262671AbTE0GAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 02:00:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19601 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262656AbTE0GAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 02:00:02 -0400
Date: Mon, 26 May 2003 23:11:20 -0700 (PDT)
Message-Id: <20030526.231120.26504389.davem@redhat.com>
To: andrea@suse.de
Cc: akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030527012617.GH3767@dualathlon.random>
References: <20030527010903.GF3767@dualathlon.random>
	<20030526.181309.02272953.davem@redhat.com>
	<20030527012617.GH3767@dualathlon.random>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Tue, 27 May 2003 03:26:17 +0200
   
   I argue with that, NAPI needs to poll somehow, either you hook into the
   kernel slowing down every single schedule, or you need to offload this
   work to a kernel thread.

You've never shown what this "offloading work to a kernel thread"
actually accomplishes.

What I've seen it do is decrease the amount of total softirq work that
cpu can get done.  And avoiding ksoftirqd actually running makes
performance get better.
