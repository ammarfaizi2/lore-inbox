Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267997AbRG2Nzi>; Sun, 29 Jul 2001 09:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267996AbRG2Nz2>; Sun, 29 Jul 2001 09:55:28 -0400
Received: from quechua.inka.de ([212.227.14.2]:18530 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S268004AbRG2NzS>;
	Sun, 29 Jul 2001 09:55:18 -0400
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: What does "Neighbour table overflow" message indicate?
In-Reply-To: <01072821151103.01125@mercury.snydernet.lan>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E15Qr2S-0000Th-00@sites.inka.de>
Date: Sun, 29 Jul 2001 15:55:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <01072821151103.01125@mercury.snydernet.lan> you wrote:
>    if (net_ratelimit())
>        printk("Neighbour table overflow.\n");

> The reference to "net_ratelimit" make me wonder if it is related to 
> iptables.  I am using iptable, and have since kernel 2.4.1, but I've seen 
> these messages before.  Hmmm.

Net ratelimit is used to limit the rate of messages or actions done by the
network module. In this case it only ensures, that the printk message is not
printed too often. The actual condition why the message is printed is above
this if.

Greetings
Bernd
