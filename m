Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130820AbREIURn>; Wed, 9 May 2001 16:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131191AbREIURe>; Wed, 9 May 2001 16:17:34 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:30216 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S130820AbREIURU>; Wed, 9 May 2001 16:17:20 -0400
Date: Wed, 9 May 2001 16:17:23 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Patch to make ymfpci legacy address 16 bits
Message-ID: <Pine.LNX.4.33.0105091553530.2104-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Pete!

Next time you are asking my opinion please cc: me, so that I can quote
you.

Yes, I think you have fixed a terrible bug in ymfpci. Decoding only 10-bit
addresses is extremely dangerous, considering that only 388-38b is
reserved, while 788-78b etc are not.

In order to get your patch accepted sooner please use symbolic constants
and better indentation. I don't want to steal your credits by doing it for
you :-)

If you want to play further with APM and ymfpci, I made a stub for proper
apm support in the ymfpci driver. It's available here:

http://www.red-bean.com/~proski/linux/ymfpci_pm.diff

You may need to save some data in memory when the system goes to suspend
and restore them afterwards. I believe that the PCI config space should be
saved by BIOS. Everything else is the responsibility of the driver.

If I find a similar problem in ALSA it will be reported with cc: to you.

-- 
Regards,
Pavel Roskin

