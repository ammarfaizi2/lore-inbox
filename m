Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268174AbUHNHgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268174AbUHNHgd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 03:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266195AbUHNHgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 03:36:33 -0400
Received: from wit.mht.bme.hu ([152.66.80.190]:44703 "EHLO wit.wit.mht.bme.hu")
	by vger.kernel.org with ESMTP id S268174AbUHNHgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 03:36:31 -0400
Date: Sat, 14 Aug 2004 09:36:30 +0200 (CEST)
From: Ferenc Kubinszky <ferenc.kubinszky@wit.mht.bme.hu>
To: linux-kernel@vger.kernel.org
Subject: IPv6-IPv6 tunnel problem - again
Message-ID: <Pine.LNX.4.44.0408140934140.5197-100000@wit.wit.mht.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I haven't got any response so I re-post my former mail...

There is a strange problem with IPv6 tunnelling (at least) in kernel
2.6.5-2.6.7.

I configured a router with 4 interfaces towards 4 nets. Everithing works
well.
But if ip6tnl0 interface comes up, it gets eth0's link local address
automatically. It does not cause any problem until the tunneling interface
goes down. After it eth0 can't solicit its neighbour. Solicit messages are
sent, advertisements are received (tcpdump). But somehow it has no result,
so solicits are trasmitted again and again (the neighbour responds them).
Eth0 still has its link local address.

If ip6tnl0 set up again (ip l s ip6tnl0 up), the solicit works.
This can be repeated for ever.

Best regards,
Kubi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


