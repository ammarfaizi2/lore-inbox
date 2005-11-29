Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbVK2GNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVK2GNB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 01:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVK2GNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 01:13:01 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17861
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751317AbVK2GNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 01:13:00 -0500
Date: Mon, 28 Nov 2005 22:12:38 -0800 (PST)
Message-Id: <20051128.221238.09510598.davem@davemloft.net>
To: kjak@users.sourceforge.net, kjak@ispwest.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Resetting packet statistics
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <9188864830a243e8a5ed8ce75d1b098f.kjak@ispwest.com>
References: <9188864830a243e8a5ed8ce75d1b098f.kjak@ispwest.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kris Katterjohn" <kjak@ispwest.com>
Date: Mon, 28 Nov 2005 19:55:52 -0800

> These patches keep getsockopt(PACKET_STATISTICS) from resetting the packet
> stats to zero and it creates PACKET_RESET_STATISTICS, which is used with
> setsockopt(), to zero the packet stats.
> 
> Signed-off by: Kris Katterjohn <kjak@users.sourceforge.net>

You can't change existing behavior in order to get the new behavior
you want.  Some applications might be depending upon what happens
currently.
