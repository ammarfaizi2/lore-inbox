Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129145AbQKQCb4>; Thu, 16 Nov 2000 21:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129147AbQKQCbq>; Thu, 16 Nov 2000 21:31:46 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:41717 "HELO
	halfway.linuxcare.com.au") by vger.kernel.org with SMTP
	id <S129145AbQKQCbc>; Thu, 16 Nov 2000 21:31:32 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: safemode <safemode@voicenet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (iptables) ip_conntrack bug? 
In-Reply-To: Your message of "Wed, 15 Nov 2000 15:46:03 CDT."
             <20001115154603.D4089@psuedomode> 
Date: Fri, 17 Nov 2000 13:01:16 +1100
Message-Id: <20001117020116.99DAC813F@halfway.linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20001115154603.D4089@psuedomode> you write:
> I was DDoS'd today while away and came home to find the firewall unable to
> do anything network related (although my connection to irc was still
> working oddly).  a quick dmesg showed the problem.
> ip_conntrack: maximum limit of 2048 entries exceeded
> NET: 1 messages suppressed.
> ip_conntrack: maximum limit of 2048 entries exceeded
> NET: 3 messages suppressed.
> ip_conntrack: maximum limit of 2048 entries exceeded
> NAT: 0 dropping untracked packet c1e69980 6 192.168.1.2 -> 206.251.7.30
> ip_conntrack: maximum limit of 2048 entries exceeded
> NAT: 0 dropping untracked packet c1e69b60 6 192.168.1.2 -> 206.251.7.30
> ip_conntrack: maximum limit of 2048 entries exceeded

Yes, I added connection assurance (which provides much more
intelligence about which connections should be dropped,
ie. established TCP connections get assured) in test6, for exactly
this reason.

Hope that helps,
Rusty.
--
Hacking time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
