Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264616AbTIJH5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 03:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264694AbTIJH5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 03:57:13 -0400
Received: from 11.ylenurme.ee ([193.40.6.11]:32643 "EHLO linking.ee")
	by vger.kernel.org with ESMTP id S264616AbTIJH5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 03:57:10 -0400
Message-ID: <2739.195.80.106.123.1063183974.squirrel@mail.linking.ee>
Date: Wed, 10 Sep 2003 10:52:54 +0200 (EET)
Subject: softraid + serverraid locking FS
From: <elmer@linking.ee>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 cp -dpR lotsfiles2GB /testcopy

                    SMP x335   UP x335
serverraid-serverraid  OK          OK
softraid-softraid      OK          OK
softraid-serverraid    OK          OK
serverraid5E-softraid  SLEEPY
serverraid1E-softraid                PROBLEM

it is redhat AS 2.4.9-25 kernel, SMP kernel for both.

PROBLEM:
  some general FS lock is accuired probably.
  ps axl and top and ls take up to 10-30 seconds to execute
  once heartbeat+softdog got its minute and flushed the whole box

Both computers are identical except one has 1 cpu, oter 2 cpu
2GB memory, bigpages=2100

softraid is raid1, discbox is EXP300, serverraid is 4M
/ is on softraid, sometimes "more /proc/mdstat" gets waiting at last row
for a while.








