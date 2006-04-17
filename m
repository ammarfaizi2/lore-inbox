Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWDQOWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWDQOWE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 10:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWDQOWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 10:22:04 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:51693 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751011AbWDQOWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 10:22:01 -0400
Date: Mon, 17 Apr 2006 16:21:58 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: George Nychis <gnychis@cmu.edu>
cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: want to randomly drop packets based on percent
In-Reply-To: <444345F9.4090100@cmu.edu>
Message-ID: <Pine.LNX.4.61.0604171618590.7579@yvahk01.tjqt.qr>
References: <444345F9.4090100@cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I'm using the 2.4.32 kernel with madwifi and iproute2 version
> 2-2.6.16-060323.tar.gz
>
> I wanted to insert artificial packet loss based on a percent so i found:
> network emulab qdisc could do it, so i compiled support into the kernel and
> tried:
> tc qdisc change dev eth0 root netem loss .1%

You could just use the 'random' match module from netfilter/POMng, but I 
doubt it will compile out-of-the-box on 2.4.32. It would then be as simple 
as
	iptables -t mangle -I PREROUTING -m random --average 1 -j DROP

> I really only need to drop random packets being forwarded through ip_forward
> ... however randomly dropping any packet based on a % is sufficient so I
> figured netem would be great.

Jan Engelhardt
-- 
