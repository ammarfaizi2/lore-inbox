Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268848AbUHWXrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268848AbUHWXrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 19:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268488AbUHWXpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 19:45:15 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:56974 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268464AbUHWXbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 19:31:36 -0400
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
Message-Id: <1093303895.862.7.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 23 Aug 2004 19:31:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-23 at 17:01, Ingo Molnar wrote:
> i've uploaded the -P8 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P8
> 
> Changes since -P8:
> 
>  - fixes the DRI/DRM latency in radeon (and other drivers). The concept 
>    was investigated/tested by Dave Airlie.
> 
>  - reduce netdev_max_backlog to 8 (Mark H Johnson)


With -P8 I have not seen a latency over 100 usecs yet.  The most common
latencies are those involving zap_pte_range, journal_get_undo_access and
netdev_process_backlog (even with netdev_max_backlog set to 4).

Traces:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P8

Lee

