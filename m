Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267399AbUHPDgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267399AbUHPDgC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 23:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267400AbUHPDgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 23:36:02 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:34792 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267399AbUHPDfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 23:35:52 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816032806.GA11750@elte.hu>
References: <20040812235116.GA27838@elte.hu>
	 <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu>
	 <1092432929.3450.78.camel@mindpipe> <20040814072009.GA6535@elte.hu>
	 <20040815115649.GA26259@elte.hu> <20040816022554.16c3c84a@mango.fruits.de>
	 <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu>
Content-Type: text/plain
Message-Id: <1092627399.867.147.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 15 Aug 2004 23:36:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-15 at 23:28, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > I believe the constant-time behavior that I reported was an artifact
> > of ALSA xrun debugging.  Now it seems like the latency produced *does*
> > correspond directly to the amount of memory being mlockall'ed.  If
> > ./mlockall-test 1500 triggers an xrun at all it's ~0.2ms.  3000
> > triggers a ~1ms xrun, and 10000 a ~3 ms xrun.
> 
> could you try more extreme values - e.g. does 100 MB cause a 30 msec
> xrun?
> 

This causes a series of xruns, ranging from maybe 2 to 10ms.

Lee

