Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVGaJrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVGaJrV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 05:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVGaJrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 05:47:21 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:50647 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S261650AbVGaJrU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 05:47:20 -0400
From: dth@picard.cistron.nl (Danny ter Haar)
Subject: busy usenet server: only stable kernel is 2.6.12-mm1, rest (including 2.6.13-rc4*) barfs within a few days
Date: Sun, 31 Jul 2005 09:47:18 +0000 (UTC)
Organization: Cistron
Message-ID: <dci6n6$3tn$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1122803238 4023 62.216.30.70 (31 Jul 2005 09:47:18 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@picard.cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going nuts...
A tyan AMD64 opteron machine functioning as a usenet gateway really
pumps some traffic a day (http://newsgate.newsserver.nl)
Incoming traffic comes through a optical gig-E card (acenic)
and local traffic is fed to our spool boxes through cupper gig-E
(tigon3). Machine uses adaptec onboard scsi disks.
At first i thought i had a hardware problem since no kernel would
survive longer than 30 hours. Ofcourse i ran memtest for a couple
of days. Than i compiled 2.6.12-mm1 and this kernel surviced 18 days 
without a problem. But of course you now and then want to try 
bigger&better(tm) kernels ;-)

reboot   system boot  2.6.12-mm1       Sun Jul 31 09:47          (01:48)
reboot   system boot  2.6.13-rc4-git2  Sat Jul 30 18:29          (17:07)
reboot   system boot  2.6.12-mm1       Sat Jul 30 14:12          (04:14)
reboot   system boot  2.6.13-rc4       Fri Jul 29 14:16        (1+04:10)
reboot   system boot  2.6.13-rc3-mm3   Fri Jul 29 12:17          (01:50)
reboot   system boot  2.6.12-mm1       Thu Jul 28 00:06        (1+12:09)
reboot   system boot  2.6.13-rc3-mm2   Wed Jul 27 22:27          (01:36)
reboot   system boot  2.6.13-rc3-mm1   Wed Jul 27 11:22          (12:41)
reboot   system boot  2.6.12-mm1       Sun Jul 17 15:51        (9+19:29)

Machine dus have serial console (and remote powerboot) but no logging
posibility (portmaster1). When it crashes i think most of the times it
has something to do with IRQ.
2.6.13-rc4-git2 stopped working with the following notice:

Jul 31 03:28:18 newsgate kernel: hw tcp v4 csum failed
Jul 31 05:56:59 newsgate kernel: NETDEV WATCHDOG: eth3: transmit timed out
Jul 31 05:56:59 newsgate kernel: tg3: eth3: transmit timed out, resetting

Serial console kept spitting those messages but it gave no prompt
anymore. remote powercycle was needed to get it back.

More info/config can be found at: http://newsgate.newsserver.nl/kernel/

Any feedback/suggestions welcome.

Danny



