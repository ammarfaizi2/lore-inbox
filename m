Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTKCRqo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 12:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTKCRqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 12:46:44 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:14530 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262126AbTKCRqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 12:46:42 -0500
X-Sender-Authentication: net64
Date: Mon, 3 Nov 2003 18:46:41 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux@3ware.com
Cc: linux-kernel@vger.kernel.org
Subject: Bug during media scan, kernel 2.4.23-pre9
Message-Id: <20031103184641.7bceb740.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just encountered a real bad problem with using media scan on 3ware
controllers. I have 3 hds connected and configured a RAID5. I use media scan
regularly (daily basis). Since two days I see this problem:

Nov  3 18:12:11 box 3w-xxxx[2039]: INFORMATION: Verify started on unit 0 on
controller ID:2. (0x29)
Nov  3 18:19:41 box kernel: 3w-xxxx: scsi2: Unit #0: Command (f6e5d800) timed
out, resetting card.

After that the box has problems, the controller obviously hangs.
This in itself can be considered a bug, but what is really annoying is that one
has no chance finding out _which_ port caused the problem.
So at this point you can play roulette and replace one of the hds hoping that
it was indeed the bad one.

It would be really a lot better to degrade the unit in this case and give a
hint which port has problems (command timed out on port ...).
This would:
a) not hang the box
b) give you a chance to replace the hd, as you would expect in RAID5

The current situation is absolutely _no good_.

Regards,
Stephan
