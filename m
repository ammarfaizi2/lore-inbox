Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbWDHWzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWDHWzG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 18:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWDHWzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 18:55:06 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35018
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965046AbWDHWzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 18:55:04 -0400
Date: Sat, 08 Apr 2006 15:54:30 -0700 (PDT)
Message-Id: <20060408.155430.111013393.davem@davemloft.net>
To: gnychis@cmu.edu
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.4.32: unresolved symbol unregister_qdisc
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <32947.128.2.140.234.1144536454.squirrel@128.2.140.234>
References: <32947.128.2.140.234.1144536454.squirrel@128.2.140.234>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "George P Nychis" <gnychis@cmu.edu>
Date: Sat, 8 Apr 2006 18:47:34 -0400 (EDT)

> Hey,
> 
> I have a kernel module that uses unregister_qdisc and register_qdisc, whenever i try to insert the module I get:
> /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o: /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o: unresolved symbol unregister_qdisc
> /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o: /lib/modules/2.4.32/kernel/net/sched/sch_xcp.o: unresolved symbol register_qdisc
> 
> Am i missing some sort of support in the kernel?

Make sure CONFIG_NET_SCHED is enabled and that you compiled your module against
that kernel.

Where does this sch_xcp come from?  It's not in the vanilla sources.

Also, please direct networking questions to the netdev@vger.kernel.org
mailing list which I have added to the CC:.
