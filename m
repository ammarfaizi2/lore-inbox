Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbTIBRzm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTIBRzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:55:32 -0400
Received: from mail0-96.ewetel.de ([212.6.122.96]:61157 "EHLO mail0.ewetel.de")
	by vger.kernel.org with ESMTP id S263891AbTIBRuC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:50:02 -0400
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: bandwidth for bkbits.net (good news)
In-Reply-To: <rdje.1sH.11@gated-at.bofh.it>
References: <qn1b.2Pr.29@gated-at.bofh.it> <qoTh.5mt.11@gated-at.bofh.it> <rdje.1sH.11@gated-at.bofh.it>
Date: Tue, 2 Sep 2003 19:49:41 +0200
Message-Id: <E19uFHh-00012f-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Sep 2003 09:00:20 +0200, you wrote in linux.kernel:

> Stop argueing. You can shape only outgoing packets, which means that the
> shaper must have a big uplink pipe and then shape that into a thin downlink
> pipe. In Larrys' case, the shaper must be on the ISP network before the T1.

For Larry's case, you're right. Nothing you can do to shape lots of
incoming TCP connections. However, if you're facing a few long-lived
TCP connections, you can shape them by dropping incoming packets (that
is, shaping the outgoing packets from the router/shaper to the LAN).
The sending side will adjust its rate after at most a few seconds.

That works perfectly for the case of reserving bandwidth for critical
services in the face of ongoing large downloads. That's something
a lot of people want and need, so it's not all that worseless per se.

-- 
Ciao,
Pascal
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, 02 Sep 2003 09:00:20 +0200, you wrote in linux.kernel:

> Stop argueing. You can shape only outgoing packets, which means that the
> shaper must have a big uplink pipe and then shape that into a thin downlink
> pipe. In Larrys' case, the shaper must be on the ISP network before the T1.

For Larry's case, you're right. Nothing you can do to shape lots of
incoming TCP connections. However, if you're facing a few long-lived
TCP connections, you can shape them by dropping incoming packets (that
is, shaping the outgoing packets from the router/shaper to the LAN).
The sending side will adjust its rate after at most a few seconds.

That works perfectly for the case of reserving bandwidth for critical
services in the face of ongoing large downloads. That's something
a lot of people want and need, so it's not all that worseless per se.

-- 
Ciao,
Pascal
