Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267633AbRG2JrG>; Sun, 29 Jul 2001 05:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267584AbRG2Jq4>; Sun, 29 Jul 2001 05:46:56 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:29703 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S267633AbRG2Jqp>; Sun, 29 Jul 2001 05:46:45 -0400
Date: Sun, 29 Jul 2001 11:46:40 +0200
From: Kurt Roeckx <Q@ping.be>
To: Steve Snyder <swsnyder@home.com>
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: What does "Neighbour table overflow" message indicate?
Message-ID: <20010729114640.A5359@ping.be>
In-Reply-To: <01072820231401.01125@mercury.snydernet.lan> <01072820534802.01125@mercury.snydernet.lan> <20010729135728.B3282@weta.f00f.org> <01072821151103.01125@mercury.snydernet.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <01072821151103.01125@mercury.snydernet.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, Jul 28, 2001 at 09:15:11PM -0500, Steve Snyder wrote:
> 
> Further snooping shows the error msg text in file inux/net/ipv4/route.c:
> 
>     if (net_ratelimit())
>         printk("Neighbour table overflow.\n");
> 
> The reference to "net_ratelimit" make me wonder if it is related to 
> iptables.  I am using iptable, and have since kernel 2.4.1, but I've seen 
> these messages before.  Hmmm.

net_ratelimit() is there to only log something every 5 seconds,
so your logs don't get flooded.  It should be used for every
printk that has to do with net.

See core/utils.c


Kurt

