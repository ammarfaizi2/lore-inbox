Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWJQN4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWJQN4i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWJQN4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:56:38 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:44756 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1751009AbWJQN4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:56:37 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: John Philips <johnphilips42@yahoo.com>
Subject: Re: BUG: warning at kernel/softirq.c:141/local_bh_enable()
Date: Tue, 17 Oct 2006 15:56:37 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <20061017135013.19302.qmail@web57810.mail.re3.yahoo.com>
In-Reply-To: <20061017135013.19302.qmail@web57810.mail.re3.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610171556.37453.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 October 2006 15:50, John Philips wrote:
> Hi,
>
> I recently upgraded some router/NAT devices from 2.4.25 to 2.6.17.8. 
> They're using VIA C3 processors and NatSemi DP83815 NICs.
>
> Right after the upgrade I started noticing these error messages on one of
> the heavier-loaded boxes.  This particular box routes and does NAT for
> around 400 users, peaking at 6Mb/sec of throughput.
>
> The errors were happening about every 3-5 minutes.  I statically set eth6
> to 100baseTX-FD with mii-tool, and now the errors appear every few hours
> for 10-20 minute stretches.
>
> I searched Google and couldn't find any insight (FYI, I'm NOT using the
> CIPE patches).
>
> Any ideas?

Could you send us, once your machine is handling its typical load :

lspci -v
ethtool -S eth6
tc -s -d qdisc
cat /proc/slabinfo
cat /proc/meminfo

