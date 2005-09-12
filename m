Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVILUXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVILUXV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVILUXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:23:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17881
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932201AbVILUXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:23:20 -0400
Date: Mon, 12 Sep 2005 13:23:24 -0700 (PDT)
Message-Id: <20050912.132324.75976885.davem@davemloft.net>
To: abz@frogfoot.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: adding more than 100 network devices -- problems
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050912130242.GA15822@oasis.frogfoot.net>
References: <20050912130242.GA15822@oasis.frogfoot.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abraham van der Merwe <abz@frogfoot.net>
Date: Mon, 12 Sep 2005 15:02:42 +0200

> The problem is that network devices are currently limited to 100
> (dev_alloc_name() in net/core/dev.c).

This limit has been increased to 8*PAGE_SIZE in current
2.6.x kernels.

In 2.4.x you can safely increase the hard-coded limit in
dev_alloc_name() but if you have a lot of programs causing
the kernel to lookup devices by string name, you may run
into some performance problems.
