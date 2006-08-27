Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWH0L2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWH0L2Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 07:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWH0L2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 07:28:16 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:22765 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750853AbWH0L2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 07:28:15 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 27 Aug 2006 13:25:01 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc4 0/5] drivers/ieee1394/sbp2: fixes for 2.6.18-rc
To: Linus Torvalds <torvalds@osdl.org>
cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Message-ID: <tkrat.bbaf8d081f6a31b7@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few bug fixes for sbp2 in -mm. Here is a selection of those
which I consider important enough and/or simple enough for inclusion
into 2.6.18-rc:

1/5 ieee1394: sbp2: workaround for write protect bit of Initio firmware
    fix bug #6947 (workaround for a device bug, not a Linux bug per se)

2/5 ieee1394: sbp2: safer agent reset in error handlers
    simple and obvious improvement

3/5 ieee1394: sbp2: safer last_orb and next_ORB handling
    prerequisite for patch 5/5, and more

4/5 ieee1394: sbp2: discard return value of sbp2_link_orb_command
    prerequisite for patch 5/5

5/5 ieee1394: sbp2: handle "sbp2util_node_write_no_wait failed"
    fix bug #6948

combined diffstat:
 drivers/ieee1394/sbp2.c |  186 +++++++++++++++++++++++++++-------------
 drivers/ieee1394/sbp2.h |   15 +--
 2 files changed, 133 insertions(+), 68 deletions(-)
-- 
Stefan Richter
-=====-=-==- =--- ==-==
http://arcgraph.de/sr/

