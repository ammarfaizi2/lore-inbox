Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVAORBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVAORBm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 12:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbVAORBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 12:01:42 -0500
Received: from av7-2-sn4.m-sp.skanova.net ([81.228.10.109]:7341 "EHLO
	av7-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S262300AbVAORBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 12:01:40 -0500
X-Mailer: exmh version 2.7.0 04/02/2003 (gentoo 2.7.0) with nmh-1.1
To: linux-kernel@vger.kernel.org
Subject: kswapd (& clock?) problems in 2.6.10
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 15 Jan 2005 14:40:52 +0100
From: aeriksson@fastmail.fm
Message-Id: <20050115134052.7CD3A24286B@latitude.mynet.no-ip.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since installing 2.6.10 kswapd has decided to loop wildly on two
occations. Both occations happened after starting a big compiles.
Checking vmstat, I noticed a steady stream of io/bi figures ranging
between 2-5K (which is about what I can get out of this box during
normal operation), but no swap io(?). Manwhile the load (xload)climbs
to about 10, and the system looses interactive responsiveness.

Now after the last time, after reboot, I noticed that the clock was
missing 3 hours, which is about the time I left the box unattended. It
might be that kswapd stresses the system to the point that the clock
cannot move forward, (or the clock does something bad and kswapd gets
tricked by it???).

Thoughts anyone?

/Anders




