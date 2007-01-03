Return-Path: <linux-kernel-owner+w=401wt.eu-S1750710AbXACKqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbXACKqi (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 05:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbXACKqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 05:46:38 -0500
Received: from poczta.o2.pl ([193.17.41.142]:48955 "EHLO poczta.o2.pl"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750710AbXACKqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 05:46:37 -0500
Date: Wed, 3 Jan 2007 11:48:14 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: Sid Boyce <sboyce@blueyonder.co.uk>
Cc: linux-kernel@vger.kernel.org, g3vbv@blueyonder.co.uk,
       netdev@vger.kernel.org
Subject: Re: 2.6.19 and up to  2.6.20-rc2 Ethernet problems x86_64
Message-ID: <20070103104814.GA2629@ff.dom.local>
References: <20061229063254.GA1628@ff.dom.local> <4595CD1B.2020102@blueyonder.co.uk> <20070102115050.GA3449@ff.dom.local> <459A7AF1.5060702@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459A7AF1.5060702@blueyonder.co.uk>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 03:32:01PM +0000, Sid Boyce wrote:
> Jarek Poplawski wrote:
...
> >If you could send full ifconfig, route -n (or ip route
> >if you use additional tables) and tcpdump (all packets)
> >from both boxes while pinging each other and a few words
> >how it is connected (other cards, other active boxes in
> >the network?) maybe something more could be found.
...
> Everything is fine with a eepro100 on the 64x2 box that gave the same
> problem with a nVidia Corporation MCP51 Ethernet Controller (rev a1)
> using the forcedeth module. On the x86_64 laptop the problem is with a
> Broadcom NetXtreme BCM5788 using the tg3 module. Switching back to a
> 2.6.18.2 kernel, there is no problem.
> With all configurations of cards on both, route -n is the same on all
> kernels and instantly reports back. With >=2.6.19 on the laptop, netstat
> -r takes a very long time before returning the information ~30 seconds,
> instantly on 2.6.18.2.

This could be a problem with DNS. Could you do all tests
(including pinging) with -n option?

I've read your other message on netdev and see you
have firewall working and addresses from various 
networks in logs. I think it would be much easier
to exclude possible network config errors and try
to isolate pinging problems by connecting (with
switch or even crossed cable if possible) only 2
boxes with firewalls and other net devices disabled
and try to repeat this pinging with tcpdumps.

Jarek P.
