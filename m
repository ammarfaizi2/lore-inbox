Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268345AbUHWXyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268345AbUHWXyN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 19:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268845AbUHWXxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 19:53:12 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:18321 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269003AbUHWXtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 19:49:33 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040823194330.GA6539@elte.hu>
References: <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	 <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu>
	 <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu>
	 <20040820195540.GA31798@elte.hu> <20040821140501.GA4189@elte.hu>
	 <1093160993.817.46.camel@krustophenia.net>
	 <1093282713.826.13.camel@krustophenia.net>  <20040823194330.GA6539@elte.hu>
Content-Type: text/plain
Message-Id: <1093304968.862.11.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 23 Aug 2004 19:49:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-23 at 15:43, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > to file a bug report.  Traces can be found here:
> > 
> > http://krustophenia.net/2.6.8.1-P7
> 
> re the skb latencies: Mark H Johnson managed to reduce net-input
> latencies by decreasing /proc/sys/net/core/netdev_max_backlog to 8 -
> could you try this, does it help? (you could try an even more extreme
> setting like 4.)
> 

Spoke too soon with my last report.  I am actually still seeing
latencies close to 200 usecs in netdev_process_backlog.  Reducing
netdev_max_backlog to 4, then 2 did not seem to help.

netdev_process_backlog = 4:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P8#/var/www/2.6.8.1-P8/trace9.txt

netdev_process_backlog = 2:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P8#/var/www/2.6.8.1-P8/trace12.txt

Lee


