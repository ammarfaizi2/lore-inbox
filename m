Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWHLRW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWHLRW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWHLRW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:22:27 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:49109 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S964930AbWHLRW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:22:26 -0400
Date: Sat, 12 Aug 2006 19:22:02 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Innocenti Maresin <qq@inCTV.ru>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Q: remapping IP addresses for inbound and outbound traffic
In-Reply-To: <LKML-nat-0.qq@inCTV.ru>
Message-ID: <Pine.LNX.4.61.0608121916300.2346@yvahk01.tjqt.qr>
References: <LKML-nat-0.qq@inCTV.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Let one Linux box have two interfaces to IPv4 networks, 
>and for some IP both networks have the host with this IP address, e.g. from RFC1918. 
>Or even both use the same IPv4 address block. 
>We can say that one IP from the first network 
>and numerically the same IP from the second "means" different hosts. 
>
>I clarify these terms so carefully because in news:comp.os.linux.networking 
>some people state that I "use terms in strange ways" :) 

But we are not in comp.os.linux.networking here, and getting a concrete 
example like "my eth0 has 134.76.13.21/24 and my eth1 has 10.foo.bar/xyz" 
is a little easier to understand.

>The software of this box needs to connect all hosts in both networks, 
>and also to receive inbound TCP connections. 
>The evident way is to "remap" overlapping IPv4 area of one network 
>to some "place" not used neither in it nor in other. 

If they do not use the same address block, they don't overlap and there is 
no need to remap them.

>This means that, when we receive a packet from remapped area, 
>the kernel should replace the source IP to an "internal representaion". 
>Versa, sending something to "internally represented" IP 
>the kernel should replace such IP by its external value. 


Jan Engelhardt
-- 
