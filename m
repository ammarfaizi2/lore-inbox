Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbVLGSGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbVLGSGe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 13:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbVLGSGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 13:06:33 -0500
Received: from tim.rpsys.net ([194.106.48.114]:28115 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751492AbVLGSGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 13:06:33 -0500
Subject: Sluggish machine under 2.6.14 and 2.6.15-rc5
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 18:06:26 +0000
Message-Id: <1133978786.8096.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently acquired some new hardware which I'd image to be fairly
standard - 3.0Ghz P4 (630?) HT CPU (800Mhz FSB),  Gigabyte 8I945P-G
motherboard, 1GB memory. I installed ubuntu and their 2.6.12-smp based
kernel was fine but didn't support all my hardware (this board has some
ip8212 ide ports). I therefore installed 2.6.15-rc5 which ran badly and
made the machine slow and sluggish. 2.6.14 shows the same speed issue.
2.6.13 runs just as well as 2.6.12 does. I'm using smp kernels to try
and take advantage of hyperthreading.

By slow and sluggish, I mean that the machine is generally lacking in
processing power and is also unresponsive to user interaction. Under
2.6.12/2.6.13 compared to 2.6.14/15-rc5:

* kernel compiles are at least twice as fast
* desktop menus are much more responsive
* bringing up dialogs e.g. to "Log Off" happens much faster 
* machine boots up much faster

The .configs and config differences:
http://www.rpsys.net/openzaurus/temp/desktop/config-2.6.13
http://www.rpsys.net/openzaurus/temp/desktop/config-2.6.14
http://www.rpsys.net/openzaurus/temp/desktop/config.diff

dmesg and differences:
http://www.rpsys.net/openzaurus/temp/desktop/dmesg-2.6.13
http://www.rpsys.net/openzaurus/temp/desktop/dmesg-2.6.14
http://www.rpsys.net/openzaurus/temp/desktop/dmesg.diff

dmesg.diff is probably the most interesting.

Is there a known reason I'd see so much speed difference between these
kernels? Is there something simple I'm missing here? 

Sadly, the later kernels are basically unusable.

I'd like to avoid a binary search but if that's the next step...

Richard




