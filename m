Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030526AbVIBOeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030526AbVIBOeJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 10:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030521AbVIBOeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 10:34:08 -0400
Received: from ns2.limegroup.com ([66.92.115.81]:34719 "EHLO ns2.limegroup.com")
	by vger.kernel.org with ESMTP id S1030526AbVIBOeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 10:34:05 -0400
Date: Fri, 2 Sep 2005 10:33:56 -0400 (EDT)
From: lists@limebrokerage.com
X-X-Sender: ion@guppy.limebrokerage.com
To: John Heffner <jheffner@psc.edu>
cc: "David S. Miller" <davem@davemloft.net>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Possible BUG in IPv4 TCP window handling, all recent 2.4.x/2.6.x
 kernels
In-Reply-To: <6064b8272aa4562242eb60eb75c7cdae@psc.edu>
Message-ID: <Pine.LNX.4.61.0509021022230.6083@guppy.limebrokerage.com>
References: <20050901.154300.118239765.davem@davemloft.net>
 <Pine.LNX.4.61.0509011845040.6083@guppy.limebrokerage.com>
 <2d02c76a84655d212634a91002b3eccd@psc.edu> <20050901.232823.123760177.davem@davemloft.net>
 <Pine.LNX.4.61.0509020948350.6083@guppy.limebrokerage.com>
 <6064b8272aa4562242eb60eb75c7cdae@psc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2005, John Heffner wrote:

> Have you tried increasing the size of the receive buffer yet?

Actually, I just did. I changed rmem_max and rmem_default to 4MB and 
tcp_rmem to "64k 4MB 4MB". It did seem to help, but I'm wondering if 
that's simply because it has a _lot_ of memory now to leak before it 
starts eating up into the window size.

I also ran into some very strange packet loss problems that weren't 
occurring yesterday; they only started occurring after I increased the 
buffer size. Most strange. If they happen again, I'll make sure I capture 
the flow to analyze it.

Anyway, that was just to see if I can do anything at all to mitigate the 
problem. I'll try again with smaller buffers (4k 128k 256k) and see what 
happens.

Thanks,
-Ion
