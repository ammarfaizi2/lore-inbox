Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267512AbUIBHER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267512AbUIBHER (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 03:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267602AbUIBHEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 03:04:16 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:1964 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267512AbUIBHEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 03:04:15 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q8
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <20040902065549.GA18860@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
	 <20040902063335.GA17657@elte.hu>  <20040902065549.GA18860@elte.hu>
Content-Type: text/plain
Message-Id: <1094108653.11364.26.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 02 Sep 2004 03:04:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 02:55, Ingo Molnar wrote:
> i've released the -Q8 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q8
> 
> ontop of:
> 
>   http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2
> 

Here are traces of a 145, 190, and 217 usec latencies in
netif_receive_skb:

http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/trace2.txt
http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/trace3.txt
http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/trace4.txt

Some of these are with ip_conntrack enabled, at the request of another
poster, this does not make much of a difference, it increases the worst
case latency by 20 usec or so.

Also there is the rt_garbage_collect issue, previously reported.  I have
not seen this lately but I do not remember seeing that it was fixed.

Lee

