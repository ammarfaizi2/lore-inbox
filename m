Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVEEWaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVEEWaA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 18:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVEEWaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 18:30:00 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:34436 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261962AbVEEW36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 18:29:58 -0400
Date: Fri, 6 May 2005 08:29:44 +1000 (EST)
From: Mark Goodwin <markgw@sgi.com>
X-X-Sender: markgw@woolami.melbourne.sgi.com
To: linux-kernel@vger.kernel.org
cc: axboe@suse.de
Subject: io accounting stops incrementing
Message-ID: <Pine.LNX.4.62.0505060805310.24864@woolami.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Has anyone noticed problems with io accounting in /proc/diskstats?
I wrote a simple program to open a large block special device and
then read blocks at random byte offsets in a hard loop. For a minute
or so the counters for the device in /proc/diskstats show the expected
increments, but then inexplicably all the counters stop incrementing.

This has been observed with 2.6.12-rc3 and various recent git trees.
I'm guessing it's related to the recent io accounting changes in 
ll_rw_blk.c but haven't investigated any further at this stage.

Thanks
-- Mark
