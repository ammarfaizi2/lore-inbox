Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUC2SWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 13:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbUC2SWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 13:22:22 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:10390 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S263062AbUC2SWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 13:22:15 -0500
Message-ID: <40685BC9.1040902@myrealbox.com>
Date: Mon, 29 Mar 2004 09:24:25 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040327
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: rl@hellgate.ch
Subject: Via-Rhine ethernet driver problem?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Roger et al,

ECS K7VTA3 motherboard with built-in ethernet chip:

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
         Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded Ethernet Controller on VT8235
         Flags: bus master, medium devsel, latency 32, IRQ 11
         I/O ports at ec00 [size=256]
         Memory at e9041000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [40] Power Management version 2

The problem is terrible performance -- I noticed that NFS file transfers grind
to a complete halt almost immediately on this machine.

I also discovered by using 'scp' to copy files between machines that the bad
performance is assymetrical:  copying a file *to* this machine runs at about
half-speed (5 MB/sec) whereas copying a file *from* this machine runs at
45 KiloB/sec, about one percent of expected.

The reason I feel this is software and not hardware is that the same machine
running any of the BSD's runs full-speed in both directions.

The 2.4.x and 2.6.x drivers appear to be the same and they behave the same,
as you might expect.

I'd be happy to supply any other information that might be helpful.

Thanks!
