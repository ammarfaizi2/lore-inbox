Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbUL0W4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUL0W4S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 17:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbUL0WyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 17:54:16 -0500
Received: from wildsau.idv.uni.linz.at ([193.170.194.34]:39567 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S261996AbUL0Ww5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 17:52:57 -0500
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>
Message-Id: <200412272248.iBRMmsgP021883@wildsau.enemy.org>
Subject: Re: SG_GET_VERSION_NUM rejected on scsi device?
To: linux-kernel@vger.kernel.org
Date: Mon, 27 Dec 2004 23:48:54 +0100 (MET)
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> good evening,
> 
> I have a old Plextor CD-R, native scsi, attached to an AHA_2940.
> ...
> now, I do an ioctl(SG_GET_VERSION_NUM) (0x2282), and that fails:
> 
>     open("/dev/sr0", O_RDONLY)              = 3
>     ioctl(3, 0x2282, 0xbffff660)            = -1 EINVAL (Invalid argument)

on the other hand, this ioctl works perfectly with 2.6.10:

    bash-2.05# ./sg_simple /dev/sr0
    v30527
    Some of the INQUIRY command's response:
        PLEXTOR   CD-R   PX-W124TS  1.00
    INQUIRY duration=1 millisecs, resid=40

unfortunately, I cannot switch to 2.6 easily. one reason
is that the pcnet32 driver does not work. at least, with
2.6.10, it does not crash the machine anymore (as it did with
2.6.7), however
NETDEV WATCHDOG: eth1: transmit timed out
eth1: transmit timed out, status 03f3, resetting.

and I do *not* want to buy a new network card just because
I switch kernels.

/herp

