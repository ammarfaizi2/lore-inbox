Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263211AbSJCJBC>; Thu, 3 Oct 2002 05:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263212AbSJCJBC>; Thu, 3 Oct 2002 05:01:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4304 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263211AbSJCJBA>;
	Thu, 3 Oct 2002 05:01:00 -0400
Date: Thu, 03 Oct 2002 01:58:42 -0700 (PDT)
Message-Id: <20021003.015842.56966498.davem@redhat.com>
To: bhards@bigpond.net.au
Cc: yoshfuji@linux-ipv6.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
Subject: Re: [PATCH] IPv6: Allow Both IPv6 and IPv4 Sockets on the Same
 Port Number (IPV6_V6ONLY Support)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200210031855.12148.bhards@bigpond.net.au>
References: <20021003.121350.119660876.yoshfuji@linux-ipv6.org>
	<20021003.012904.75241727.davem@redhat.com>
	<200210031855.12148.bhards@bigpond.net.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Brad Hards <bhards@bigpond.net.au>
   Date: Thu, 3 Oct 2002 18:55:11 +1000

   Assume B has two network interfaces (B1 and B2) on seperate IPv4 links (net1 
   and net2). Host A is on net1 and Host C is on net2. Assume that both Host A 
   and Host C have the same autoconf address. So IP address is not enough 
   information for Host B to use to determine which interface to use in order to 
   contact Host A (instead of Host C).
   
   If host B has socket binding on IP+port+local interface, it all works out.
   
You want SO_BINDTODEVICE, which we have.

   
