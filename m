Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751553AbWDAQxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbWDAQxq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 11:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbWDAQxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 11:53:46 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:29894 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751082AbWDAQxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 11:53:46 -0500
Subject: Re: [patch 2.6.16-mm2 5/9] sched throttle tree extract - correct
	idle sleep logic
From: Lee Revell <rlrevell@joe-job.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1143881983.7617.41.camel@homer>
References: <1143880124.7617.5.camel@homer> <1143880397.7617.10.camel@homer>
	 <1143880683.7617.16.camel@homer>  <1143881058.7617.24.camel@homer>
	 <1143881494.7617.32.camel@homer>  <1143881983.7617.41.camel@homer>
Content-Type: text/plain
Date: Sat, 01 Apr 2006 11:53:35 -0500
Message-Id: <1143910416.2885.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-01 at 10:59 +0200, Mike Galbraith wrote:
> This patch corrects the idle sleep logic to place a long sleeping task
> into the runqueue at a barely interactive priority such that it can
> not destroy interactivity should it immediately begin consuming
> massive cpu. 

Did you test this extensively with bloated apps like Evolution and
Firefox that need to be scheduled as interactive tasks even though they
often peg the CPU?

Lee

