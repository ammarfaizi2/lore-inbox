Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUHIHQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUHIHQu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 03:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUHIHQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 03:16:50 -0400
Received: from wit.mht.bme.hu ([152.66.80.190]:39570 "EHLO wit.wit.mht.bme.hu")
	by vger.kernel.org with ESMTP id S266195AbUHIHQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 03:16:48 -0400
Date: Mon, 9 Aug 2004 09:16:47 +0200 (CEST)
From: Ferenc Kubinszky <ferenc.kubinszky@wit.mht.bme.hu>
To: linux-kernel@vger.kernel.org
Subject: IPv6-IPv6 tunnel problem
Message-ID: <Pine.LNX.4.44.0408090904010.15626-100000@wit.wit.mht.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

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

