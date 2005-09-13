Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVIMVMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVIMVMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVIMVMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:12:22 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:31120 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S932209AbVIMVMV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:12:21 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: Q: why _less_ performance on machine with SMP then with UP kernel ?
Date: Tue, 13 Sep 2005 21:12:15 +0000 (UTC)
Organization: Cistron
Message-ID: <dg7fbf$5df$1@news.cistron.nl>
X-Trace: ncc1701.cistron.net 1126645935 5551 62.216.30.70 (13 Sep 2005 21:12:15 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been posting here recently bout our newsgateway.
For short:

If i enable both CPU's i get less performance than enabling both cpu's

Long version:

Here is a description of the setup:
---
It's a tyan server /motherboard
http://www.tyan.com/products/html/ta26b2882.html
with 2 x OPTERON250 cpu's and 4 GIG of ECC ram.
There is 8 x scsi disks for storage
cupper gig-E for internal communication to spool/header servers etc.
acenic FiberOptic Gig-E 64bit PCI card for link to the internet.

Bandwidth use is sampled from the ethernet switch and with mrtg
visualised.

Take today for example:
http://newsgate.newsserver.nl/kernel/2.6.14-rc1-ethernet-bandwidth.png

>From yesterday till 10:30am i ran 2.6.13.1 in UP mode.
As you can see blue (==incoming traffic) is fairly constant.
This morning i compiled/installed 2.6.14-rc1-smp.
I let it ran till 12:15 but it's clear that it can't keep up
with the flow of data. I rebooted to 2.6.14-rc1 (UP) and that 
keeps up with the data just fine.

So what is the difference between UP & SMP ?
shared memory , shared interrupts.
I don't know _why_ it's living up to _my_ expectation.
I hoped that the load would drop (it's between 4 to 5) op UP kernel
because certain processes would be split over the processors.

Anybody want to try and explain to me where i'm making an error ?

Config file & kern.log output  can be found at :
http://newsgate.newsserver.nl/kernel/

A very confused

Danny

