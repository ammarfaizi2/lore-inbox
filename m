Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267478AbUIBHb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267478AbUIBHb3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 03:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267767AbUIBHb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 03:31:29 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:36781 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267478AbUIBHb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 03:31:28 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q8
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <20040902071525.GA19925@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
	 <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu>
	 <1094108653.11364.26.camel@krustophenia.net>
	 <20040902071525.GA19925@elte.hu>
Content-Type: text/plain
Message-Id: <1094110289.11364.32.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 02 Sep 2004 03:31:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 03:15, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Here are traces of a 145, 190, and 217 usec latencies in
> > netif_receive_skb:
> > 
> > http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/trace2.txt
> > http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/trace3.txt
> > http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-Q6#/var/www/2.6.9-rc1-Q6/trace4.txt
> 
> these all seem to be single-packet processing latencies - it would be
> quite hard to make those codepaths preemptible.
> 

I suspected as much, these are not a problem.  The large latencies from
reading the /proc filesystem are a bit worrisome (trace1.txt), I will
report these again if they still happen with Q8.

Lee 

