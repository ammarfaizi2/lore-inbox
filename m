Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265511AbUBPNUW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 08:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265528AbUBPNUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:20:22 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:8405 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265511AbUBPNUR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:20:17 -0500
Message-ID: <4030C38A.4050909@cyberone.com.au>
Date: Tue, 17 Feb 2004 00:20:10 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Cliff White <cliffw@osdl.org>
Subject: Re: [BENCHMARK] 2.6.3-rc2 v 2.6.3-rc3-mm1 kernbench
References: <200402170000.00524.kernel@kolivas.org>
In-Reply-To: <200402170000.00524.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Here's some nice evidence of the sched domains' patch value:
>kernbench 0.20 running on an X440 8x1.5Ghz P4HT (2 node)
>
>Time is in seconds. Lower is better (fixed font table)
>
>Summary:
>Kernel:		2.6.3-rc2	2.6.3-rc3-mm1
>Half(-j8)	120.8		113.0
>Optimal(-j64)	81.6		79.3
>Max(-j)		82.9		80.3
>
>
>shorter summary:
>2.6.3-rc3-mm1 kicks butt
>
>

Thanks Con,
Results look pretty good. The half-load context switches are
increased - that is probably a result of active balancing.
And speaking of active balancing, it is not yet working across
nodes with the configuration you're on.

To get some idea of our worst case SMT performance (-j8), would
it be possible to do -j8 and -j64 runs with HT turned off?


