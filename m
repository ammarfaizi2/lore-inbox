Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751806AbWICAtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbWICAtK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 20:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWICAtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 20:49:10 -0400
Received: from mxsf12.cluster1.charter.net ([209.225.28.212]:32668 "EHLO
	mxsf12.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1751806AbWICAtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 20:49:07 -0400
X-IronPort-AV: i="4.08,203,1154923200"; 
   d="scan'208"; a="768255856:sNHT27537484"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17658.9856.132429.196116@smtp.charter.net>
Date: Sat, 2 Sep 2006 20:49:04 -0400
From: "John Stoffel" <john@stoffel.org>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.18-rc5-mm1, make oldconfig from 2.6.18-rc5 destroys LVM
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

When I do a make oldconfig under 2.6.18-rc5-mm1, with my working
2.6.18-rc5 .config file (appended below), all the LVM and MD stuff
gets blown away silently.  It looks like the drivers/md/Kconfig didn't
get updated properly when it was tweaked, possibly the new options to
get rid of BLOCK devices, or the ripping out of LVM1 stuff.

It looks like instead of 'if CONFIG_BLOCK' at the top, it just needs
to be 'if BLOCK' instead.  

And I'd really suggest that it NOT be this silly name BLOCK, something
more meaningful, like USE_BLOCK_DEVICES or something equally useful to
parse.

John

-- 
VGER BF report: U 0.499836
