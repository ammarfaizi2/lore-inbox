Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269343AbUIIFHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269343AbUIIFHL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 01:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269347AbUIIFHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 01:07:10 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:28089 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S269343AbUIIFHH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 01:07:07 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: another oops, this time in 2.6.9-rc1-mm4
Date: Thu, 9 Sep 2004 01:07:05 -0400
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409090107.05415.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.49.110] at Thu, 9 Sep 2004 00:07:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I just had to reboot back to -mm2 after playing with some printer configs in
cups, although the test pages worked, so I'm not sure what this all about,
from var log/messages:

Sep  8 23:13:42 coyote cups: cupsd -HUP succeeded
Sep  8 23:13:43 coyote kernel: usb_unlink_urb() is deprecated for synchronous unlinks.  Use usb_kill_urb()
Sep  8 23:13:43 coyote kernel: Badness in usb_unlink_urb at drivers/usb/core/urb.c:456
Sep  8 23:13:44 coyote kernel:  [<c01048ce>] dump_stack+0x1e/0x20
Sep  8 23:13:44 coyote kernel:  [<c0295f35>] usb_unlink_urb+0x85/0xa0
Sep  8 23:13:44 coyote kernel:  [<c02a7447>] usblp_unlink_urbs+0x17/0x40
Sep  8 23:13:44 coyote kernel:  [<c02a74a8>] usblp_release+0x38/0x60
Sep  8 23:13:44 coyote kernel:  [<c01501ea>] __fput+0x12a/0x140
Sep  8 23:13:44 coyote kernel:  [<c014e8e7>] filp_close+0x57/0x80
Sep  8 23:13:44 coyote kernel:  [<c014e971>] sys_close+0x61/0x90
Sep  8 23:13:44 coyote kernel:  [<c010425d>] sysenter_past_esp+0x52/0x71

repeat about 40-50 times before I rebooted cause it was very sluggish.

cups is 1.1.21-rc2, from rpm.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.25% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
