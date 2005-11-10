Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVKJRfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVKJRfb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 12:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVKJRfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 12:35:31 -0500
Received: from aragorn.bbn.com ([128.33.0.62]:12785 "EHLO aragorn.bbn.com")
	by vger.kernel.org with ESMTP id S1751178AbVKJRfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 12:35:31 -0500
Message-ID: <437384D4.9060304@bbn.com>
Date: Thu, 10 Nov 2005 12:35:16 -0500
From: "Armando L. Caro, Jr." <acaro@bbn.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050819)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: motivation for TCP's cwnd clamp?
X-Enigmail-Version: 0.92.0.0
OpenPGP: id=A9CE816E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been reading through the TCP code for kernel versions 2.4 and
2.6, and have noticed that both versions not only cache cwnd state, but
also use the cached state to clamp the cwnd of subsquent TCP connections
to the same destination. I can see the benefit (under some conditions)
for caching cwnd state, and it's useful (for the conditions where
caching hurts performance) that 2.6 offers the ability to turn this off.
However, I do not understand the motivation for setting a hard clamp on
the cwnd growth based on a cached cwnd. With this feature, a single
unlucky TCP connection to a destination will hurt the performance of all
subsequent TCP connections to that destination for as long as the state
is cached. I imagine that there must be a benefit that outweighs this
disadvantage, but I don't see it. Can anyone shed light on this for me?

Thanks in advance... (please CC me on the replies, because I am not
subscribed to the list)

-- 
Armando
www.armandocaro.net

