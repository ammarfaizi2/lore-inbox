Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266272AbTGEFH1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 01:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbTGEFH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 01:07:26 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:29667 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S266272AbTGEFH0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 01:07:26 -0400
Date: Thu, 3 Jul 2003 02:05:41 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] heavy disk access sometimes freezes 2.5.73-mm[123]
Message-ID: <20030703090541.GB5044@ip68-101-124-193.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is going to be a terribly vague bug report, of a bug that I can't
reproduce on demand (at least not yet). I'll see if I can bang on this
over the 4th of July weekend and create a reproducible scenario, but
until then, I want to at least get *something* in writing that other
people can see. So, here goes...

When I run 2.5.73-mm[123] on a Mandrake Cooker system here, it generally
runs fine. However, when I run "urpmi --auto-select" to upgrade the
packages to the latest versions, rpm tends to freeze up during
installation of one of the packages. This did not seem to happen with
2.5.70-mm9, which was the kernel I ran before 2.5.73-mm1.

(It doesn't seem to be happening with 2.5.74 either, although I think
it's really too soon to say for sure.)

ps shows a process (an rpm process, IIRC) stuck in the D state.

The most unusual aspect of this system is that it's using loopback root.
The root filesystem is ReiserFS, contained within a file on a FAT32
partition.

I'll try to make this happen in a more controlled environment soon...

-Barry K. Nathan <barryn@pobox.com>
