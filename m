Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbTJ1UBx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 15:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbTJ1UBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 15:01:53 -0500
Received: from CPEdeadbeef0000-CM000039d4cc6a.cpe.net.cable.rogers.com ([67.60.40.239]:640
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id S261685AbTJ1UBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 15:01:51 -0500
Date: Tue, 28 Oct 2003 15:01:42 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: linux-kernel@vger.kernel.org
Subject: PS/2 Slowness w/ 2.6.0-test9-bk2
Message-ID: <Pine.LNX.4.44.0310281457300.459-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Apon trying the latest -bk, I've noticed changes in how the kernel
determines mouse rate.

Although this was easy to fix with gpm, XFree86-HEAD does not seem to
honor any manual overriding of the mouse rate. Even when setting the rate
to 60 this did not work.

After reverting the psmouse-base.c changes XFree86 behaved like previous.

I would suggest reverting the patch until this issue is resolved. I don't
know what X is doing to get the mouse rate but it certainly ignored it
when I set psmouse_rate=60 in kernel parameters. Perhaps someone knows
something I'm not doing.

This isn't trying to start a flamewar but I'd prefer that these changes
were checked beforehand.

Thanks,
Shawn S.


