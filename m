Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbTJTXso (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 19:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbTJTXsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 19:48:36 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:49548 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S262925AbTJTXsc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 19:48:32 -0400
Date: Tue, 21 Oct 2003 01:48:32 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netfilter-devel@lists.netfilter.org
Subject: Re: 2.6.0-test6, connntrack/sis900/net (?)  Badness in local_bh_enable at kernel/softirq.c:119
Message-ID: <20031020234831.GA2926@finwe.eu.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	netfilter-devel@lists.netfilter.org
References: <20031020222306.GB32167@finwe.eu.org> <20031020161437.6708e994.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031020161437.6708e994.akpm@osdl.org>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> > I found it in logs (2.6.0-test6). It happened little while after 
> > I had reloaded dhcpd configuration.
[...]
> > eth0: Media Link Off
> > NETDEV WATCHDOG: eth0: transmit timed out
> > eth0: Transmit timeout, status 00000004 00000000 
> > Badness in local_bh_enable at kernel/softirq.c:119
> > Call Trace:
> >  [local_bh_enable+137/144] local_bh_enable+0x89/0x90
> >  [_end+130859013/1069963240] ip_ct_find_proto+0x3d/0x60 [ip_conntrack]
> >  [_end+130860013/1069963240] destroy_conntrack+0x15/0x110 [ip_conntrack]
> >  [sock_wfree+73/80] sock_wfree+0x49/0x50
> >  [__kfree_skb+143/272] __kfree_skb+0x8f/0x110
> >  [_end+130608961/1069963240] sis900_tx_timeout+0x99/0x150 [sis900]
> >  [dev_watchdog+0/208] dev_watchdog+0x0/0xd0
> >  [dev_watchdog+191/208] dev_watchdog+0xbf/0xd0
> 
> This should fix it up.
 
[patch cut] 
 
Applied, compiled, reloaded... I will watch logs carefully.

Thanks!
 

-- 
Jacek Kawa  **I hope life isn't a big joke, because I don't get it.**
