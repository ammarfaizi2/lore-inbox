Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVGRUxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVGRUxe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 16:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVGRUxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 16:53:34 -0400
Received: from netcom1.netc.net ([205.236.235.4]:25990 "EHLO netcom1.netc.net")
	by vger.kernel.org with ESMTP id S261874AbVGRUxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 16:53:33 -0400
Message-ID: <42DC16CB.8080703@netc.net>
Date: Mon, 18 Jul 2005 16:53:31 -0400
From: Daniel Higgins <dhiggins@netc.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NAPI (aka RX Polling) for natsemi?
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,
is there such a thing anywhere as a working patch to enable NAPI in the
natsemi driver? or is someone working on one?

so far i have found two non-working patches, which i tried to get to
work without success. one locks up the kernel, the other says "interrupt
while polling". any help with these would be appreciated.
the DP83815 (natsemi) are used a lot on embedded routers (soekris, wrap,
routerboard) and since they all use a geode processor which isn't all
that powerful, they get stuck in a livelock at around 50-60 mbits and
reboot shortly after due to the watchdog

here's the patches i found if that can help anyone:
http://gnumonks.org/ftp/pub/patches/natsemi-napi.patch    locks up the
kernel once it receives some packet (guessing it's stuck in polling mode.. )
http://www.spine-group.org/sources/natsemi.diff    has "interrupts while
polling" messages and the throughput drops off to zero

cc: me because i'm not subscribed

thanks for any help and pointers



