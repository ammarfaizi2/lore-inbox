Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTIAJae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 05:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbTIAJae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 05:30:34 -0400
Received: from xunil.mail.wildgooses.com ([81.6.236.5]:31475 "EHLO
	xunil.mail.wildgooses.com") by vger.kernel.org with ESMTP
	id S262784AbTIAJad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 05:30:33 -0400
Message-ID: <00aa01c3706b$b054b9a0$cb40a8c0@FRiskMan.com>
From: "Edward Wildgoose" <Ed@Wildgooses.com>
To: <linux-kernel@vger.kernel.org>
Subject: Curious problem with network driver on 2.6 (no UDP)
Date: Mon, 1 Sep 2003 10:30:25 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried most of the 2.6 test kernels with MM patches from test1 up to a
fairly recent test4.  In all of these I see a curious problem with sk98lin
net driver.

Basically, I am using an Asus P4P800 board (which is an i865 chipset) and it
has a 3Com gigabit lan which seems to be supported by the sk98lin net
driver.  What actually happens though is that the device seems to be
detected OK by the kernel, and in fact I can ping or otherwise make TCP
connections by IP address, but UDP seems to be failing.  The most obvious
problem is that name lookups are failing, and in fact if I run "nslookup
blah", this fails, however, if I add the flag to force lookup over TCP then
it runs fine.  Ping seems to work fine as well (by IP only of course)

The machine is pretty generic, there is no firewall installed, and in fact I
added a crummy old NE2000 10mbit card and if I simply unload and swap the
sk98lin driver for the ne2000 driver, then networking comes back up and
works perfectly (UDP name resolution is fine), so I'm pretty sure that this
is an issue with that net driver, rather than a config issue (the machine
obviously also works perfectly with a 2.4.22 kernel, although using the
3c2000 net driver in that case)

If this is interesting then can I send any more detailed info?  Is the
.config for the kernel interesting?  Just to stress that this testing has
only been done with the -mm patchset, I haven't tried the vanilla kernel
yet.

Thanks for listening

Ed W

