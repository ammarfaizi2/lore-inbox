Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVEPQQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVEPQQm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 12:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVEPQQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 12:16:41 -0400
Received: from w240.dkm.cz ([62.24.88.240]:15370 "EHLO mail.spitalnik.net")
	by vger.kernel.org with ESMTP id S261727AbVEPQQj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 12:16:39 -0400
From: Jan Spitalnik <jan@spitalnik.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RR for route
Date: Mon, 16 May 2005 18:16:30 +0200
User-Agent: KMail/1.8.50
References: <Pine.LNX.4.61.0505161803180.26484@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0505161803180.26484@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505161816.31171.jan@spitalnik.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne po 16. kvìtna 2005 18:04 Jan Engelhardt napsal(a):
> Hello,
>
>
> does anybody know of a way to round-robin over multiple default gateways
> with the same metric? Currently, it looks like it's always the first GW
> which is taken.
>
>
> Jan Engelhardt

Hi,

this not round robin but the traffic is spread over more GW's

config IP_ROUTE_MULTIPATH
        bool "IP: equal cost multipath"
        depends on IP_ADVANCED_ROUTER
        help
          Normally, the routing tables specify a single action to be taken in
          a deterministic manner for a given packet. If you say Y here
          however, it becomes possible to attach several actions to a packet
          pattern, in effect specifying several alternative paths to travel
          for those packets. The router considers all these paths to be of
          equal "cost" and chooses one of them in a non-deterministic fashion
          if a matching packet arrives.

-- 
Jan Spitalnik
jan@spitalnik.net

If everyone used log base e, we'd all be happy!
