Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271378AbTHRKzI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 06:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271377AbTHRKzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 06:55:08 -0400
Received: from smtp1.att.ne.jp ([165.76.15.137]:1692 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S271384AbTHRKzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 06:55:03 -0400
Message-ID: <151901c36577$12b6f680$1aee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Russell King" <rmk@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
References: <135601c36495$85e507b0$1aee4ca5@DIAMONDLX60> <20030817143313.A22402@flint.arm.linux.org.uk>
Subject: Re: Trying to run 2.6.0-test3
Date: Mon, 18 Aug 2003 19:41:34 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Russell King" <rmk@arm.linux.org.uk> replied to me:

> > 2.6.0-test3 gets it wrong:
> > Aug 17 16:39:01 diamondpana cardmgr[540]: socket 1: KME KXLC005 CD-ROM
> > Aug 17 16:39:01 diamondpana cardmgr[540]: executing: 'modprobe -v ide_cs'
> > Aug 17 16:39:02 diamondpana cardmgr[540]: + insmod /lib/modules/2.6.0-test3/kernel/drivers/ide/legacy/ide-cs.ko
> > Aug 17 16:39:02 diamondpana cardmgr[540]: bind 'ide_cs' to socket 1 failed: Invalid argument
>
> Not quite.  This is an old problem dating back several years to early 2.4
> times.  Back in the dark old days, ide-cs used to use the name "ide_cs" to
> bind the driver to the device.  It now uses "ide-cs" for binding.

Yes the problem is reminiscent of early 2.4 days, but how is it that 2.4.19
doesn't have the problem and 2.6.0-test3 does have the problem on the same
machine?

> Make sure that "ide_cs" isn't mentioned in /etc/pcmcia/config - if it
> is, change it to "ide-cs".

I will hope to have time to check this next weekend, but I'm sure the 2.4
name ide-cs is used.  I was startled to see 2.6.0-test3 load a module named
ide_cs instead of ide-cs, but there it was.  It was listed that way by
lsmod, but failing in the bind as shown above.  Notice that modprobe used
the same name as lsmod showed.

