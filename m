Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbTE0BJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbTE0BJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:09:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51599 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262486AbTE0BI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:08:58 -0400
Date: Mon, 26 May 2003 18:20:26 -0700 (PDT)
Message-Id: <20030526.182026.27807754.davem@redhat.com>
To: andrea@suse.de
Cc: akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030527011750.GG3767@dualathlon.random>
References: <20030526162616.6ceacaba.akpm@digeo.com>
	<20030526233446.GZ3767@dualathlon.random>
	<20030527011750.GG3767@dualathlon.random>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Tue, 27 May 2003 03:17:50 +0200
   
   I'm going to try this (if it compiles ;). the ksoftirqd check is
   the one for the NAPI workload brought to attention by Dave.

Ksoftirqd should not be running on a properly functioning system.

In fact, I know lots of people who are simply making ksoftirqd
only run if we do the softirq loop N times where N is very large
in order to avoid the performance problems that result from ksoftirqd.
