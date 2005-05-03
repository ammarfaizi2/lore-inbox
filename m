Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVECSNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVECSNg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 14:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVECSLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 14:11:52 -0400
Received: from web88008.mail.re2.yahoo.com ([206.190.37.195]:21425 "HELO
	web88008.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261497AbVECSKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 14:10:18 -0400
Message-ID: <20050503181018.37973.qmail@web88008.mail.re2.yahoo.com>
Date: Tue, 3 May 2005 14:10:18 -0400 (EDT)
From: Shawn Starr <shawn.starr@rogers.com>
Subject: [2.6.12-rc3][SUSPEND] qla1280 (QLogic 12160 Ultra3) blows up on A7M266-D
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was feeling lucky yesterday and decided to try my
luck on an A7M266-D with suspend-to-disk. I noticed
two things

1) If I use XFS /w the SCSI controller (connected to 2
IBM HD 10K Ultra3 SCSI disks) I can suspend to disk no
problem, but resuming all hell breaks loose. It takes
a half an hour to reload the swap memory dumped to
disk. When it finally does resume. The SCSI controller
throws ISP errors and hangs. When rebooting after, the
partition table is completely gone (I did not try to
repair it).

2) If I use EXT3, suspending to disk is fine resuming
is fine there is no long delay to load the swap memory
back to RAM. But when it finishes resuming I get the
same ISP error and the partition table gets corrupt as
well.


Is it likely this SCSI driver doesn't know how to
handle suspend events?

Shawn.
