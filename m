Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVEaPSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVEaPSW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 11:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVEaPSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 11:18:22 -0400
Received: from odin2.bull.net ([192.90.70.84]:50648 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261890AbVEaPSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 11:18:18 -0400
Subject: RT : Large transfert with 2.6.12rc5 +
	realtime-preempt-2.6.12-rc5-V0.7.47-15
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: BTS
Message-Id: <1117552050.19367.63.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Tue, 31 May 2005 17:07:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the same problem with rc4+47-07, rc5+47-10,47-13
I reproduce this problem with a tg3 driver and with e1000 driver.
So I think it's not a driver problem.

I try to copy an iso image from this machine to another one by scp.
after 35 to 45MB, the copy become stalled with no more transfert.
We can ping the target machine, all apparently is OK except the scp
which finish with timeout.
With ftp, the stalled state is about 100MB.
If I reboot with a standard kernel ( without RT ), no problem.

Perhaps there is a progress, in 47-15, the size is now 135-140MB

On this machine, we have an ide disk.
I have setup : hdparm 
-sh-2.05b# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 65535/16/63, sectors = 78165360, start = 0



