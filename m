Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbUB1PW3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 10:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbUB1PW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 10:22:29 -0500
Received: from painless.aaisp.net.uk ([217.169.20.17]:8135 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S261870AbUB1PW1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 10:22:27 -0500
Message-ID: <4040B354.9030104@rgadsdon2.giointernet.co.uk>
Date: Sat, 28 Feb 2004 15:27:16 +0000
From: Robert Gadsdon <robert@rgadsdon2.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040223
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.4-rc1 - problem with e100?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.4-rc1 the e100 driver appears not to work (network is 
'unreachable' although #route shows correct info).

Extract from dmesg:

e100: Intel(R) PRO/100 Network Driver, 3.0.15
e100: Copyright(c) 1999-2004 Intel Corporation
e100: eth0: e100_probe: addr 0xdf123000, irq 10, MAC addr 00:60:B0:57:C9:53
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
<snip>
e100: eth0: e100_watchdog: link down
<snip>
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
e100: eth0: e100_watchdog: link down
<snip>
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
e100: eth0: e100_watchdog: link down
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
e100: eth0: e100_watchdog: link down
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
- repeated......

Workaround is to use the eepro100 driver instead...

Problem also occurred with 2.6.3-bk8 and bk9..

2.6.3 worked OK.


Robert Gadsdon.
