Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424315AbWKPSvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424315AbWKPSvn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 13:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424313AbWKPSvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 13:51:43 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:49283 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1162299AbWKPSvj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 13:51:39 -0500
Message-ID: <18154.194.90.237.34.1163703097.squirrel@dev.mellanox.co.il>
In-Reply-To: <60157.89.139.64.58.1163542548.squirrel@dev.mellanox.co.il>
References: <60157.89.139.64.58.1163542548.squirrel@dev.mellanox.co.il>
Date: Thu, 16 Nov 2006 20:51:37 +0200 (IST)
Subject: Re: UDP packets loss
From: eli@dev.mellanox.co.il
To: eli@dev.mellanox.co.il
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
User-Agent: SquirrelMail/1.4.8-1.fc5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> I am running a client/server test app over IPOIB in which the client sends
> a certain amount of data to the server. When the transmittion ends, the
> server prints the bandwidth and how much data it received. I can see that
> the server reports it received about 60% that the client sent. However,
> when I look at the server's interface counters before and after the
> transmittion, I see that it actually received all the data that the client
> sent. This leads me to suspect that the networking layer somehow dropped
> some of the data. One thing to not - the CPU is 100% busy at the receiver.
> Could this be the reason (the machine I am using is 2 dual cores - 4
> CPUs).

I still have the following argumet: the network and the network driver are
capable of transffering data at a high rate and the networking stack is
unable to keep the pace. If I used TCP probably TCP's flow control would
eventually slow the whole thing to a rate such all parts can handle. But
is there a way to overcome this situation and to avoid packets drop? If
this would happen then TCP would work at higher rates as well?? Perhaps
increase buffers sizes? Maybe the kernel is not designed to handle packets
rate like IPOIB can generate?

