Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTKXK3C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 05:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263717AbTKXK3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 05:29:01 -0500
Received: from gate.corvil.net ([213.94.219.177]:14094 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S263705AbTKXK3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 05:29:00 -0500
Message-ID: <3FC1DD45.9070107@draigBrady.com>
Date: Mon, 24 Nov 2003 10:28:21 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oded Comay <comay@pod.tau.ac.il>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is PACKET_RX_RING broken in 2.6.0-test?
References: <Pine.LNX.4.44.0311222158400.9419-200000@pod.tau.ac.il>
In-Reply-To: <Pine.LNX.4.44.0311222158400.9419-200000@pod.tau.ac.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oded Comay wrote:
> The PACKET_RX_RING mechanism (enabled by CONFIG_PACKET_MMAP) appears to be 
> somewhat broken in 2.6.0-test* (2.6 for short). There are 3 issues:
> 
> 1. Performance in 2.6 is much lower than in 2.4. As an example, using the 
> same hardware and under the same traffic load, the attached sample program 
> could process 177K packets/sec in 2.4, but only 70K packets/sec in 2.6.

I'm guessing the scheduling changes are the cause?
Try messing with sched_setscheduler (like:
http://awgn.antifork.org/codes/brute.c)

Anyone else notice that the packet buffer messes up if
packets are being received while it's being created.
I worked around it here by bringing the interfaces
up AFTER the buffer is created.

Pádraig.

