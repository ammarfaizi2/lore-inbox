Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271154AbTGYLsx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 07:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271716AbTGYLsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 07:48:53 -0400
Received: from venus.uos.ac.kr ([210.125.183.202]:65182 "EHLO venus.uos.ac.kr")
	by vger.kernel.org with ESMTP id S271154AbTGYLsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 07:48:52 -0400
From: "Youngmin Kim" <blhole@venus.uos.ac.kr>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: ipv6 multicast forwarding
Date: Fri, 25 Jul 2003 21:04:01 +0900
Message-ID: <000301c352a4$d60594b0$1e6ef9cb@LocalHost>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a concern with ipv6 multicast!! But I don't know "linux
forwarding" well

I inserted 2 lines in ip6_mc_input()

	....
	if (ipv6_chk_mcast_addr(skb->dev, &hdr->daddr))
		deliver =1;

	>>if (ipv6_devconf.forwarding == 1)
	>>	ip6_mc_forward(skb, deliver);

	if (deliver)
		discard = 0;
		ip6_input(skb);
	}
	......

I made ip6_mc_forward() which was modified from ip6_forward().

But it doesn't work...
How do I make ip6_mc_forward()? 

I want simple ipv6 multicast forward... 
  When host receive multicast packet, host forward it without multicast
routing cache..
  Then I will filter unneeded packets.

Nobody help me??
Thank you!!

