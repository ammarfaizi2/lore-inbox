Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268078AbUHXBxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268078AbUHXBxL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 21:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbUHXBxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 21:53:09 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:39841 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267425AbUHXBtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 21:49:21 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P8
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040823210151.GA10949@elte.hu>
References: <20040816040515.GA13665@elte.hu>
	 <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu>
	 <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net>
	 <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu>
	 <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu>
	 <20040821140501.GA4189@elte.hu>  <20040823210151.GA10949@elte.hu>
Content-Type: text/plain
Message-Id: <1093312154.862.17.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 23 Aug 2004 21:49:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-23 at 17:01, Ingo Molnar wrote:

>  - reduce netdev_max_backlog to 8 (Mark H Johnson)
> 

On my system this setting has absolutely no effect on the skb related
latencies.  I tested setting netdev_max_backlog to every power of two 
between 1 and 128, and regardless of this setting, I can produce a
450-600 usec latency with:

ping -s 65507 -f $DEFAULT_GATEWAY

Looks like skb_checksum is the problem.  Here is one of the traces:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P8#/var/www/2.6.8.1-P8/trace14.txt

Lee

