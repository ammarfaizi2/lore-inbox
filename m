Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTJQAKH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 20:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263262AbTJQAKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 20:10:06 -0400
Received: from mcgroarty.net ([64.81.147.195]:38101 "EHLO pinkbits.internal")
	by vger.kernel.org with ESMTP id S263260AbTJQAKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 20:10:03 -0400
Date: Thu, 16 Oct 2003 19:09:54 -0500
To: linux-kernel@vger.kernel.org
Subject: ns83820 - Strange behavior w/Dlink DGE-500T
Message-ID: <20031017000954.GA10635@mcgroarty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Debian-GNU-Linux: Rocks
From: Brian McGroarty <brian@mcgroarty.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With a Dlink DGE-550T and the 2.4.22 ns83820 driver, I'm seeing some
peculiar behavior. After installing the kernel module and bringing up
the interface, I see a lot of:

Oct 16 18:44:39 slate kernel: eth0: link now 1000 mbps, full duplex and up.
Oct 16 18:44:42 slate kernel: eth0: link now down.
Oct 16 18:44:45 slate kernel: eth0: link now 1000 mbps, full duplex and up.
Oct 16 18:44:47 slate kernel: eth0: link now down.
Oct 16 18:44:50 slate kernel: eth0: link now 1000 mbps, full duplex and up.
Oct 16 18:44:53 slate kernel: eth0: link now down.
Oct 16 18:44:55 slate kernel: eth0: link now 1000 mbps, full duplex and up.
Oct 16 18:44:58 slate kernel: eth0: link now down.
Oct 16 18:45:01 slate kernel: eth0: link now 1000 mbps, full duplex and up.

Adding several seconds of sleep after the insmod and again after bringing
the interface up makes just one or two of these happen.

Attempting net traffic without the sleep commands leaves the above
bouncing happening continuously until traffic attempts stop.

Once the network is up, the bouncing never happens anymore.

I've tried two different DGE-550Ts, a different switch, and a
different cable, but the problem seems consistent.
