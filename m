Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTJCMXd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 08:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263727AbTJCMXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 08:23:32 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:64223 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S263726AbTJCMXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 08:23:32 -0400
Date: Fri, 3 Oct 2003 14:23:29 +0200
From: Ookhoi <ookhoi@humilis.net>
To: Ookhoi <ookhoi@humilis.net>
Cc: Florian Zwoch <zwoch@backendmedia.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: e1000 -> 82540EM on linux 2.6.0-test[45] very slow in one direction
Message-ID: <20031003122329.GA21532@favonius>
Reply-To: ookhoi@humilis.net
References: <bkeli5$8l2$1@sea.gmane.org> <ble1ma$ul9$1@sea.gmane.org> <20031003103025.GA20676@favonius>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031003103025.GA20676@favonius>
X-Uptime: 12:41:52 up 116 days, 12:08, 38 users,  load average: 1.00, 1.00, 1.00
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ookhoi wrote (ao):
> Florian Zwoch wrote (ao):
> > issue seems to partly solved. the e1000 driver seems to be ok!
> > i reconfigured my kernel and intentionally left out netfilter options. 
> > after that my network performance was back to normal.
> > 
> > netfilter was only compiled in the kernel. it was not used with any rules!
> > 
> > so my wild guess would be that something with the netfilter code (i am 
> > not 100% sure it was netfilter.. _maybe_ it was some small odd kernel 
> > option i accidently enabled/disabled) is broken since test3 (again 
> > uncertified. but i firstly noticed this switching from test3 to test4).

> I have netfilter enabled, and will try another -test6 kernel with
> netfilter not compiled in to see if that indeed makes a difference.

I can confirm now that disabling netfilter in 2.6.0-test6 makes the nic
perform oke wrt upload.
I (just like Florian) had no iptables rules active in the former
2.6.0-test6 kernel, but netfilter was compiled in.
