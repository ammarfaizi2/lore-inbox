Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966417AbWKNWPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966417AbWKNWPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 17:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966416AbWKNWPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 17:15:50 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:39041 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S966060AbWKNWPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 17:15:49 -0500
Message-ID: <60157.89.139.64.58.1163542547.squirrel@dev.mellanox.co.il>
Date: Wed, 15 Nov 2006 00:15:47 +0200 (IST)
Subject: UDP packets loss
From: eli@dev.mellanox.co.il
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
User-Agent: SquirrelMail/1.4.8-1.fc5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am running a client/server test app over IPOIB in which the client sends
a certain amount of data to the server. When the transmittion ends, the
server prints the bandwidth and how much data it received. I can see that
the server reports it received about 60% that the client sent. However,
when I look at the server's interface counters before and after the
transmittion, I see that it actually received all the data that the client
sent. This leads me to suspect that the networking layer somehow dropped
some of the data. One thing to not - the CPU is 100% busy at the receiver.
Could this be the reason (the machine I am using is 2 dual cores - 4
CPUs).

The secod question is how do I make the interrupts be srviced by all CPUs?
I tried through the procfs as described by IRQ-affinity.txt but I can set
the mask to 0F bu then I read back and see it is indeed 0f but after a few
seconds I see it back to 02 (which means only CPU1).

One more thing - the device I am using is capable of generating MSIX
interrupts.

Thanks from advance
Eli

