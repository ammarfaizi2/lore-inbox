Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269826AbTGKIUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 04:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269828AbTGKIUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 04:20:14 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:52188
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S269826AbTGKITs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 04:19:48 -0400
Date: Fri, 11 Jul 2003 10:35:05 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.75 does not boot - TCQ oops
Message-Id: <20030711103505.47e90027.lista1@telia.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003-07-11 2:51:42 Ivan Gyurdiev wrote:

> http://www.ussg.iu.edu/hypermail/linux/kernel/0307.0/0515.html

Reading the handcrafted log, yes, that's 'exactly' what I get ;-)
If prodded, I can do a transcription as well.

> where the bug is described for 2.5.74.
> I got no replies, and the bug persists in 2.5.75 (+bk patches).

Haven't tried the 2.5.74, but plain 2.5.75 is where I crash.

> Note:
> The machine boots with TASKFILE on, TCQ is causing the problem.

Yes, writing this on a machine with CONFIG_IDE_TASK_IOCTL is not set,
CONFIG_IDE_TASKFILE_IO=y and CONFIG_BLK_DEV_IDE_TCQ is not set.

Speaking of TASKFILE... I had some hope that it would fix at least a bit
of the regression in disk speed since 2.4.19-ac1+preempt (my yardstick,
excellent kernel). Doing a hdparm -tT /dev/hda on that kernel I get ca
123 MB/sec and 27 MB/sec. On this 2.5.75 I see 119 MB/sec and 22 MB/sec.

Here's hoping it can be cranked up before 2.6!

Mvh
Mats Johannesson
