Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbUKSXtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbUKSXtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 18:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbUKSXsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 18:48:09 -0500
Received: from ozlabs.org ([203.10.76.45]:59785 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261700AbUKSXrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 18:47:21 -0500
Date: Sat, 20 Nov 2004 10:47:17 +1100
From: Martin Pool <mbp@sourcefrog.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.8.1 hang when adding/removing tc rules
Message-ID: <20041119234713.GA3809@sourcefrog.net>
Mail-Followup-To: Martin Pool <mbp@sourcefrog.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was experimenting with tc rules on a 2.6.8.1 kernel, adding and
deleting rules on eth0 while traffic was flowing.

After perhaps twenty iterations when I entered this command the
machine hung.  SysRq-b rebooted it.

  sudo tc qdisc add dev eth0 root tbf rate 100kbit latency 50ms burst 1540

This kernel has been very solid in other respects on this machine.

--
Martin
