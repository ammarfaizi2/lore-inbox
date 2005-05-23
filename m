Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVEWMMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVEWMMz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 08:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVEWMMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 08:12:55 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:13010 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261261AbVEWMMk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 08:12:40 -0400
Date: Mon, 23 May 2005 14:14:24 +0200
From: DervishD <lkml@dervishd.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RESEND] Hard disk LBA sector count is not always the same
Message-ID: <20050523121424.GB339@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    I'm resending this because although it doesn't seem to imply a
hard disk failure, I have to repartition this disk and I must do it
using a 2.6 kernel (long story), and I'm afraid that afterwards I
cannot access the last sectors using 2.4 (since sometimes the disk is
detected as being 2103 sectors smaller. I would appreciate any help,
or if someone could point me to a source of information or a more
appropriate mailing list.

    I'm having a problem with my primary hard disk: it inconsistently
reports the number of addressable LBA sectors. At times it reports
156301488 (let's call it '301' from now on) which is the correct one
(I think) and other times it reports 156299375 (I'll call this one
299 from now on), a difference of 2103 sectors. But this is not
arbitrary, I have reproduced the problem. I've done it using a
self-compiled 2.4.29 kernel and a 2.6.10-1-k7 kernel from Debian
unstable. These are the steps:

    STEP 1: From a fully powered off machine, I boot into my 2.4.29
kernel. The kernel log shows the 299 number, as well as does both
hdparm -i and hdparm -I. No matter how many times I reboot these
numbers maintain given I always reboot into 2.4.29.

    STEP 2: I reboot into my Debian system, using 2.6.10 kernel, and
now kernel logs show 301 number, as does hdparm -I. But hdparm -i
shows the 299 number.

    STEP 3: I reboot again into my Debian system. This time all
places show the 301 number: the kernel logs, hdparm -i and -I.

    STEP 4: I reboot into my 2.4.19 kernel, and this time ALL places,
again, show the 301 number. No matter how many times I reboot into
2.4.29 again or even 2.6 (Debian), these numbers doesn't change.

    I've done the same but starting from full power-off into Debian,
and the things went like if we start from STEP 2 above. The only
thing I've seen in the Debian logs that may explain this problem are:

    current capacity is 156299375
    native capacity is 156301488

    But I don't know why this happens...

    The disk (Seagate ST380021A, 80GB, UDMA100) is not showing
symptoms of a coming failure, it works ok and no data corruption has
happened (yet...), but I'm worried.

    Is this a known issue of 2.4 kernels? Am I doing anything wrong?
Any other detail about hardware, logs, etc. you must know? Thanks a
lot in advance :)))

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
