Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTL2RBT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTL2RBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:01:18 -0500
Received: from [62.116.46.196] ([62.116.46.196]:7432 "EHLO it-loops.com")
	by vger.kernel.org with ESMTP id S263787AbTL2RBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:01:06 -0500
Date: Mon, 29 Dec 2003 18:00:25 +0100
From: Michael Guntsche <mike@it-loops.com>
To: linux-kernel@vger.kernel.org
Subject: Network problems with b44 in 2.6.0
Message-Id: <20031229180025.00b88096.mike@it-loops.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I activated my BCM4401 network card on my notebook, 
using the b44 module, to do some large file transfers 
(normally I use my wireless connection).
While copying around several MB between 2 computers I noticed something
very strange.

Scp'ing a file FROM the notebook TO my gateway, I got a throughput of
1.2MB. This looks normal, since the gateway is a very old machine.


--------

The problems started when copying a file in the opposite direction
(FROM the gateway TO the notebook).

As soon as I started the process, the following error messages started
appearing in my syslog.

	b44: eth0: Link is down.
	b44: eth0: Link is up at 100 Mbps, full duplex.
	b44: eth0: Flow control is on for TX and on for RX.
	b44: eth0: Link is down.
	b44: eth0: Link is up at 100 Mbps, full duplex.
	b44: eth0: Flow control is on for TX and on for RX.
	b44: eth0: Link is down.
	b44: eth0: Link is up at 100 Mbps, full duplex.
	b44: eth0: Flow control is on for TX and on for RX.
	b44: eth0: Link is down.

After a few seconds the whole transfer -stalled--.
The Link just went down and up and the messages filled my syslog.
For me it looks like that something is seriously wrong on the RX side,
since sending a file works without a problem.


System Info:
Acer TravelMate 800
Debian unstable
Kernel 2.6.0 no modifications
Broadcom Corporation BCM4401 100Base-T (rev 01)

Please CC: me if you have hints/need more information since I am not
subscribed to the list

Thanks in advance,
Michael




